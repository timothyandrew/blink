class Goal < ActiveRecord::Base
  acts_as_nested_set dependent: :destroy
  validates_presence_of :title

  def self.sort(goals)
    return if goals.nil?
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


  def in?(goals)
    goals.any? { |goal| goal.id == self.id }
  end

  def self.build_tree(roots)
    Goal.sort(roots).map do |root|
      grouped_goals = root.descendants.decorate.group_by(&:parent_id)
      [root.decorate, root._children(grouped_goals)]
    end
  end

  def self.build_tree_containing(goals)
    goals = goals.reduce([]) do |acc, goal|
      acc + (goal.self_and_descendants.decorate) + (goal.ancestors.decorate)
    end

    grouped_goals = goals.uniq(&:id).group_by(&:parent_id)
    roots = Goal.sort(grouped_goals[nil])
    Goal.build_tree(roots)
  end

  def _children(grouped_goals)
    children = Goal.sort(grouped_goals[self.id])
    if children
      children.map { |child| [child, child._children(grouped_goals)] }
    else
      []
    end
  end
end
