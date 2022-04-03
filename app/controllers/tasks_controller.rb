class TasksController < ApplicationController
    before_action :find_task, only: [:edit, :update, :destroy, :do_it, :finish_it, :unfinish_it]
    before_action :is_logged_in?, only: [:index, :new, :create, :edit, :update, :destroy]

    def index
        @q = current_user.tasks.ransack(params[:q])
        @tasks = @q.result(distinct: true).page(params[:page]).per(5)
    end

    def new
        @task = Task.new
    end

    def create
        @task = current_user.tasks.create(task_params)
        @task.status = 'pending'
        if @task.save 
            redirect_to tasks_path, notice: I18n.t('notice.new')
        else 
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            redirect_to tasks_path, notice: I18n.t('notice.update')
        else
          render :edit
        end
    end

    def destroy
        @task.destroy if @task
        redirect_to tasks_path, notice: I18n.t('notice.delete')
    end

    def do_it
        @task.do_it!
        redirect_back_or_to tasks_path
    end

    def finish_it
        @task.finish_it!
        redirect_back_or_to tasks_path
    end

    def unfinish_it
        @task.unfinish_it!
        redirect_back_or_to tasks_path
    end

    private
    def task_params
        params.require(:task).permit(:title, :content, :start_time, :end_time, :status, :priority, :tag)
    end

    def find_task
        @task = Task.find_by(id: params[:id])
    end
end
