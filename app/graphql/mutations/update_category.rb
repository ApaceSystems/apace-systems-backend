# frozen_string_literal: true

module Mutations
  class UpdateCategory < BaseMutation
    argument :input, Types::CategoryInputType, required: true
    argument :id, ID, required: true

    field :category, Types::CategoryType, null: true
    field :errors, [String], null: false

    def resolve(input:, id:)
      category = Category.find_by(id:)
      return { category: nil, errors: ['Category not found'] } unless category

      if category.update(input.to_h)
        { category:, errors: [] }
      else
        { category: nil, errors: category.errors.full_messages }
      end
    end
  end
end
