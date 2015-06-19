class LessonPlanItemsController < ApplicationController
  before_filter :assign_lesson_plan
  decorates_assigned :lesson_plan_item

  def index
    @lesson_plan_items = @lesson_plan.items.order(date: :desc)
  end

  def new
    @duplicate_from = params[:duplicate_from]
    @lesson_plan_item = @lesson_plan.items.new
  end

  def edit
    @lesson_plan_item = @lesson_plan.items.find(params[:id])
  end

  def show
    @lesson_plan_item = @lesson_plan.items.find(params[:id])
  end

  def duplicate
    duplicate_from = @lesson_plan.items.find(params[:duplicate_from])
    target = current_user.lesson_plans.find(params[:lesson_plan_item][:lesson_plan_id])
    target.add_duplicate_item!(duplicate_from)
    redirect_to lesson_plan_path(target), notice: "Duplicated successfully"
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
    elc_data_item_schema = [:activity, :materials]
    elc_data_schema = {craft: elc_data_item_schema, central_1: elc_data_item_schema, central_2: elc_data_item_schema,
                       technology: elc_data_item_schema, reading: elc_data_item_schema}
    params.require(:lesson_plan_item).permit(:start, :end, :subject, :topic, :type, :theme,
                                             :goals, :teaching_method, :teaching_aids,
                                             elc_data: elc_data_schema)
  end
end
