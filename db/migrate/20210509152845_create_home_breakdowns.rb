class CreateHomeBreakdowns < ActiveRecord::Migration[6.1]
  def change
    create_table :home_breakdowns do |t|
      t.boolean :show, null: false, default: true
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, null: true, foreign_key: true
      t.references :team, null: true, foreign_key: true
      t.timestamps
    end
  end
end
