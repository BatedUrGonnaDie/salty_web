class RenameQuotesAndChangeColumnName < ActiveRecord::Migration[4.2]
  def change
    rename_column :quotes, :text_type, :type
    rename_table :quotes, :textutils
  end
end
