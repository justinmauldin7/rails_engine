class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    merchant = Merchant.find(params[:id]).invoices
    render json: InvoiceSerializer.new(merchant)
  end
end
