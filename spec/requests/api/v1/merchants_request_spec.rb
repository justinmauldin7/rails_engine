require 'rails_helper'

describe "Merchants API" do
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

  it "sends a list of merchants" do
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)["data"]

    expect(merchants.count).to eq(3)
  end

  it "can return one merchant by its id" do
    id = @merchant_1.id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["id"].to_i).to eq(id)
  end

  it "can find merchant by id" do
    get "/api/v1/merchants/find?id=#{@merchant_1.id}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["id"].to_i).to eq(@merchant_1.id)
  end

  it "can find merchant by name" do
    get "/api/v1/merchants/find?name=#{@merchant_1.name}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["name"]).to eq(@merchant_1.name)
  end

  it "can find first merchant by created_at" do
    date = "2012-03-27 14:54:00 UTC"
    merchant_1 = create(:merchant, created_at: date)

    get "/api/v1/merchants/find?created_at=#{date}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["id"]).to eq(merchant_1.id)
  end

  it "can find first merchant by updated_at" do
    date = "2012-03-27 14:54:00 UTC"
    merchant_1 = create(:merchant, updated_at: date)

    get "/api/v1/merchants/find?updated_at=#{date}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["id"]).to eq(merchant_1.id)
  end

  it "can find all merchants by id" do
    get "/api/v1/merchants/find_all?id=#{@merchant_1.id}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
  end

  it "can find all merchants by name" do
    create(:merchant, name: "Merchant One")

    get "/api/v1/merchants/find_all?name=#{@merchant_1.name}"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(2)
    expect(merchants[0]["attributes"]["name"]).to eq(@merchant_1.name)
    expect(merchants[1]["attributes"]["name"]).to eq(@merchant_1.name)
  end

  it "can find first merchant by created_at" do
    date = "2012-03-27 14:54:00 UTC"
    merchant_1 = create(:merchant, created_at: date)
    merchant_2 = create(:merchant, created_at: date)
    merchant_3 = create(:merchant, created_at: date)

    get "/api/v1/merchants/find_all?created_at=#{date}"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
    expect(merchants[0]["id"].to_i).to eq(merchant_1.id)
    expect(merchants[1]["id"].to_i).to eq(merchant_2.id)
    expect(merchants[2]["id"].to_i).to eq(merchant_3.id)
  end

  it "can find first merchant by updated_at" do
    date = "2012-01-2 14:54:00 UTC"
    merchant_1 = create(:merchant, updated_at: date)
    merchant_2 = create(:merchant, updated_at: date)
    merchant_3 = create(:merchant, updated_at: date)

    get "/api/v1/merchants/find_all?updated_at=#{date}"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
    expect(merchants[0]["id"].to_i).to eq(merchant_1.id)
    expect(merchants[1]["id"].to_i).to eq(merchant_2.id)
    expect(merchants[2]["id"].to_i).to eq(merchant_3.id)
  end

  xit "can reutn list of items for one merchant" do
    item_2 = create(:item, merchant_id: @merchant_1.id, unit_price: 100)
    item_3 = create(:item, merchant_id: @merchant_1.id, unit_price: 100)

    get "/api/v1/merchants/#{@merchant_1.id}/items"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(items[0]["id"].to_i).to eq(item_1.id)
    expect(items[1]["id"].to_i).to eq(item_2.id)
    expect(items[2]["id"].to_i).to eq(item_3.id)
  end

  it "can return top merchants with most revenue" do
    number = 2

    get "/api/v1/merchants/most_revenue?quantity=#{number}"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(number)
    expect(merchants.first["id"].to_i).to eq(@merchant_3.id)
    expect(merchants.last["id"].to_i).to eq(@merchant_1.id)
  end

  it "can return top merchants with x number of items sold" do
    number = 2

    get "/api/v1/merchants/most_items?quantity=#{number}"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(number)
    expect(merchants.first["id"].to_i).to eq(@merchant_3.id)
    expect(merchants.last["id"].to_i).to eq(@merchant_1.id)
  end

  it "can return total revenue across all merchants for a specific date" do
    date = "2012-03-27"

    get "/api/v1/merchants/revenue?date=#{date}"

    total_revenue = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(total_revenue["attributes"]["total_revenue"].to_i).to eq(284.00)
  end

  it "can return total revenue for single merchant" do
    id = @merchant_1.id

    get "/api/v1/merchants/#{id}/revenue"

    total_revenue = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(total_revenue["attributes"]["total_revenue"].to_i).to eq(386)
  end
end
