FactoryBot.define do
  factory :invoice do
    merchant
    customer
    status { Faker::StarWars.call_number }
  end
end
