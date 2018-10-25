class AddTokenToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :token, :string
    add_index :teams, :token, unique: true
  end
end
