class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    revenue = Merchant.revenue_by_day(params[:date])
    render json: TotalRevenueSerializer.new(TotalRevenue.new(revenue))
  end

  def show
    if params[:date]
      merchant = Merchant.find(params[:id])
      revenue = merchant.single_revenue_by_day(params[:date])
      render json: RevenueSerializer.new(Revenue.new(revenue))
    else
      merchant = Merchant.find(params[:id])
      revenue = merchant.revenue
      render json: RevenueSerializer.new(Revenue.new(revenue))
    end
  end
end
