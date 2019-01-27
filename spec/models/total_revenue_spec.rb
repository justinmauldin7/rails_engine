require 'rails_helper'

RSpec.describe TotalRevenue, type: :model do
  describe 'methods' do
    it '.total_revenue' do
      revenue = 28000
      total_revenue = TotalRevenue.new(revenue)

      expect(total_revenue.total_revenue).to eq("280.0")
    end
  end
end
