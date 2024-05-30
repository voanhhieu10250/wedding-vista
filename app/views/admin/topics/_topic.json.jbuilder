json.extract! topic, :id, :name, :description, :topic_category_id, :created_at, :updated_at
json.url topic_url(topic, format: :json)
