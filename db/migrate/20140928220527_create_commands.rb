class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.integer :twitch_id
      t.string :name
      t.string :on
      t.boolean :admin
      t.integer :limit
    end
  end
end
