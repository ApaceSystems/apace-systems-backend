# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # All categories
    field :categories, [CategoryType], null: false

    # A single category by ID
    field :category, CategoryType, null: false do
      argument :id, ID, required: true
    end

    # All products in a category
    field :products, [ProductType], null: false do
      argument :category_id, ID, required: true
      # argument :category_id, ID, required: false
      argument :display_type, String, required: false
      argument :voltage, String, required: false
      argument :additional_features, String, required: false
      argument :sort_by, String, required: false
    end

    # A single product by ID
    field :product, ProductType, null: false do
      argument :id, ID, required: true
    end

    def categories
      Category.all
    end

    def category(id:)
      Category.find(id)
    end

    def products(category_id:, display_type: nil, voltage: nil, additional_features: nil, sort_by: nil)
      products = Category.find(category_id).products
      products = products.where("features->>'display_type' = ?", display_type) if display_type.present?
      products = products.where("features->>'voltage' = ?", voltage) if voltage.present?
      if additional_features.present?
        products = products.where("features->>'additional_features' ILIKE ?",
                                  "%#{additional_features}%")
      end
      products = products.order(price: :asc) if sort_by == 'price'
      products = products.order(name: :asc) if sort_by == 'name'
      products
    end

    def product(id:)
      Product.find(id)
    end
  end
end
