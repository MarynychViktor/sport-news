class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.boolean :hidden, default: false
      t.integer :priority, null: false
      t.boolean :static, default: false
      t.timestamps

      t.index :priority, unique: true
    end
  end
end
