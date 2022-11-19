json.success 1 == 1
json.data do
  json.array! @messages do |message|
    json.body message.body
    json.from current_user.id == message.user_id
  end
end
