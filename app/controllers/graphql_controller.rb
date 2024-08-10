# frozen_string_literal: true

class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {}

    Rails.logger.info "GraphQL Query: #{query}"
    Rails.logger.info "GraphQL Variables: #{variables}"
    Rails.logger.info "GraphQL Operation Name: #{operation_name}"

    result = ApaceSystemsBackendSchema.execute(query, variables:, context:,
                                                      operation_name:)

    Rails.logger.info "GraphQL Result: #{result.to_h}"
    render json: result
  rescue StandardError => e
    handle_error(e)
  end

  private

  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error(e)
    Rails.logger.error "GraphQL Error: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")

    error_response = { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }
    render json: error_response, status: 500

    handle_error_in_development(e) if Rails.env.development?
  end

  def handle_error_in_development(e)
    raise e if Rails.env.development?
  end
end
