json.extract! idea, :id, :title, :description, :content, :vendor_id, :topic_id, :created_at, :updated_at
json.url idea_url(idea, format: :json)
json.content idea.content.to_s
