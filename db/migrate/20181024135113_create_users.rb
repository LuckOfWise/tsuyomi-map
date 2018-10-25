class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.string :email
      t.string :icon_url

      t.timestamps
    end
  end
end
