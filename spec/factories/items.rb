FactoryBot.define do
  factory :item do
    merchant
    name { Faker::StarWars.vehicle }
    description { Faker::StarWars.quote }
    unit_price { 100..100000 }
  end
end
