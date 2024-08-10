# frozen_string_literal: true

# Represents a category of products.
# Attributes:
#   - name (string, required): The name of the category.
# Relationships:
#   - has_many :products: The products belonging to this category.
# Validations:
#   - name:
#     - must be present
#     - must be unique
class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  # after_commit :broadcast_update

  # private

  # def broadcast_update
  #   ApaceSystemsBackendSchema.subscriptions.trigger('categoryUpdated', {}, self)
  # end
end
