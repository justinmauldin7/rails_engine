class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    revenue = Merchant.revenue_by_day(params[:date])
    render json: TotalRevenueSerializer.new(TotalRevenue.new(revenue))
  end

  def show
    merchant = Merchant.find(params[:id])
    revenue = merchant.revenue
    render json: TotalRevenueSerializer.new(TotalRevenue.new(revenue))
  end
end
