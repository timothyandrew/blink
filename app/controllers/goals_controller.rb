class GoalsController < ApplicationController
  before_filter :assign_student

  def new
    @goal= @student.goals.new
  end

  def edit
    @goal = @student.goals.find(params[:id])
  end

  def create
    @goal = @student.goals.new
    @goal.assign_attributes(goal_params)
    puts goal_params
    puts @goal.attributes
    if @goal.save
      flash[:notice] = "Long term goal was created"
      redirect_to student_path(@student)
    else
      flash[:alert] = @goal.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @goal = @student.goals.find(params[:id])
    if @goal.update_attributes(goal_params)
      flash[:notice] = "Long term goal was edited"
      redirect_to student_path(@student)
    else
      flash[:alert] = @goal.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def assign_student
    @student = Student.find(params[:student_id])
  end

  def goal_params
    params.require(:goal).permit(:title, :description, :start, :end)
  end
end
