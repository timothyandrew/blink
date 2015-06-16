class GeneralNotesController < ApplicationController
  def index
    @notes = GeneralNoteDecorator.decorate_collection(current_user.general_notes.order(updated_at: :desc))
  end

  def new
    @note = current_user.general_notes.new.decorate
  end

  def create
    @note = current_user.general_notes.new
    @note.assign_attributes(note_params)
    if @note.save
      redirect_to notes_path, notice: "Note created."
    else
      flash[:alert] = @note.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @note = current_user.general_notes.find(params[:id]).decorate
  end

  def show
    @note = current_user.general_notes.find(params[:id]).decorate
  end

  def update
    @note = current_user.general_notes.find(params[:id])
    if @note.update_attributes(note_params)
      flash[:notice] = "Updated note."
      redirect_to notes_path
    else
      flash[:alert] = @note.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @note = current_user.general_notes.find(params[:id])
    @note.destroy
    flash[:notice] = "Note was destroyed! Take that, Rakshitha!"
    redirect_to notes_path
  end

  private

  def note_params
    params.require(:general_note).permit(:text, :title)
  end
end
