class AddSpeedruncomToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :speedruncom_nick, :string
  end
end
