require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :items }
  end

  describe "class methods" do
    before :each do
      @customer_1 = create(:customer, first_name: "One")
      @customer_2 = create(:customer, first_name: "Two")
      @customer_3 = create(:customer, first_name: "Three")

      @merchant_1 = create(:merchant, name: "Merchant One")
      @merchant_2 = create(:merchant, name: "Merchant Two")
      @merchant_3 = create(:merchant, name: "Merchant Three")

      @item_1 = create(:item, merchant_id: @merchant_1.id, unit_price: 100)
      @item_2 = create(:item, merchant_id: @merchant_2.id, unit_price: 200)
      @item_3 = create(:item, merchant_id: @merchant_3.id, unit_price: 300)

      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer_1.id)
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 100)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 200)
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 300)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
      @transaction_2 = create(:transaction, invoice_id: @invoice_1.id)


      @invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer_2.id, created_at: "2012-03-27 14:54:00 UTC")
      @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 100)
      @invoice_item_5 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 200)
      @invoice_item_6 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 300)
      @transaction_3 = create(:transaction, invoice_id: @invoice_2.id)
      @transaction_4 = create(:transaction, invoice_id: @invoice_2.id)

      @invoice_3 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer_3.id, created_at: "2012-03-27 14:54:00 UTC")
      @invoice_item_7 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: 100)
      @invoice_item_8 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 50, unit_price: 200)
      @transaction_5 = create(:transaction, invoice_id: @invoice_3.id)
      @transaction_6 = create(:transaction, invoice_id: @invoice_3.id)
    end

    it ".most_revenue" do
      number = 2
      merchants = Merchant.most_revenue(number)

      expect(merchants[0]).to eq(@merchant_3)
      expect(merchants[1]).to eq(@merchant_1)
    end

    it ".most_items" do
      number = 2
      merchants = Merchant.most_items(number)

      expect(merchants[0]).to eq(@merchant_3)
      expect(merchants[1]).to eq(@merchant_1)
    end

    it ".revenue_by_day" do
      date = "2012-03-27"
      total_revenue = Merchant.revenue_by_day(date)

      expect(total_revenue/100.0).to eq(284.00)
    end
  end

  describe "instance methods" do
    before :each do
      @customer_1 = create(:customer, first_name: "One")
      @customer_2 = create(:customer, first_name: "Two")
      @customer_3 = create(:customer, first_name: "Three")

      @merchant_1 = create(:merchant, name: "Merchant One")
      @merchant_2 = create(:merchant, name: "Merchant Two")
      @merchant_3 = create(:merchant, name: "Merchant Three")

      @item_1 = create(:item, merchant_id: @merchant_1.id, unit_price: 100)
      @item_2 = create(:item, merchant_id: @merchant_2.id, unit_price: 200)
      @item_3 = create(:item, merchant_id: @merchant_3.id, unit_price: 300)

      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer_1.id)
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 100)
      @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 200)
      @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 300)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
      @transaction_2 = create(:transaction, invoice_id: @invoice_1.id)


      @invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer_2.id, created_at: "2012-03-27 14:54:00 UTC")
      @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 100)
      @invoice_item_5 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 200)
      @invoice_item_6 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 300)
      @transaction_3 = create(:transaction, invoice_id: @invoice_2.id)
      @transaction_4 = create(:transaction, invoice_id: @invoice_2.id)

      @invoice_3 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer_3.id, created_at: "2012-03-27 14:54:00 UTC")
      @invoice_item_7 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: 100)
      @invoice_item_8 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 50, unit_price: 200)
      @transaction_5 = create(:transaction, invoice_id: @invoice_3.id)
      @transaction_6 = create(:transaction, invoice_id: @invoice_3.id)
    end

    it ".revenue" do
      total_revenue = @merchant_1.revenue

      expect(total_revenue/100.0).to eq(386)
    end

    it ".single_revenue_by_day" do
      date = "2012-03-27"
      total_revenue = @merchant_1.single_revenue_by_day(date)

      expect(total_revenue/100.0).to eq(284.00)
    end

    it ".favorite_customer" do
      invoice_2 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer_2.id, created_at: "2012-03-27 14:54:00 UTC")
      invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 100)
      invoice_item_5 = create(:invoice_item, item_id: @item_2.id, invoice_id: invoice_2.id, quantity: 5, unit_price: 200)
      invoice_item_6 = create(:invoice_item, item_id: @item_3.id, invoice_id: invoice_2.id, quantity: 10, unit_price: 300)
      transaction_3 = create(:transaction, invoice_id: invoice_2.id)
      transaction_4 = create(:transaction, invoice_id: invoice_2.id)
      transaction_5 = create(:transaction, invoice_id: invoice_2.id)
      transaction_6 = create(:transaction, invoice_id: invoice_2.id)

      customer = @merchant_3.favorite_customer

      expect(customer.id).to eq(@customer_2.id)
      expect(customer.first_name).to eq(@customer_2.first_name)
      expect(customer.last_name).to eq(@customer_2.last_name)
    end
  end
end
