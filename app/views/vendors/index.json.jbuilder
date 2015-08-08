json.array!(@vendors) do |vendor|
  json.extract! vendor, :id, :full_name, :email, :phone, :address
  json.url vendor_url(vendor, format: :json)
end
