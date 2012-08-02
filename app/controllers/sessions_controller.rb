class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_param(params[:login])
    session[:handshake] = @user.initialize_auth(params['A'].hex)
    render :json => { :B => session[:handshake].bb.to_s(16) }
  rescue RECORD_NOT_FOUND
    render :json => {:error => "unknown user", :field => "login"}
  end

  def update
    @user = User.find_by_param(params[:id])
    @server_auth = @user.authenticate!(params[:client_auth].hex, session.delete(:handshake))
    session[:user_id] = @user.id
    render :json => @server_auth
  rescue WRONG_PASSWORD
    session[:handshake] = nil
    render :json => {:error => "wrong password", :field => "password"}
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
