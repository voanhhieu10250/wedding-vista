class ChangeDefaultPublicValueToServices < ActiveRecord::Migration[7.1]
  def up
    change_column :services, :published, :boolean, default: false
    Service.where(published: nil).update_all(published: false)
  end

  def down
    change_column :services, :published, :boolean, default: nil
  end

  def change
    up_lambda = -> { up }
    down_lambda = -> { down }

    reversible do |dir|
      dir.up do
        up_lambda.call
      end

      dir.down do
        down_lambda.call
      end
    end
  end
end
