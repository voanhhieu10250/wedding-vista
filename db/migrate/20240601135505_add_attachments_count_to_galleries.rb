class AddAttachmentsCountToGalleries < ActiveRecord::Migration[7.1]
  def change
    add_column :galleries, :attachments_count, :integer, default: 0
  end
end
