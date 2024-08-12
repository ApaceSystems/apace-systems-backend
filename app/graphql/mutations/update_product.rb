# frozen_string_literal: true

module Mutations
  class UpdateProduct < BaseMutation
    argument :input, Types::ProductInputType, required: true
    argument :id, ID, required: true

    field :product, Types::ProductType, null: true
    field :errors, [String], null: false

    def resolve(input:, id:)
      product = Product.find_by(id:)
      return { product: nil, errors: ['Product not found'] } unless product

      if product.update(input.to_h)
        { product:, errors: [] }
      else
        { product: nil, errors: product.errors.full_messages }
      end
    end
  end
end
