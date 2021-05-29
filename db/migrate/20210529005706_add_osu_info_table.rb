class AddOsuInfoTable < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :map_name
      t.string :map_id
      t.string :set_id

      t.timestamps
    end
  end
end
