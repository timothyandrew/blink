class Goal < ActiveRecord::Base
  acts_as_nested_set dependent: :destroy
  validates_presence_of :title
  validate :presence_of_start_and_end_date, :start_date_before_end_date,
           :start_and_end_dates_must_be_within_those_of_parent

  def presence_of_start_and_end_date
    # Up to the level of a weekly objective
    if self.depth < 4
      errors.add(:start, "can't be blank") if self.start.blank?
      errors.add(:end, "can't be blank") if self.end.blank?
    end
  end

  def start_date_before_end_date
    if self.start.present? && self.end.present?
      errors.add(:start, "can't be after end date") if self.start > self.end
    end
  end

  def start_and_end_dates_must_be_within_those_of_parent
    return if self.parent.blank?
    errors.add(:start, "can't be before parent's start date") if self.start.present? && self.start < self.parent.start
    errors.add(:end, "can't be after parent's end date") if self.end.present? && self.end > self.parent.end
  end

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
      self.descendants.update_all(completed: true)
    end
  end

  def uncomplete!
    transaction do
      self.update(completed: false)
      self.descendants.update_all(completed: false)
    end
  end


  def in?(goals)
    goals.any? { |goal| goal.id == self.id }
  end

  # Build a tree of all goals under the given `roots`.
  # Goals will be returned in the format: [goal, [child_goal, [grandchild_goal, [...]]]]
  def self.build_tree(roots)
    Goal.sort(roots).map do |root|
      grouped_goals = root.descendants.decorate.group_by(&:parent_id)
      [root.decorate, root._children(grouped_goals)]
    end
  end

  # Find the smallest possible tree of goals containing all the given goals, all their
  # ancestors, and all their descendants.
  # Goals will be returned in the format: [goal, [child_goal, [grandchild_goal, [...]]]]
  def self.build_tree_containing(goals)
    goals = goals.reduce([]) do |acc, goal|
      acc + (goal.self_and_descendants.decorate) + (goal.ancestors.decorate)
    end

    grouped_goals = goals.uniq(&:id).group_by(&:parent_id)
    roots = Goal.sort(grouped_goals[nil])
    roots.map { |root| [root.decorate, root._children(grouped_goals)] }
  end

  # In-memory version of `goal-children`. Requires a data-structure of pre-loaded
  # goals, in the format {1 => [goals with parent_id 1], 2 => [goals with parent_id 2]}
  def _children(grouped_goals)
    children = Goal.sort(grouped_goals[self.id])
    if children
      children.map { |child| [child, child._children(grouped_goals)] }
    else
      []
    end
  end
end
