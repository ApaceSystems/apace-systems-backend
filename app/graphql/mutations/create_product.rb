# frozen_string_literal: true

module Mutations
  class CreateProduct < BaseMutation
    argument :name, String, required: true
    argument :description, String, required: false
    argument :price, Float, required: false
    argument :category_id, ID, required: true
    argument :features, GraphQL::Types::JSON, required: false

    field :product, Types::ProductType, null: true

    def resolve(name:, category_id:, description: nil, price: nil, features: nil)
      product = Product.create!(
        name:,
        description:,
        price:,
        category_id:,
        features:
      )
      { product: }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Failed to create product: #{e.message}")
    end
  end
end
