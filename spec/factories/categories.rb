# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'Test Category' }
    description { 'This is a test category.' }
  end
end
