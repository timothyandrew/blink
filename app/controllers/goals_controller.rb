class GoalsController < ApplicationController
  before_filter :assign_student
  decorates_assigned :goal
  decorates_assigned :parent

  def new
    @parent = @student.goals.find_by_id(params[:parent_id]) if params[:parent_id]
    @goal = @student.goals.new
  end

  def edit
    @goal = @student.goals.find(params[:id])
    @parent = @goal.parent
  end

  def show
    @goal = @student.goals.find(params[:id])
  end

  def create
    @parent = @student.goals.find_by_id(params[:parent_id])  if params[:parent_id]
    @goal = @student.goals.new
    if @goal.save_with_category(goal_params, @parent, params[:category_name])
      @goal.move_to_child_of(@parent) if @parent
      flash[:notice] = "Goal was created"
      redirect_to student_goal_path(@student, @goal)
    else
      flash[:alert] = @goal.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @goal = @student.goals.find(params[:id])
    if @goal.save_with_category(goal_params, nil, params[:category_name])
      flash[:notice] = "Goal was edited"
      redirect_to student_goal_path(@student, @goal)
    else
      flash[:alert] = @goal.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @goal = @student.goals.find(params[:id])
    @goal.destroy
    flash[:notice] = "Goal was destroyed!"
    redirect_to student_path(@student)
  end

  def uncomplete
    @goal = @student.goals.find(params[:id])
    @goal.uncomplete!
    redirect_to student_goal_path(@student, @goal), notice: "Goal was uncompleted!"
  end

  def complete
    @goal = @student.goals.find(params[:id])
    @goal.complete!
    redirect_to student_goal_path(@student, @goal), notice: "Goal was completed!"
  end

  def quick_create
    @parent = @student.goals.find_by_id(params[:parent_id]) if params[:parent_id]
    parsed_goals = GoalParsing::Service.parse(params[:goals].strip)
    if parsed_goals && Goal.save_many_with_category(parsed_goals, @student, @parent)
      flash[:notice] = "Goals were created."
      if @parent
        redirect_to student_goal_path(@student, @parent)
      else
        redirect_to student_path(@student)
      end
    else
      flash[:error] = "Couldn't quick save goals. Check your syntax!"
      @quick_goals = params[:goals]
      @goal = @student.goals.new
      render :new
    end
  end

  def tree
  end

  def reorder
    if params[:parent_id]
      parent = @student.goals.find_by_id(params[:parent_id])
      goals = parent.children.all
    else
      goals = @student.goals.roots.all
    end
    Goal.order_sequentially!(goals, params[:goal_ids])
    respond_to do |format|
      format.json { render json: {status: :success} }
      format.html { render :index }
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :start, :end)
  end
end
