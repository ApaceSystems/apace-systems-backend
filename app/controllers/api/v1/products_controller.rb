# frozen_string_literal: true

module Api
  module V1
    # Controller for managing products within the API v1.
    # Provides endpoints for listing products within a specific category and
    # retrieving individual product details.
    class Api::V1::ProductsController < ApplicationController
      def index
        @category = Category.find(params[:category_id])
        @products = @category.products
        render json: @products
      end

      def show
        @product = Product.find(params[:id])
        render json: @product
      end
    end
  end
end
