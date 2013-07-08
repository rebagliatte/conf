class AdminController < ApplicationController
  layout 'admin'

  before_filter :authenticate_admin_user

  def conference_editions
    ConferenceEdition.accessible_by(current_ability)
  end

  private

  def authenticate_admin_user
    unless current_user.try(:admin?) || current_user.try(:superadmin?)
      redirect_to root_url, alert: "You are not authorized to access this page. Please log in as an admin and try again."
    end
  end

  helper_method :conference_editions

end
