require 'rails_helper'

describe "Merchants API" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @customer_1 = create(:customer)

    @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant_1)
    @invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant_2)
    @invoice_3 = create(:invoice, customer: @customer_1, merchant: @merchant_3)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_3)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 4)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 8)
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 2)

    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)
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

  # it "can return top merchants with most revenue" do
  #   number = 3
  #
  #   get "/api/v1/merchants/most_revenue?quantity=#{number}"
  #
  #   merchants = JSON.parse(response.body)["data"]
  #
  #   expect(response).to be_successful
  #   expect(merchants.most_revenue.first).to eq(@merchant_1)
  #   expect(merchants.most_revenue.last).to eq(@merchant_3)
  # end
end
