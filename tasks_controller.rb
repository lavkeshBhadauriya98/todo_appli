class TasksController < ApplicationController
   before_action :find_user, only: [:create, :update, :destroy]
   before_action :set_task, only: [:show,  :update, :destroy, :mark_as_complete]
  def create
    @task = Task.new(task_params)
    if @user.user_type == "Admin"
      @task.save
      render json: @task
    else
      render json: {Message: "only admin can create the task"}
    end

  end

  def update
    @task.update(task_params)
    render json: @task
  end

  def mark_as_complete
    if @task.sub_tasks.pluck(:mark_as_complete).include?(false)
      render json: {Message: "need to complete sub task"}
    else
      @task.update(mark_as_complete: true)
      render json: {Message:"Mark as  completed"}
    end
  end

  def destroy
    @task.destroy
    render json: {Message:"sucessfully destroy"}
  end

  def show
    render json: @task
  end

  def index
    @tasks = Task.all
    render json: @tasks
  end

  private
  def find_user
    @user = User.find(params[:task][:user_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:title, :description, :user_id)
  end
end
