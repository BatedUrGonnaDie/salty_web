class QuoteChangeTypeToTextType < ActiveRecord::Migration
  def change
    rename_column :quotes, :type, :text_type
  end
end
