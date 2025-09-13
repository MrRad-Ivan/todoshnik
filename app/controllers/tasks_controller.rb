class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy]


  # GET /tasks 
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 
  def show
  end

  # GET /tasks/new
  def new 
    @task = Task.new
  end
  
  # POST /tasks/new
  def create
    @task = Task.new(task_params)
    @task.status = "Новая задача"
    if @task.save
      redirect_to @task
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /tasks/edit
  def edit
  end

  # GET /tasks/edit
  def update
    if @task.update(task_params)
      redirect_to @task
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
     redirect_to tasks_path, notice: "Задача успешно удалена"
  end
  

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
