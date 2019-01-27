class TotalRevenue < ApplicationRecord
  attr_reader :id, :total_revenue

  def initialize(revenue)
    @total_revenue = (revenue / 100.0)
  end
end
