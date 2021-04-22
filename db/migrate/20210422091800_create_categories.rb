class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.references :parent, null: true, foreign_key: { to_table: :categories }
      t.boolean :hidden, default: false
      t.timestamps

    end
  end
end
