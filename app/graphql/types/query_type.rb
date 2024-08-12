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
      argument :display_type, String, required: false
      argument :voltage, String, required: false
      argument :additional_features, String, required: false
      argument :color, String, required: false
      argument :sort_by, String, required: false, description: 'Options: price_asc, price_desc, name_asc, name_desc'
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

    def products(category_id:, display_type: nil, voltage: nil, additional_features: nil, color: nil, sort_by: nil)
      products = Category.find(category_id).products
      products = apply_filters(products, display_type, voltage, additional_features, color)
      apply_sorting(products, sort_by)
    end

    private

    def apply_filters(products, display_type, voltage, additional_features, color)
      products = products.where("features->>'display_type' ILIKE ?", "%#{display_type}%") if display_type.present?
      products = products.where("features->>'voltage' ILIKE ?", "%#{voltage}%") if voltage.present?
      if additional_features.present?
        additional_features.split(',').each do |feature|
          products = products.where("features->>'additional_features' ILIKE ?", "%#{feature.strip}%")
        end
      end
      products = products.where("features->>'color' ILIKE ?", "%#{color}%") if color.present?

      products
    end

    def apply_sorting(products, sort_by)
      case sort_by
      when 'price_asc'
        products.order(price: :asc)
      when 'price_desc'
        products.order(price: :desc)
      when 'name_asc'
        products.order(name: :asc)
      when 'name_desc'
        products.order(name: :desc)
      else
        products
      end
    end

    def product(id:)
      Product.find(id)
    end
  end
end
