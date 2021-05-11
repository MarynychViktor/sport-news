class CreateHomeArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :home_articles do |t|
      t.boolean :show, null: false, default: true
      t.references :article, null: false, foreign_key: true
      t.timestamps
    end
  end
end
