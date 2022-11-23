class ChangeTextutilTextFromStringToText < ActiveRecord::Migration[4.2]
  def change
    change_column :textutils, :text, :text
  end
end
