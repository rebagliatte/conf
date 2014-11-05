class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user

  def conferences
    Conference.accessible_by(current_ability)
  end

  helper_method :conferences

  private

  def authenticate_user
    if !current_user
      session[:redirect_path] = request.original_url
      redirect_to signup_url
    end
  end

end
