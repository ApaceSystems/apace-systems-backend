# frozen_string_literal: true

# Category model represents a category of products in the system.
#
# A Category can have many associated products and contains key information such as:
# - Name: A unique identifier for the category.
# - Description: A text description of the category.
#
# == Associations:
# - Has many products
#
# == Validations:
# - Name must be present and unique.
class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  # Scopes
  scope :with_name, ->(name) { where('name ILIKE ?', "%#{name}%") }
  scope :with_description, ->(description) { where('description ILIKE ?', "%#{description}%") }

  # Validations
  validates :name, presence: true, uniqueness: true
end
