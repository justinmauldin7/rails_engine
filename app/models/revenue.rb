class Revenue < ApplicationRecord
  attr_reader :id, :revenue

  def initialize(revenue)
    @revenue = (revenue / 100.00).to_s
  end
end
