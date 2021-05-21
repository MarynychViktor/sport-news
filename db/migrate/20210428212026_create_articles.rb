class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :location
      t.string :headline, null: false
      t.string :alt, null: false
      t.string :caption, null: false
      t.text :content, null: false
      t.string :picture, null: false
      t.boolean :display_comments, null: false, default: true
      t.datetime :published_at
      t.string :slug, null: false
      t.index :slug, unique: true
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, null: true, foreign_key: true
      t.references :team, null: true, foreign_key: true

      t.timestamps
    end
  end
end
