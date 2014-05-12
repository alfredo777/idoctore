json.array!(@users) do |user|
  json.extract! user, :id, :name, :hashed_password, :salt, :email, :register, :confirmed_token, :confirmed
  json.url user_url(user, format: :json)
end
