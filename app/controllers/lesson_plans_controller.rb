class LessonPlansController < ApplicationController
  def index
    @grouped_lesson_plans = current_user.lesson_plans.order(date: :desc).grouped_by_month_and_week
  end

  def new
    @duplicate_from = params[:duplicate_from]
    @lesson_plan = current_user.lesson_plans.new
  end

  def edit
    @lesson_plan = current_user.lesson_plans.find(params[:id])
  end

  def show
    @lesson_plan = current_user.lesson_plans.find(params[:id])
    @items = @lesson_plan.items.order(start: :asc)
  end

  def create
    @lesson_plan = current_user.lesson_plans.new(lesson_plan_params)
    if @lesson_plan.save
      if params[:duplicate_from]
        duplicate_from = current_user.lesson_plans.find(params[:duplicate_from])
        @lesson_plan.duplicate!(duplicate_from)
      end
      flash[:notice] = "Lesson plan was created"
      redirect_to lesson_plan_path(@lesson_plan)
    else
      flash[:alert] = @lesson_plan.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @lesson_plan = current_user.lesson_plans.find(params[:id])
    if @lesson_plan.update_attributes_with_children(lesson_plan_params, lesson_plan_items_params)
      flash[:notice] = "Lesson plan was edited"
      redirect_to lesson_plan_path(@lesson_plan)
    else
      flash[:alert] = @lesson_plan.errors.full_messages.to_sentence
      render_with_update_errors
    end
  end

  def destroy
    @lesson_plan = current_user.lesson_plans.find(params[:id])
    @lesson_plan.destroy
    flash[:notice] = "Lesson plan was destroyed! Take that, Rakshitha!"
    redirect_to lesson_plans_path
  end

  def quick_edit
    @lesson_plan = current_user.lesson_plans.find(params[:id])
  end

  private

  def lesson_plan_params
    params.require(:lesson_plan).permit(:date)
  end

  def lesson_plan_items_params
    params.require(:lesson_plan).permit(items: [:subject, :start, :end])[:items]
  end

  def render_with_update_errors
    if params[:quick_edit].present?
      render :quick_edit
    else
      render :edit
    end
  end
end
