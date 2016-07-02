desc "This task is called by the Heroku scheduler add-on"

task purge_db: :environment do
  months_ago = 3
  puts "Purge everything older than #{months_ago.to_i.months.ago}"
  puts "Total clients: #{Client.count}"
  puts "Total products: #{Product.count}"
  puts "Total cards: #{Card.count}"
  puts "Total vendors: #{Vendor.count}"

  Purchase.purge(months_ago.to_i)
  Order.purge(months_ago.to_i)
  Payment.purge(months_ago.to_i)
  InOutCard.purge(months_ago.to_i)
  CustomInput.purge(months_ago.to_i)

  puts "done."
end
