class SessionsController < ApplicationController
    before_action :find_session_user , only: [:create]

    def new
    end

    # login
    def create
        if @user && @user.authenticate(params[:password])
            log_in(@user)
            redirect_to tasks_path(@user), notice: I18n.t('notice.login')
        else
            redirect_to login_path, notice: I18n.t('notice.login_fail')
        end
    end

    # logout
    def destroy
        session[:user_id] = nil
        redirect_to login_path, notice: I18n.t('notice.logout')
    end

    private
    def find_session_user
        @user = User.find_by(email: params[:email].downcase)
    end
end
