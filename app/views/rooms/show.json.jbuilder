json.success 1 == 1
json.data do
  json.room do
    json.partial! "rooms/room", room: @room
  end
  json.messages do
    json.array! @messages do |message|
      json.from_self current_user.id == message.user_id
      json.body message.body
    end
  end
end