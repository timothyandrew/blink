class ShortTermGoalsController < ApplicationController
  before_filter :assign_long_term_goal

  def index
    @short_term_goals = @long_term_goal.short_term_goals
  end

  def new
    @short_term_goal= @long_term_goal.short_term_goals.new
  end

  def edit
    @short_term_goal = @long_term_goal.short_term_goals.find(params[:id])
  end

  def show
    @short_term_goal = @long_term_goal.short_term_goals.find(params[:id])
  end

  def create
    @short_term_goal = @long_term_goal.short_term_goals.new(short_term_goal_params)
    if @short_term_goal.save
      redirect_to student_long_term_goal_short_term_goal_path(@student, @long_term_goal, @short_term_goal)
    else
      render :new
    end
  end

  def update
    @short_term_goal = @long_term_goal.short_term_goals.find(params[:id])
    if @short_term_goal.update_attributes(short_term_goal_params)
      redirect_to student_long_term_goal_short_term_goal_path(@student, @long_term_goal, @short_term_goal)
    else
      render :edit
    end
  end

  private

  def assign_long_term_goal
    @student = Student.find(params[:student_id])
    @long_term_goal = @student.long_term_goals.find(params[:long_term_goal_id])
  end

  def short_term_goal_params
    params.require(:short_term_goal).permit(:name, :description, :start, :end)
  end
end
