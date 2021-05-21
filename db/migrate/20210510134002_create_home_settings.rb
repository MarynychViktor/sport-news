class CreateHomeSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :home_settings do |t|
      t.boolean :show_popular_articles, null: false, default: true
      t.boolean :show_commented_articles, null: false, default: true
      t.string :popular_articles_period, null: false, default: 'day'
      t.string :commented_articles_period, null: false, default: 'day'
      t.timestamps
    end
  end
end
