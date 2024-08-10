# frozen_string_literal: true

module Mutations
  class DeleteProduct < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :message, String, null: true
    # field :errors, [String], null: false

    def resolve(id:)
      product = Product.find(id)

      product.destroy!
      { success: true, message: 'Product deleted successfully' }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new('Product not found')
    end
    # if product.destroy
    #   { success: true, errors: [] }
    # else
    #   { success: false, errors: product.errors.full_messages }
    # end
  end
end
