class ChangeTextutilTextFromStringToText < ActiveRecord::Migration
  def change
    change_column :textutils, :text, :text
  end
end
