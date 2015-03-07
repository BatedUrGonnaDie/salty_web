class RemoveUserOauth < ActiveRecord::Migration
  def change
    remove_column :users, :oauth
  end
end
