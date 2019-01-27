class Api::V1::Merchants::SearchController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find_by(merchant_params))
  end

  def index

    if merchant_params[:id]
      render json: MerchantSerializer.new(Merchant.where(id: merchant_params[:id]))
    elsif merchant_params[:name]
      render json: MerchantSerializer.new(Merchant.where(name: merchant_params[:name]))
    elsif merchant_params[:created_at]
      render json: MerchantSerializer.new(Merchant.where(created_at: merchant_params[:created_at]))
    elsif merchant_params[:updated_at]
      render json: MerchantSerializer.new(Merchant.where(updated_at: merchant_params[:updated_at]))
    end
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
