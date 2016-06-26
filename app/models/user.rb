class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  has_many :general_notes
  has_many :students
  has_many :lesson_plans
  has_many :picture_comprehension_exercises
  has_many :number_name_games
  has_many :worksheets

  def general_note_or_build
    self.general_note || self.build_general_note
  end
end
