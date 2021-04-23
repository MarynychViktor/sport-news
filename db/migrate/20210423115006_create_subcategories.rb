class CreateSubcategories < ActiveRecord::Migration[6.1]
  def change
    create_table :subcategories do |t|
      t.string :name, null: false
      t.references :category, null: false, foreign_key: true
      t.boolean :hidden, default: false
      t.timestamps

      t.index %i[name category_id], unique: true
    end
  end
end
