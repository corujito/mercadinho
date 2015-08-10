json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :vendor_id, :total_price
  json.url purchase_url(purchase, format: :json)
end
