class CreatePictureComprehensionImages < ActiveRecord::Migration
  def change
    create_table :picture_comprehension_images do |t|
      t.string :image
      t.references :picture_comprehension_exercise, foreign_key: true, column: :exercise_id, index: {name: "picture_comp_index"}
      t.timestamps null: false
    end
  end
end
