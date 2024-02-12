class SubTasksController < ApplicationController
  before_action :find_user, only: [:create, :update, :destroy]
  before_action :set_sub_task, only: [:show,  :update, :destroy, :mark_as_complete]
  
  def create
    @sub_task = SubTask.new(task_params)
    if @user.user_type == "Admin"
      @sub_task.save
      render json: @sub_task
    else
      render json: {Message: "only admin can create the sub_task"}
    end

  end

  def update
    @sub_task.update(task_params)
    render json: @sub_task
  end

  def mark_as_complete
    @sub_task.update(mark_as_complete: true)
    render json: {data: @sub_task, Message:"Mark as  completed"}
  end

  def destroy
    @sub_task.destroy
    render json: {Message:"sucessfully destroy"}
  end

  def show
    render json: @sub_task
  end

  def index
    @tasks = sub_task.all
    render json: @tasks
  end

  private
  def find_user
    @user = User.find(params[:sub_task][:user_id])
  end

  def set_sub_task
    @sub_task = SubTask.find(params[:id])
  end
  def task_params
    params.require(:sub_task).permit(:title, :description, :task_id)
  end
end
