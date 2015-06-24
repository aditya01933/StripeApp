json.array!(@events) do |event|
  json.extract! event, :id, :name, :ticket_cost
  json.url event_url(event, format: :json)
end
