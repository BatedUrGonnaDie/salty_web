class RemoveUserOauth < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :oauth
  end
end
