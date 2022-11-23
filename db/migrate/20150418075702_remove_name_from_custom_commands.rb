class RemoveNameFromCustomCommands < ActiveRecord::Migration[4.2]
  def change
    remove_column :custom_commands, :name
    change_column_default :custom_commands, :limit, 30
  end
end
