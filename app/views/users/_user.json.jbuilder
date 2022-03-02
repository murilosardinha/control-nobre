json.extract! user, :id, :name, :role, :filial_id, :created_at, :updated_at
json.url user_url(user, format: :json)
