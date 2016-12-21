class SessionsController < ApplicationController
  def new
  end

  def create
  user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t "welcome_message"
      redirect_to user
    else
      flash.now[:danger] = t "fail_login"
       render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
