class LongTermGoal < ActiveRecord::Base
  belongs_to :student
  has_many :short_term_goals
end
