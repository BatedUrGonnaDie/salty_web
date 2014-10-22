class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.integer :user_id
      t.string :command_name
      t.string :on
      t.boolean :admin
      t.integer :limit
    end
  end
end
