# frozen_string_literal: true

class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    result = execute_graphql_query(params)
    Rails.logger.info "GraphQL Result: #{result.to_h}"
    render json: result
  rescue StandardError => e
    handle_error(e)
  end

  private

  def execute_graphql_query(params)
    query = params[:query]
    variables = prepare_variables(params[:variables])
    operation_name = params[:operationName]
    context = {}

    log_graphql_request(query, variables, operation_name, params)

    ApaceSystemsBackendSchema.execute(query, variables:, context:, operation_name:)
  end

  def log_graphql_request(query, variables, operation_name, params)
    Rails.logger.info "GraphQL Query: #{query}"
    Rails.logger.info "GraphQL Variables: #{variables}"
    Rails.logger.info "GraphQL Operation Name: #{operation_name}"
    Rails.logger.info "Received GraphQL request: #{params.inspect}"
    Rails.logger.info "GraphQL Request Headers: #{request.headers.to_h.select { |k, _v| k.start_with?('HTTP_') }}"
    Rails.logger.info "GraphQL Request Body: #{request.body.read}"
  end

  def prepare_variables(variables_param)
    case variables_param
    when String
      parse_variables(variables_param)
    when Hash, ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def parse_variables(variables_param)
    return {} unless variables_param.present?

    JSON.parse(variables_param) || {}
  end

  def handle_error(error)
    Rails.logger.error "GraphQL Error: #{error.message}"
    Rails.logger.error error.backtrace.join("\n")

    error_response = { errors: [{ message: error.message, backtrace: error.backtrace }], data: {} }
    render json: error_response, status: 500

    handle_error_in_development(error) if Rails.env.development?
  end

  def handle_error_in_development(error)
    raise error if Rails.env.development?
  end
end
