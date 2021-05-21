class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :title, null: false
      t.string :place_id, null: false

      t.index :place_id, unique: true

      t.timestamps
    end
  end
end
