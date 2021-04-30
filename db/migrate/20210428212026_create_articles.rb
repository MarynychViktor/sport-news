class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :conference, null: false
      t.string :team, null: false
      t.string :location, null: false
      t.string :headline, null: false
      t.string :alt, null: false
      t.string :caption, null: false
      t.text :content, null: false
      t.string :picture, null: false
      t.boolean :display_comments, default: true

      t.timestamps
    end
  end
end
