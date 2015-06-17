class AddElcColumnsToLessonPlanItems < ActiveRecord::Migration
  def change
    add_column :lesson_plan_items, :elc_data, :json
    add_column :lesson_plan_items, :theme, :text
  end
end
