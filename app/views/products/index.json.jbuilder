json.array!(@products) do |product|
  json.extract! product, :id, :full_name, :unity
  json.url product_url(product, format: :json)
end
