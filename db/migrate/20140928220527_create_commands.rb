class CreateCommands < ActiveRecord::Migration[4.2]
  def change
    create_table :commands do |t|
      t.integer :user_id
      t.string :name
      t.boolean :on
      t.boolean :admin
      t.integer :limit
    end
  end
end
