class CreatePictureComprehensionExercises < ActiveRecord::Migration
  def change
    create_table :picture_comprehension_exercises do |t|
      t.text :name
      t.references :user, foreign_key: true, index: true
      t.timestamps null: false
    end
  end
end
