class GoalsSummaryController < ApplicationController
  def index
    @container_classes = "full-width"
    @students = current_user.students
    if filters_present?
      @goals_matching_filter = apply_filters(Goal.where(student_id: @students))
      @goals = Goal.build_tree_containing(@goals_matching_filter.where(student_id: @students))
    else
      @goals = Goal.build_tree(Goal.roots.where(student_id: @students.pluck(:id)))
    end
  end

  private

  def filters_present?
    params[:start].present? || params[:end].present?
  end

  def apply_filters(goals)
    if params[:start].present?
      goals = goals.where(['start >= ?', DateTime.parse(params[:start])])
    end

    if params[:end].present?
      goals = goals.where(['"end" <= ?', DateTime.parse(params[:end])])
    end

    goals
  end
end
