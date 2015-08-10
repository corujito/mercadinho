json.array!(@cards) do |card|
  json.extract! card, :id, :full_name, :identification, :password, :value, :discount
  json.url card_url(card, format: :json)
end
