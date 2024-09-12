# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category

  # Scopes
  scope :priced_above, ->(price) { where('price >= ?', price) }
  scope :priced_below, ->(price) { where('price <= ?', price) }
  scope :with_color, ->(color) { where("features->>'color' ILIKE ?", "%#{color}%") }
  scope :with_display_type, ->(display_type) { where("features->>'display_type' ILIKE ?", "%#{display_type}%") }
  scope :with_voltage, ->(voltage) { where("features->>'voltage' ILIKE ?", "%#{voltage}%") }
  scope :with_additional_features, lambda { |features|
    where("features->>'additional_features' ILIKE ALL (ARRAY[?])", features.map { |f| "%#{f.strip}%" })
  }

  # Validations
  validates :name, presence: true, length: { minimum: 1, maximum: 255 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Serialize features as JSON
  serialize :features, coder: JSON
end
