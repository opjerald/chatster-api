json.success 1 == 1
json.data do
  json.array! @rooms, partial: "users/user", as: :room
end
