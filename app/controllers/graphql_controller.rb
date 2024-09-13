# frozen_string_literal: true

# GraphqlController handles all incoming GraphQL queries and mutations for the application.
#
# It provides an interface to the GraphQL schema and executes the requested operations
# while logging key information for debugging purposes.
class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Executes the incoming GraphQL query or mutation.
  #
  # result of the GraphQL query/mutation execution.
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {}

    log_graphql_request(query, variables, operation_name, params, request)

    result = ApaceSystemsBackendSchema.execute(query, variables:, context:, operation_name:)

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

  def log_graphql_request(query, variables, operation_name, params, request)
    log_graphql_query(query)
    log_graphql_variables(variables)
    log_graphql_operation_name(operation_name)
    log_graphql_params(params)
    log_graphql_headers(request)
    log_graphql_body(request)
  end

  def log_graphql_query(query)
    Rails.logger.info "GraphQL Query: #{query.inspect}"
  end

  def log_graphql_variables(variables)
    Rails.logger.info "GraphQL Variables: #{variables.inspect}"
  end

  def log_graphql_operation_name(operation_name)
    Rails.logger.info "GraphQL Operation Name: #{operation_name.inspect}"
  end

  def log_graphql_params(params)
    Rails.logger.info "GraphQL Params: #{params.inspect}"
  end

  def log_graphql_headers(request)
    headers = request.headers.to_h.select { |k, _v| k.start_with?('HTTP_') }
    Rails.logger.info "GraphQL Headers: #{headers.inspect}"
  end

  def log_graphql_body(request)
    Rails.logger.info "GraphQL Body: #{request.body.read.inspect}"
  end

  # Prepares the variables for the GraphQL query.
  #
  # @param variables_param [ActionController::Parameters, Hash, String, nil] The variables passed in with the query.
  # @return [Hash] The prepared variables as a hash.
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
