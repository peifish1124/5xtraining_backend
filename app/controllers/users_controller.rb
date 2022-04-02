class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :show]

    def index
        @users = User.includes(:tasks)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save 
            redirect_to login_path, notice: I18n.t('notice.signup')
        else 
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

    def find_user 
        @user = User.find_by(id: params[:id])
    end
end
