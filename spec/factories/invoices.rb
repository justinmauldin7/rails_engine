FactoryBot.define do
  factory :invoice do
    customer { nil }
    merchant { nil }
    status { "MyText" }
  end
end
