class PictureComprehensionExercisesController < ApplicationController
  def index
    @picture_comprehension_exercises = current_user.picture_comprehension_exercises.order(created_at: :desc)
  end

  def new
    @picture_comprehension_exercise = current_user.picture_comprehension_exercises.new
    @picture_comprehension_exercise.images.new
  end

  def edit
    @picture_comprehension_exercise = current_user.picture_comprehension_exercises.find(params[:id])
  end

  def show
    @picture_comprehension_exercise = current_user.picture_comprehension_exercises.find(params[:id])
  end

  def create
    @picture_comprehension_exercise = current_user.picture_comprehension_exercises.new(picture_comprehension_exercise_params)
    if @picture_comprehension_exercise.save_with_images(picture_comprehension_images_params)
      flash[:notice] = "Picture comprehension was created."
      redirect_to picture_comprehension_exercise_path(@picture_comprehension_exercise)
    else
      flash[:alert] = @picture_comprehension_exercise.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @picture_comprehension_exercise = current_user.picture_comprehension_exercises.find(params[:id])
    @picture_comprehension_exercise.assign_attributes(picture_comprehension_exercise_params)
    if @picture_comprehension_exercise.save_with_images(picture_comprehension_images_params)
      flash[:notice] = "Picture comprehension was edited"
      redirect_to picture_comprehension_exercise_path(@picture_comprehension_exercise)
    else
      flash[:alert] = @picture_comprehension_exercise.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @picture_comprehension_exercise = current_user.picture_comprehension_exercises.find(params[:id])
    @picture_comprehension_exercise.destroy
    flash[:notice] = "Picture comprehension was destroyed! Take that, Rakshitha!"
    redirect_to picture_comprehension_exercises_path
  end

  def reorder
    @picture_comprehension_exercise = current_user.picture_comprehension_exercises.find(params[:id])
    PictureComprehensionImage.order_sequentially!(@picture_comprehension_exercise.images, params[:image_ids])
    respond_to do |format|
      format.json { render json: {status: :success} }
      format.html { render :index }
    end
  end


  private

  def picture_comprehension_exercise_params
    params.require(:picture_comprehension_exercise).permit(:name)
  end

  def picture_comprehension_images_params
    params.require(:images)
  end
end
