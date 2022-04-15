class RegistrationsController < ApplicationController

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
end
