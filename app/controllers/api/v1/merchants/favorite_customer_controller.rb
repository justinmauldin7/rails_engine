class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    favorite_customer = merchant.favorite_customer
    render json: CustomerSerializer.new(favorite_customer)
  end
end
