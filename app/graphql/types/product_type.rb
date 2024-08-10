# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :price, Float, null: true
    field :features, GraphQL::Types::JSON, null: true
    field :category, Types::CategoryType, null: true
    # field :image_url, String, null: true

    # def image_url
    #   Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
    # end
  end
end
