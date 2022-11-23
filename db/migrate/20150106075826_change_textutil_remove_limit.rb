class ChangeTextutilRemoveLimit < ActiveRecord::Migration[4.2]
  def change
    change_column :textutils, :text, :text, limit: nil
  end
end
