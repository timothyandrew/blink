class StudentNotesController < ApplicationController
  before_filter :assign_student
  decorates_assigned :student

  def edit
  end

  def show
  end

  def update
    if @student.update_attributes(notes_params)
      flash[:notice] = "Updated notes."
      redirect_to student_notes_path(@student)
    else
      flash[:alert] = @student.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def notes_params
    params.require(:student).permit(:notes)
  end
end
