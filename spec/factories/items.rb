FactoryBot.define do
  factory :item do
    merchant { nil }
    name { "MyText" }
    description { "MyText" }
    unit_price { 1 }
  end
end
