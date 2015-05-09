class Student < ActiveRecord::Base
  has_many :goals
  validates_presence_of :name
end
