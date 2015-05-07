class LongTermGoalsController < ApplicationController
  before_filter :assign_student

  def index
    @long_term_goals = @student.long_term_goals
  end

  def new
    @long_term_goal= @student.long_term_goals.new
  end

  def edit
    @long_term_goal = @student.long_term_goals.find(params[:id])
  end

  def show
    @long_term_goal = @student.long_term_goals.find(params[:id])
  end

  def create
    @long_term_goal = @student.long_term_goals.new
    @long_term_goal.assign_attributes(long_term_goal_params)
    puts long_term_goal_params
    puts @long_term_goal.attributes
    if @long_term_goal.save
      flash[:notice] = "Long term goal was created"
      redirect_to student_long_term_goal_path(@student, @long_term_goal)
    else
      flash[:alert] = @long_term_goal.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @long_term_goal = @student.long_term_goals.find(params[:id])
    if @long_term_goal.update_attributes(long_term_goal_params)
      flash[:notice] = "Long term goal was edited"
      redirect_to student_long_term_goal_path(@student, @long_term_goal)
    else
      flash[:alert] = @long_term_goal.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def assign_student
    @student = Student.find(params[:student_id])
  end

  def long_term_goal_params
    params.require(:long_term_goal).permit(:name, :description, :start, :end)
  end
end
