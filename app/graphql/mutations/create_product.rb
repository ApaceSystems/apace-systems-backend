# frozen_string_literal: true

module Mutations
  class CreateProduct < BaseMutation
    argument :input, Types::ProductInputType, required: true

    field :product, Types::ProductType, null: true
    field :errors, [String], null: false

    def resolve(input:)
      product = Product.new(input.to_h)
      if product.save
        { product:, errors: [] }
      else
        { product: nil, errors: product.errors.full_messages }
      end
    end
  end
end
