class ApplicationController < ActionController::Base
    before_action :authenticate
    helper_method  :logged_in?, :current_user

    rescue_from Exception, with: :error500
    rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

    private

    def error404
        render "error404", status: 404, formats: [:html]
    end

    def error500
        render "error500", status: 500, formats: [:html]    
    end

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        return unless session[:user_id]
        @current_user ||= User.find(session[:user_id])
    end

    def authenticate
        return if logged_in?
        redirect_to root_path, alert: "please login"
    end 

end
