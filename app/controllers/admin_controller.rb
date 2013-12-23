class AdminController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user

  def conferences
    Conference.accessible_by(current_ability)
  end

  helper_method :conferences

  private

  def authenticate_user
    unless current_user
      redirect_to root_url, alert: "Please log in and try again"
    end
  end

end
