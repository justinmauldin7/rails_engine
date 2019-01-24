class Merchant < ApplicationRecord

  def most_revenue(count)
    require "pry", binding.pry
    Merchant.joins(items: :invoice_items)
      .select('merchants.*, sum(invoice_items.quantity) as total_items')
      .where('transactions.status = ?', 'shipped')
      .order('total_items desc')
      .group(:id)
      .limit(count)
  end

end
