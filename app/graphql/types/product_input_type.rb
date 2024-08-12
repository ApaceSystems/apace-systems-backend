# frozen_string_literal: true

module Types
  class ProductInputType < Types::BaseInputObject
    argument :name, String, required: true
    argument :description, String, required: false
    argument :price, Float, required: false
    argument :features, GraphQL::Types::JSON, required: false
    argument :category_id, ID, required: true
  end
end
