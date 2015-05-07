class Student < ActiveRecord::Base
  has_many :long_term_goals
end
