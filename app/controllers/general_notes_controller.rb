class GeneralNotesController < ApplicationController
  def edit
    @note = current_user.general_note_or_build
  end

  def show
    @note = current_user.general_note_or_build
  end

  def update
    @note = current_user.general_note_or_build
    if @note.update_attributes(note_params)
      flash[:notice] = "Updated general notes."
      redirect_to notes_path
    else
      flash[:alert] = @note.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def note_params
    params.require(:general_note).permit(:text)
  end
end
