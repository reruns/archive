class GoalsController < ApplicationController

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy!
    redirect_to user_goals_url(@goal.user_id)
  end

  def show
    @goal = Goal.includes(comments: :author).find(params[:id])
  end

  def index
    @user = User.includes(comments: :author).find(params[:user_id])
    @goals = @user.goals
  end

  def complete
    @goal = Goal.find(params[:id])
    @goal.toggle_completed
    render :show
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :privacy)
  end
end
