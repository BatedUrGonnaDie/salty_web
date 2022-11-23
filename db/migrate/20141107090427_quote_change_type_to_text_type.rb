class QuoteChangeTypeToTextType < ActiveRecord::Migration[4.2]
  def change
    rename_column :quotes, :type, :text_type
  end
end
