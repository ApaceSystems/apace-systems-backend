# frozen_string_literal: true

module Api
  module V1
    # Controller for managing categories within the API v1.
    # Provides endpoints for listing all categories and
    # retrieving individual categories with their associated products.
    class Api::V1::CategoriesController < ApplicationController
      def index
        @categories = Category.all
        render json: @categories
      end

      def show
        @category = Category.find(params[:id])
        render json: @category, include: :products
      end
    end
  end
end
