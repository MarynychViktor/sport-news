class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.boolean :hidden, default: false
      t.integer :priority, null: false
      t.index :priority, unique: true
      t.timestamps
    end
  end
end
