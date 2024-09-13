# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # All categories
    field :categories, [CategoryType], null: false

    # A single category by ID
    field :category, CategoryType, null: false do
      argument :id, ID, required: true
    end

    # All products in a category with filters
    field :products, [ProductType], null: false do
      argument :category_id, ID, required: true
      argument :filters, GraphQL::Types::JSON, required: false
      argument :sort_by, String, required: false, description: 'Options: price_asc, price_desc, name_asc, name_desc'
    end

    def categories
      Category.all
    end

    def category(id:)
      Category.find(id)
    end

    def products(category_id:, filters: {}, sort_by: nil)
      products = Category.find(category_id).products
      products = apply_filters(products, filters)
      apply_sorting(products, sort_by)
    end

    private

    def apply_filters(products, filters)
      products = filter_by_display_type(products, filters[:display_type]) if filters[:display_type].present?
      products = filter_by_voltage(products, filters[:voltage]) if filters[:voltage].present?
      if filters[:additional_features].present?
        products = filter_by_additional_features(products,
                                                 filters[:additional_features])
      end
      products = filter_by_color(products, filters[:color]) if filters[:color].present?
      products
    end

    def filter_by_display_type(products, display_type)
      products.with_display_type(display_type)
    end

    def filter_by_voltage(products, voltage)
      products.with_voltage(voltage)
    end

    def filter_by_additional_features(products, additional_features)
      products.with_additional_features(additional_features.split(','))
    end

    def filter_by_color(products, color)
      products.with_color(color)
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
  end
end
