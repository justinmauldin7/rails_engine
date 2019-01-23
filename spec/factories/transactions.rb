FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { 1 }
    credit_card_experation_date { "2019-01-23" }
    result { "MyText" }
  end
end
