class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :conference
      t.string :team
      t.string :location
      t.string :headline, null: false
      t.string :alt, null: false
      t.string :caption, null: false
      t.text :content, null: false
      t.string :picture, null: false
      t.boolean :display_comments, default: true
      t.string :slug, null: false
      t.index :slug, unique: true

      t.timestamps
    end
  end
end
