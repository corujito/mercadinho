json.array!(@custom_inputs) do |custom_input|
  json.extract! custom_input, :id, :amount, :description, :type
  json.url custom_input_url(custom_input, format: :json)
end
