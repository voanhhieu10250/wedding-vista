class RemoveSlugFromServices < ActiveRecord::Migration[7.1]
  def change
    remove_column :services, :slug
  end
end
