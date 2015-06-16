class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  has_many :general_notes
  has_many :students
  has_many :lesson_plans

  def general_note_or_build
    self.general_note || self.build_general_note
  end
end
