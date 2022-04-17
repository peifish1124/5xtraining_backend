class Admin::UsersController < ApplicationController

    before_action :find_user, only: [:edit, :show, :destroy, :update]

    def index 
        @users = User.includes(:tasks)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to admin_users_path, notice: I18n.t('notice.create_user')
        else 
            render :new
        end
    end

    def show
        @q = @user.tasks.ransack(params[:q])
        @tasks = @q.result(distinct: true).page(params[:page]).per(5)
    end

    def edit 
    end

    def destroy
        if @user.destroy
            redirect_to admin_users_path, notice: I18n.t('notice.delete_user')
        else
            redirect_to admin_users_path, alert: I18n.t('notice.no_admin')
        end
    end

    def update
        if @user.update(user_params)
            redirect_to admin_users_path, notice: I18n.t('notice.update_user')
        else
            render :edit
        end
    end

    private
    def find_user 
        @user = User.find_by(id: params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :admin)
    end
end
