class CleanupOldData < ActiveRecord::Migration[6.1]
  def change
    Command.where(name: ['runes', 'masteries']).destroy_all
    remove_column :settings, :voting_active, :boolean, default: false
    remove_column :settings, :voting_mods, :boolean, default: false
    remove_column :users, :summoner_name, :string
  end
end
