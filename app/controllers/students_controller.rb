class StudentsController < ApplicationController
  decorates_assigned :student

  def index
    @students = current_user.students.order(:position).all
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

  def destroy
    @student = current_user.students.find(params[:id])
    @student.destroy
    redirect_to students_path, notice: "Student deleted."
  end

  def reorder
    Student.order_sequentially!(current_user.students.all, params[:student_ids])
    respond_to do |format|
      format.json { render json: {status: :success} }
      format.html { render :index }
    end
  end

  private

  def student_params
    params.require(:student).permit(:name)
  end
end
