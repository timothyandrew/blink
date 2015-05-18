class LessonPlanItemsController < ApplicationController
  before_filter :assign_lesson_plan

  def index
    @lesson_plan_items = @lesson_plan.items.order(date: :desc)
  end

  def new
    @lesson_plan_item = @lesson_plan.items.new
  end

  def edit
    @lesson_plan_item = @lesson_plan.items.find(params[:id])
  end

  def create
    @lesson_plan_item = @lesson_plan.items.new
    @lesson_plan_item.assign_attributes(lesson_plan_item_params)
    if @lesson_plan_item.save
      flash[:notice] = "Lesson plan item was created"
      redirect_to lesson_plan_path(@lesson_plan)
    else
      flash[:alert] = @lesson_plan_item.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @lesson_plan_item = @lesson_plan.items.find(params[:id])
    if @lesson_plan_item.update_attributes(lesson_plan_item_params)
      flash[:notice] = "Lesson plan item was edited"
      redirect_to lesson_plan_path(@lesson_plan)
    else
      flash[:alert] = @lesson_plan_item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @lesson_plan_item = @lesson_plan.items.find(params[:id])
    @lesson_plan_item.destroy
    flash[:notice] = "Lesson plan item was destroyed! Take that, Rakshitha!"
    redirect_to lesson_plan_path(@lesson_plan)
  end

  private

  def assign_lesson_plan
    @lesson_plan = current_user.lesson_plans.find(params[:lesson_plan_id])
  end

  def lesson_plan_item_params
    params.require(:lesson_plan_item).permit(:start, :end, :subject, :topic,
                                             :goals, :teaching_method, :teaching_aids)
  end
end
