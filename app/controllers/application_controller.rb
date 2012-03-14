class ApplicationController < ActionController::Base
  before_filter :authorize, :set_request
  layout :set_layout
  protect_from_forgery

  protected

  def authorize
  	@authorized = true
		unless User.find_by_id(session[:user_id])
			@authorized = false
			redirect_to login_url, :notice => "Please log in"
		end 
	end

	def set_layout 
		if @authorized
			'authorized'
		else
			'application'
		end
	end

	def set_request
		@current_controller = controller_name
    @current_action = action_name
    @current_user = current_user # makes the current user available in the views
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
