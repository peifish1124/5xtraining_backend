class TasksController < ApplicationController
    before_action :find_task, only: [:edit, :update, :destroy]

    def index
        @q = Task.ransack(params[:q])
        @tasks = @q.result(distinct: true)
        if params[:id]
            change_state
        end
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
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

    private
    def task_params
        params.require(:task).permit(:title, :content, :start_time, :end_time, :status, :priority, :tag, :user_id)
    end

    def find_task
        @task = Task.find_by(id: params[:id])
    end

    def change_state
        find_task
        if params[:event] == 'do_it' && @task.pending?
          @task.do_it! 
        elsif params[:event] == 'finish_it' && @task.ongoing?
          @task.finish_it!
        elsif params[:event] == 'unfinish_it' && @task.done?
          @task.unfinish_it!
        else
          redirect_to tasks_path
        end
    end
end
