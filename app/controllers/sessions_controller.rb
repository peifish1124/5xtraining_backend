class SessionsController < ApplicationController

    def new
    end

    # login
    def create
        @user = User.authenticate(params[:email].downcase, params[:password])
        if @user
            log_in(@user)
            redirect_to tasks_path(@user), notice: I18n.t('notice.login')
        else
            redirect_to login_path, notice: I18n.t('notice.login_fail')
        end
    end

    # logout
    def destroy
        log_out
        redirect_to login_path, notice: I18n.t('notice.logout')
    end
end
