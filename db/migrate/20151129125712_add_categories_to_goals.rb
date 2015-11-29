class AddCategoriesToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :category_id, :integer
    add_foreign_key :goals, :goal_categories, column: :category_id, primary_key: :id
  end
end
