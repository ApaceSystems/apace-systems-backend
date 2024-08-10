# frozen_string_literal: true

module Mutations
  class DeleteCategory < BaseMutation
    argument :id, ID, required: true
    field :success, Boolean, null: false
    field :message, String, null: true
    def resolve(id:)
      category = Category.find(id)
      category.destroy!
      { success: true, message: 'Category deleted successfully' }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new('Category not found')
    end
  end
end
