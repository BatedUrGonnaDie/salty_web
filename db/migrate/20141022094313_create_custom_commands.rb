class CreateCustomCommands < ActiveRecord::Migration
  def change
    create_table :custom_commands do |t|
      t.integer :user_id
      t.string :name
      t.string :trigger
      t.boolean :on
      t.boolean :admin
      t.integer :limit
      t.string :output
    end
  end
end
