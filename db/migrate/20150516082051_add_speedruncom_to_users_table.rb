class AddSpeedruncomToUsersTable < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :speedruncom_nick, :string
  end
end
