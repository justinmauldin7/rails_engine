class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id]).items
    render json: ItemSerializer.new(merchant)
  end
end
