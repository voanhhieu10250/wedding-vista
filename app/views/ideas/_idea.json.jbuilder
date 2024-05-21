json.extract! idea, :id, :title, :description, :body, :vendor_id, :topic_id, :created_at, :updated_at
json.url idea_url(idea, format: :json)
json.body idea.body.to_s
