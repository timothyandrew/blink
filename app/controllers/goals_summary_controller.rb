class GoalsSummaryController < ApplicationController
  def index
    @skip_container = true
    @students = current_user.students
  end
end
