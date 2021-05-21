class CreateHomePhotoOfTheDays < ActiveRecord::Migration[6.1]
  def change
    create_table :home_photo_of_the_days do |t|
      t.string :image, null: false
      t.string :title, null: false
      t.string :alt, null: false
      t.string :description, null: false
      t.string :author, null: false
      t.boolean :show, null: false, default: true
      t.timestamps
    end
  end
end
