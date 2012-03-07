class SessionsController < ApplicationController
	skip_before_filter :authorize

  def new
  end

  def create
  	if user = User.authenticate(params[:username],params[:password])
  		session[:user_id] = user.id
  		redirect_to '/', :notice => "You have successfully logged in"
		else
			redirect_to login_url, :alert => "Invalid user/password combination"
		end
  end

  def destroy
		session.delete(:user_id)
		redirect_to login_url, :notice => "Logged out"
  end
end
