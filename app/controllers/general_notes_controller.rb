class GeneralNotesController < ApplicationController
  def edit
    @note = GeneralNote.first_or_initialize
  end

  def show
    @note = GeneralNote.first_or_initialize
  end

  def update
    @note = GeneralNote.first_or_initialize
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
