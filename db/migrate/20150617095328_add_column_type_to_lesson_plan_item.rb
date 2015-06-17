class AddColumnTypeToLessonPlanItem < ActiveRecord::Migration
  def up
    add_column :lesson_plan_items, :type, :string, default: "RegularLessonPlanItem"
    execute "UPDATE lesson_plan_items SET type = 'RegularLessonPlanItem'"
  end

  def down
    remove_column :lesson_plan_items, :type
  end
end
