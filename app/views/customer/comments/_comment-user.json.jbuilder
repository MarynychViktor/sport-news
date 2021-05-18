json.user do
  json.id user.id
  json.first_name user.first_name
  json.last_name user.last_name
  json.email user.email
  json.photo do
    json.url user.photo.url
  end
  json.created_at user.created_at
end
