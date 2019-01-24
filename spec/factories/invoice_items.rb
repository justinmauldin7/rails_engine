FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 1..10 }
    unit_price { 100..100000 }
  end
end
