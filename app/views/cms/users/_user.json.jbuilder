json.id user.id
json.first_name user.first_name
json.last_name user.last_name
json.email user.email
json.blocked user.blocked?
json.admin user.admin?
json.created_at user.created_at

json.photo do
  json.url user.photo.url
end
