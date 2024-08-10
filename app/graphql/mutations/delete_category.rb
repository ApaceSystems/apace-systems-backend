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

# module Mutations
#   class DeleteCategory < BaseMutation
#     argument :id, ID, required: true

#     field :success, Boolean, null: false
#     field :message, String, null: true
#     # field :errors, [String], null: false

#     def resolve(id:)
#       category = Category.find(id)
#       # return { success: false, errors: ["Category not found"] } unless category

#       category.destroy!
#       { success: true, message: 'Category deleted successfully' }
#     rescue ActiveRecord::RecordNotFound
#       GraphQL::ExecutionError.new('Category not found')
#     end

#     # if category.destroy
#     #   { success: true, errors: [] }
#     # else
#     #   { success: false, errors: category.errors.full_messages }
#     # end
#   end
# end
