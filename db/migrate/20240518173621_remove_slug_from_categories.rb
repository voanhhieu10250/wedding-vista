class RemoveSlugFromCategories < ActiveRecord::Migration[7.1]
  def change
    remove_column :categories, :slug
  end
end
