class UsersController < ApplicationController

  respond_to :json, :html

  def new
    @user = User.new
  end

  def create
    @user = User.create!(params[:user])
    respond_with(@user, :location => root_url, :notice => "Signed up!")
  rescue VALIDATION_FAILED => e
    @user = e.document
    respond_with(@user)
  end
end
