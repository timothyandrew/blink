class StudentsController < ApplicationController
  decorates_assigned :student

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def show
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:notice] = "Student was created"
      redirect_to students_path
    else
      flash[:alert] = @student.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @student = Student.find(params[:id])
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
