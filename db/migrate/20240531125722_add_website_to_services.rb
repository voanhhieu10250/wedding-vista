class AddWebsiteToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :website, :string
  end
end
