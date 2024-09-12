# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'Test Product' }
    description { 'This is a test product.' }
    price { 9.99 }
    category
    features { { 'color' => 'blue', 'size' => 'medium' } }
  end
end
