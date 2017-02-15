class AddHelpTextToCustomCommands < ActiveRecord::Migration[5.0]
  def change
    add_column :custom_commands, :help_text, :string
  end
end
