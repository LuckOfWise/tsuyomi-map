class CreateStrengths < ActiveRecord::Migration[5.1]
  def change
    create_table :strengths do |t|
      t.references :user, foreign_key: true
      t.string :nature
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
