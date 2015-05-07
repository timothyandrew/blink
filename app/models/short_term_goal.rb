class ShortTermGoal < ActiveRecord::Base
  belongs_to :long_term_goal

  validates_presence_of :name, :start, :end
end
