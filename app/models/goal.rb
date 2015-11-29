class Goal < ActiveRecord::Base
  include OrderSequentially

  belongs_to :student

  acts_as_nested_set dependent: :destroy
  #validates_presence_of :title
  #validate :start_date_before_end_date

  audited associated_with: :student

  belongs_to :category, class_name: GoalCategory
  delegate :name, to: :category, allow_nil: true, prefix: true

  # Return true if this is not the final level (Activity)
  def not_final_level?
    self.depth < 5
  end

  def start_date_before_end_date
    if self.start.present? && self.end.present?
      errors.add(:start, "can't be after end date") if self.start > self.end
    end
  end

  def save_with_category(params, parent, category_name)
    transaction do
      self.parent = @parent if parent
      self..assign_attributes(params)
      self.category = GoalCategory.find_or_create_by!(name: category_name) if category_name.present?
      self.save!
    end
  end

  def self.sort(goals)
    return if goals.nil?
    goals.sort_by do |goal|
      # Doing `to_s` here because ruby refuses to sort booleans
      [goal.completed?.to_s, goal.position, goal.title]
    end
  end

  def sorted_children
    GoalDecorator.decorate_collection(Goal.sort(self.children))
  end

  # Migrate a goal, along with its children, to a new student, keeping all
  # relationships intact (relatively).
  def duplicate_tree!(new_student)
    transaction do
      new_goal = self.dup
      new_goal.update(student_id: new_student.id)
      self.children.each { |child| new_goal.children << child.duplicate_tree!(new_student) }
      new_goal
    end
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
