FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Number.number(16) }
    credit_card_experation_date { Faker::Date.between(5.days.ago, Date.today) }
    result { Faker::StarWars.call_number }
  end
end
