json.success 1 == 1
json.data do
  json.array! @messages do |message|
    json.body message.body
    json.from message.user_id
  end
end