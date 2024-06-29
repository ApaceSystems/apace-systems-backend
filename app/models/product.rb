# frozen_string_literal: true

# Represents a product that can be purchased.

# Attributes:
#   - name (string, required): The name of the product.
#   - price (decimal, optional): The price of the product.
#   - features (JSON, optional): Additional features of the product, stored as a JSON object.
# Relationships:
#   - belongs_to :category: The category to which this product belongs.
# Validations:
#   - name:
#     - must be present
#   - price:
#     - must be a number greater than or equal to 0
#     - can be nil (if the product has no price)
class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  serialize :features, JSON
end
