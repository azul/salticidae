class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:login], "")
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to log_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
