class CreateCustomCommands < ActiveRecord::Migration
  def change
    create_table :custom_commands do |t|
      t.integer :twitch_id
      t.string :command_name
      t.string :trigger
      t.integer :limit
      t.boolean :admin
      t.string :output
    end
  end
end
