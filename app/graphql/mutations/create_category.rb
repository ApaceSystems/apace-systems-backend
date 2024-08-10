# frozen_string_literal: true

module Mutations
  class CreateCategory < BaseMutation
    argument :input, Types::CategoryInputType, required: true

    field :category, Types::CategoryType, null: true
    field :errors, [String], null: false

    def resolve(input:)
      category = Category.new(input.to_h)
      if category.save
        { category:, errors: [] }
      else
        { category: nil, errors: category.errors.full_messages }
      end
    end
  end
end
# module Mutations
#   class CreateCategory < BaseMutation
#     argument :input, Types::CategoryInputType, required: true

#     field :category, Types::CategoryType, null: true
#     field :errors, [String], null: false

#     def resolve(input:)
#       category = Category.new(input.to_h)
#       if category.save
#         { category:, errors: [] }
#       else
#         { category: nil, errors: category.errors.full_messages }
#       end
#     end
#   end
# end
