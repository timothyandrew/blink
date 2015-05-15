class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  has_one :general_note

  def general_note_or_build
    self.general_note || self.build_general_note
  end
end
