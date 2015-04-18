class RemoveNameFromCustomCommands < ActiveRecord::Migration
  def change
    remove_column :custom_commands, :name
    change_column_default :custom_commands, :limit, 30
  end
end
