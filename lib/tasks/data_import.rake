require 'csv'

desc "Imports all files into table"
  task import_all: [:customer_import, :merchant_import, :invoice_import,
                    :item_import, :invoice_items_import, :transactions_import]

desc "Imports customers into table"
  task :customer_import => :environment do
    CSV.foreach('./lib/data/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_h)
    end
    puts "Import of Customers was successful!"
end

desc "Imports merchants into table"
  task :merchant_import => :environment do
    CSV.foreach('./lib/data/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_h)
    end
    puts "Import of Merchants was successful!"
end

desc "Imports invoices into table"
  task :invoice_import => :environment do
    CSV.foreach('./lib/data/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_h)
    end
    puts "Import of Invoices was successful!"
end

desc "Imports items into table"
  task :item_import => :environment do
    CSV.foreach('./lib/data/items.csv', :headers => true) do |row|
      Item.create!(row.to_h)
    end
    puts "Import of Items was successful!"
end

desc "Imports invoice_items into table"
  task :invoice_items_import => :environment do
    CSV.foreach('./lib/data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    puts "Import of Invoice_Items was successful!"
end

desc "Imports transactions into table"
  task :transactions_import => :environment do
    CSV.foreach('./lib/data/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_h)
    end
    puts "Import of Transactions was successful!"
end
