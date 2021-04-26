class CreateSubcategories < ActiveRecord::Migration[6.1]
  def change
    create_table :subcategories do |t|
      t.string :name, null: false
      t.references :category, null: false, foreign_key: true
      t.integer :priority, null: false, unique: true
      t.boolean :hidden, default: false
      t.timestamps

      t.index %i[priority category_id], unique: true
      t.index %i[name category_id], unique: true
    end
  end
end
