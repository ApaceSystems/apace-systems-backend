# frozen_string_literal: true

module Mutations
  class DeleteProduct < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :message, String, null: true

    def resolve(id:)
      product = Product.find_by(id:)
      return { success: false, message: 'Product not found' } unless product

      if product.destroy
        { success: true, message: 'Product deleted successfully' }
      else
        { success: false, message: product.errors.full_messages.join(', ') }
      end
    end
  end
end
