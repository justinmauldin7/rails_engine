require 'rails_helper'

RSpec.describe Revenue, type: :model do
  describe 'methods' do
    it '.revenue' do
      revenue = 28000
      revenue = Revenue.new(revenue)

      expect(revenue.revenue).to eq("280.0")
    end
  end
end
