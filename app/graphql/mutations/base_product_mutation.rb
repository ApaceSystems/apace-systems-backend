# frozen_string_literal: true

module Mutations
  class BaseProductMutation < BaseMutation
    field :product, Types::ProductType, null: true
    field :errors, [String], null: false

    def handle_product_result(product)
      if product.save
        { product:, errors: [] }
      else
        { product: nil, errors: product.errors.full_messages }
      end
    end
  end
end
