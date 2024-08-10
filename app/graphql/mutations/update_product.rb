# frozen_string_literal: true

module Mutations
  class UpdateProduct < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :description, String, required: false
    argument :price, Float, required: false
    argument :category_id, ID, required: false
    argument :features, GraphQL::Types::JSON, required: false

    field :product, Types::ProductType, null: true

    def resolve(id:, **attributes)
      product = Product.find(id)
      product.update!(attributes)
      { product: }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new('Product not found')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Failed to update product: #{e.message}")
    end
  end
end
