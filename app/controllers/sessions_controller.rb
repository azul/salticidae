class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_login(params[:login])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
