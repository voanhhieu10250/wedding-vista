json.extract! gallery, :id, :service_id, :name, :items, :created_at, :updated_at
json.url gallery_url(gallery, format: :json)
json.items do
  json.array!(gallery.items) do |item|
    json.id item.id
    json.url url_for(item)
  end
end
