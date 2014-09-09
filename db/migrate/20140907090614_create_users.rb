class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitch_name
      t.integer :twitch_id
      t.string :oauth
      t.string :email

      t.timestamps
    end
  end
end
