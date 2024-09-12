# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  # Scopes
  scope :with_name, ->(name) { where('name ILIKE ?', "%#{name}%") }
  scope :with_description, ->(description) { where('description ILIKE ?', "%#{description}%") }

  # Validations
  validates :name, presence: true, uniqueness: true
end
