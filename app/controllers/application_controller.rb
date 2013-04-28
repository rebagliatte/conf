class ApplicationController < ActionController::Base
  protect_from_forgery

  def conference_name
    CONFIG[:conference_name]
  end

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  def authenticate_admin_user!
    redirect_to root_url unless current_user.try(:admin?)
  end

  helper_method :current_user, :signed_in?, :conference_name

end
