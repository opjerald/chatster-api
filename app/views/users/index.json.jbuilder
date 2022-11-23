json.success 1 == 1
json.data do
  json.array! @users, partial: "users/user", as: :user
end
