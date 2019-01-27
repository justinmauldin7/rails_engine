class Api::V1::Merchants::RevenueController < ApplicationController
  def index
#require "pry", binding.pry
    revenue = Merchant.revenue_by_day(params[:date])
    render json: TotalRevenueSerializer.new(TotalRevenue.new(revenue))
  end
end
