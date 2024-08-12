# frozen_string_literal: true

class ApaceSystemsBackendSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batch-loading
  use GraphQL::Dataloader

  # Union and Interface Resolution
  def self.resolve_type(_abstract_type, obj, _ctx)
    case obj
    when Product
      Types::ProductType
    when Category
      Types::CategoryType
    else
      raise(GraphQL::RequiredImplementationMissingError, "Unexpected object: #{obj}")
    end
  end

  # Relay-style Object Identification:
  max_query_string_tokens(5000)
  validate_max_errors(100)
  # Return a string UUID for object
  def self.id_from_object(object, _typedefinition, _queryctx)
    object.to_gid_param
  end

  # Given a string UUID, find the object
  def self.object_from_id(global_id, _queryctx)
    GlobalID.find(global_id)
  end
end
