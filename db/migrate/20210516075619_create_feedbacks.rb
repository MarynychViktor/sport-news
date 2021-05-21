class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.boolean :positive, default: true
      t.bigint :feedbackable_id
      t.string :feedbackable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
