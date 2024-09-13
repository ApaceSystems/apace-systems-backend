# frozen_string_literal: true

# GraphQL type representing a Category in the system.
#
# This type is used to define the structure of a Category object in GraphQL queries and mutations.
#
# == Fields:
# - id: The unique identifier of the category.
# - name: The name of the category.
# - description: The description of the category.
# - products: A list of products associated with the category.
module Types
  class CategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :products, [Types::ProductType], null: true
  end
end
