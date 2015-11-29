class CreateGoalCategories < ActiveRecord::Migration
  def change
    create_table :goal_categories do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
