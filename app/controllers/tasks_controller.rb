class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_status]


  # GET /tasks 
  def index
    @tasks = Task.all
    @tasks.each(&:check_overdue!)
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

  # DELETE /task/1  
  def destroy
    @task.destroy
     redirect_to tasks_path, notice: "Задача успешно удалена"
  end

  # tasks_controller.rb
  def toggle_status
    @task.next_status!
    redirect_to tasks_path, notice: "Статус обновлён"
  end


  
  

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :repeat_interval, :repeat_unit, :repeat_forever)
  end
end
