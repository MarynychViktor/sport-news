class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.boolean :edited, null: false, default: false
      t.integer :children_count, default: 0
      t.references :parent, null: true, foreign_key: { to_table: :comments }
      t.references :thread, null: true, foreign_key: { to_table: :comments }
      t.references :user, null: false, foreign_key: true
      t.bigint :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end
