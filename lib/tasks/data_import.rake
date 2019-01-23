require 'csv'

desc "Imports customers into table"
  task :customer_import => :environment do
    CSV.foreach('./lib/data/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_h)
    end
end

desc "Imports merchants into table"
  task :merchant_import => :environment do
    CSV.foreach('./lib/data/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_h)
    end
end

desc "Imports invoices into table"
  task :invoice_import => :environment do
    CSV.foreach('./lib/data/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_h)
    end
end

desc "Imports items into table"
  task :item_import => :environment do
    CSV.foreach('./lib/data/items.csv', :headers => true) do |row|
      Item.create!(row.to_h)
    end
end

desc "Imports invoice_items into table"
  task :invoice_items_import => :environment do
    CSV.foreach('./lib/data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_h)
    end
end
