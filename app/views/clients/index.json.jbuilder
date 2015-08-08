json.array!(@clients) do |client|
  json.extract! client, :id, :full_name, :email, :phone, :address, :active
  json.url client_url(client, format: :json)
end
