class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) || UnauthenticatedUser.new
  end

  def logged_in?
    !current_user.is_a? UnauthenticatedUser
  end
end
