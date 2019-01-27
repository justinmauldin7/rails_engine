class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def self.most_revenue(count)
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as invoice_total')
      .where('transactions.result = ?', 'success')
      .group('merchants.id')
      .order('invoice_total desc')
      .limit(count)
  end

  def self.most_items(count)
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .select('merchants.*, sum(invoice_items.quantity) as item_count')
      .where('transactions.result = ?', 'success')
      .group('merchants.id')
      .order('item_count desc')
      .limit(count)
  end

  def self.revenue_by_day(day)
    day_start = day + " 00:00:00 UTC"
    day_end = day + " 23:59:59 UTC"

    Merchant.joins(invoices: [:invoice_items, :transactions])
           .where('transactions.result = ?', 'success')
           .where('invoices.created_at BETWEEN ? AND ?', day_start, day_end)
           .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def revenue
    Merchant.joins(invoices: [:invoice_items, :transactions])
           .where('transactions.result = ?', 'success')
           .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
