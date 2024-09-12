# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  # has_one_attached :image

  validates :name, presence: true, length: { minimum: 1, maximum: 255 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  serialize :features, coder: JSON
end
