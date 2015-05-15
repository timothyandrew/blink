class Goal < ActiveRecord::Base
  acts_as_nested_set
  validates_presence_of :title

  def self.sort(goals)
    goals.sort_by do |goal|
      # Doing `to_s` here because ruby refuses to sort booleans
      [goal.completed?.to_s, (goal.start || Date.new)]
    end
  end

  def sorted_children
    GoalDecorator.decorate_collection(Goal.sort(self.children))
  end
end
