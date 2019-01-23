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
