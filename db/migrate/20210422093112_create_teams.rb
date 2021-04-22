class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.index :name,  unique: true
      t.references :category, null: false, foreign_key: true
      t.boolean :hidden, default: false
      t.timestamps
    end
  end
end
