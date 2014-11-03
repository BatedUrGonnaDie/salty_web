class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :user_id
      t.string  :type
      t.boolean :reviewed
      t.string  :text
      t.timestamps
    end
  end
end
