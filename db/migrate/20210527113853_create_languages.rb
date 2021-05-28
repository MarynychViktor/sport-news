class CreateLanguages < ActiveRecord::Migration[6.1]
  def change
    create_table :languages do |t|
      t.string :locale, null: false
      t.text :translation
      t.boolean :hidden, default: false
      t.boolean :system, default: false

      t.timestamps
    end
    add_index :languages, :locale, unique: true
  end
end
