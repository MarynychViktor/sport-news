class ArticlesLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :articles_locations do |t|
      t.bigint :article_id, null: false
      t.bigint :location_id, null: false
    end

    add_index :articles_locations, [:article_id, :location_id], unique: true
  end
end
