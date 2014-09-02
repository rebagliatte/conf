class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user

  def conferences
    Conference.accessible_by(current_ability)
  end

  helper_method :conferences

  private

  def authenticate_user
    unless current_user
      flash[:info] = 'Please sign in.'
      redirect_to signup_url
    end
  end

end
