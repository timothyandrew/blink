class GoalsSummaryController < ApplicationController
  def index
    @skip_container = true
    @students = current_user.students
    @goals_matching_filter = apply_filters(Goal.where(student_id: @students))
  end

  private

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
