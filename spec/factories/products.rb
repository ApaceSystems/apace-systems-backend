FactoryBot.define do
  factory :product do
    name { 'Sample Product' }
    description { 'Sample Product Description' }
    price { 99.99 }
    association :category
  end
end
