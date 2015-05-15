class StudentsController < ApplicationController
  decorates_assigned :student

  def index
    @students = current_user.students.all
  end

  def new
    @student = current_user.students.new
  end

  def edit
    @student = current_user.students.find(params[:id])
  end

  def show
    @student = current_user.students.find(params[:id])
  end

  def create
    @student = current_user.students.new(student_params)
    if @student.save
      flash[:notice] = "Student was created"
      redirect_to students_path
    else
      flash[:alert] = @student.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @student = current_user.students.find(params[:id])
    if @student.update_attributes(student_params)
      flash[:notice] = "Student was updated"
      redirect_to students_path
    else
      flash[:alert] = @student.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def student_params
    params.require(:student).permit(:name)
  end
end
