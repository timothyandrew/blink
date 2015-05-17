class Goal < ActiveRecord::Base
  acts_as_nested_set dependent: :destroy
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

  def complete!
    transaction do
      self.update(completed: true)
      self.children.update_all(completed: true)
    end
  end

  def uncomplete!
    transaction do
      self.update(completed: false)
      self.children.update_all(completed: false)
    end
  end

  def in_tree_of?(others)
    others.any? do |other|
      self.is_ancestor_of?(other) || self.is_descendant_of?(other) || self.id == other.id
    end
  end

  def in?(goals)
    goals.any? { |goal| goal.id == self.id }
  end
end
