# frozen_string_literal: true

module Mutations
  class DeleteCategory < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :message, String, null: true

    def resolve(id:)
      category = Category.find(id)
      if category.destroy
        { success: true, message: 'Category deleted successfully' }
      else
        { success: false, message: category.errors.full_messages.join(', ') }
      end
    rescue ActiveRecord::RecordNotFound
      { success: false, message: 'Category not found' }
    end
  end
end
