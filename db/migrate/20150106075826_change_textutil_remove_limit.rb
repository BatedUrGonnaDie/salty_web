class ChangeTextutilRemoveLimit < ActiveRecord::Migration
  def change
    change_column :textutils, :text, :text, limit: nil
  end
end
