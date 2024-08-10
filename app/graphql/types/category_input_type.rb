# frozen_string_literal: true

module Types
  class CategoryInputType < Types::BaseInputObject
    argument :name, String, required: true
    argument :description, String, required: false
  end
end
