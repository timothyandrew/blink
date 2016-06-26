class WorksheetsController < ApplicationController
  def index
    @worksheets = current_user.worksheets.order(date: :desc)
  end

  def new
    @worksheet = current_user.worksheets.new
  end

  def edit
    @worksheet = current_user.worksheets.find(params[:id])
  end

  def create
    @worksheet = current_user.worksheets.new(worksheet_params)
    if @worksheet.save
      flash[:notice] = "Worksheet was created"
      redirect_to worksheets_path
    else
      flash[:alert] = @worksheet.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @worksheet = current_user.worksheets.find(params[:id])
    if @worksheet.update_attributes(worksheet_params)
      flash[:notice] = "Worksheet was edited"
      redirect_to worksheets_path
    else
      flash[:alert] = @worksheet.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @worksheet = current_user.worksheets.find(params[:id])
    @worksheet.destroy
    flash[:notice] = "Worksheet was destroyed!"
    redirect_to worksheets_path
  end

  private

  def worksheet_params
    params.require(:worksheet).permit(:date, :topic, :description, :attachment)
  end

  def worksheet_items_params
    params.require(:worksheet).permit(items: [:subject, :start, :end, :id])[:items]
  end

  def render_with_update_errors
    if params[:quick_edit].present?
      render :quick_edit
    else
      render :edit
    end
  end
end
