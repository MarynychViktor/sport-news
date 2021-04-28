class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.references :subcategory, null: false, foreign_key: true
      t.integer :row_order
      t.boolean :hidden, default: false
      t.timestamps
      t.index %i[name subcategory_id], unique: true
    end
  end
end
