class ApplicationController < ActionController::Base
    helper_method :current_user
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def log_in(user)
        session[:user_id] = user.id
    end

    def log_out
        session[:user_id] = nil
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def is_logged_in?
        redirect_to login_path, notice: I18n.t('notice.not_login') unless current_user
    end

    private
    def not_found
        render file: 'public/404.html',
               layout: false, 
               status: :not_found
    end
end
