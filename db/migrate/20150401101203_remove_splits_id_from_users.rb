class RemoveSplitsIdFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :splits_io_id
  end
end
