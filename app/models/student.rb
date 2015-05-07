class Student < ActiveRecord::Base
  has_many :long_term_goals
  validates_presence_of :name
end
