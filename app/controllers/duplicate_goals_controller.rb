class DuplicateGoalsController < ApplicationController
  before_filter :assign_student

  def new
    @goal = @student.goals.find(params[:id])
  end

  def create
    target = current_user.students.find(params[:target])
    from = @student.goals.find(params[:id])
    if @goal = from.duplicate_tree!(target)
      redirect_to student_goal_path(target, @goal), notice: "Duplicated sucessfully."
    else
      flash[:alert] = @goal.errors.full_messages.to_sentence
      render :new
    end
  end
end
