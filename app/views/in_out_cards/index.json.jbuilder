json.array!(@in_out_cards) do |in_out_card|
  json.extract! in_out_card, :id, :card_id
  json.url in_out_card_url(in_out_card, format: :json)
end
