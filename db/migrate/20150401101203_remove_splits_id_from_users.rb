class RemoveSplitsIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :splits_io_id
  end
end
