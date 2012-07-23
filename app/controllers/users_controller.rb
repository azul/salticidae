class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create!(params[:user])
    redirect_to root_url, :notice => "Signed up!"
  rescue VALIDATION_FAILED => e
    @user = e.document
    render "new"
  end
end
