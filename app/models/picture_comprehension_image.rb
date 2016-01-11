class PictureComprehensionImage < ActiveRecord::Base
  include OrderSequentially
  belongs_to :exercise, foreign_key: "picture_comprehension_exercise_id", class_name: PictureComprehensionExercise
  mount_uploader :image, PictureComprehensionImageUploader
end
