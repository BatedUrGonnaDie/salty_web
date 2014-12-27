class RenameQuotesAndChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :quotes, :text_type, :type
    rename_table :quotes, :textutils
  end
end
