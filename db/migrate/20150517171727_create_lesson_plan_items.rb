class CreateLessonPlanItems < ActiveRecord::Migration
  def change
    create_table :lesson_plan_items do |t|
      t.time :start
      t.time :end
      t.string :subject
      t.string :topic
      t.text :goals
      t.text :teaching_method
      t.text :teaching_aids
      t.references :lesson_plan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
