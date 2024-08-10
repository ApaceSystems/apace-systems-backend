# frozen_string_literal: true

module Mutations
  class UpdateCategory < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :description, String, required: false
    field :category, Types::CategoryType, null: true
    def resolve(id:, name: nil, description: nil)
      category = Category.find(id)
      category.update!(name:, description:)
      { category: }
    rescue ActiveRecord::RecordNotFound
      GraphQL::ExecutionError.new('Category not found')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Failed to update category: #{e.message}")
    end
  end
end
