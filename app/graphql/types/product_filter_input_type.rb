# frozen_string_literal: true

module Types
  class ProductFilterInputType < Types::BaseInputObject
    argument :display_type, String, required: false
    argument :voltage, String, required: false
    argument :additional_features, String, required: false
    argument :color, String, required: false
    argument :sort_by, String, required: false
  end
end
