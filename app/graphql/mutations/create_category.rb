# frozen_string_literal: true

module Mutations
  class CreateCategory < BaseMutation
    argument :name, String, required: true
    argument :description, String, required: false

    field :category, Types::CategoryType, null: true

    def resolve(name:, description: nil)
      category = Category.create!(name:, description:)
      { category: }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Failed to create category: #{e.message}")
    end
  end
end
