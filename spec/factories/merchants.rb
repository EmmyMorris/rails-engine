FactoryBot.define do
  factory :merchant do
    name { Faker::Company.unique.name }
  end
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Commerce.price }
    merchant
  end
end
