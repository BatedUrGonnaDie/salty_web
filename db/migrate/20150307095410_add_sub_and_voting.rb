class AddSubAndVoting < ActiveRecord::Migration
  def change
    add_column :settings, :sub_message_active, :boolean, default: false
    add_column :settings, :sub_message_text, :string, default: ""
    add_column :settings, :sub_message_resub, :string, default: ""
    add_column :settings, :voting_active, :boolean, default: false
    add_column :settings, :voting_mods, :boolean, default: false
  end
end
