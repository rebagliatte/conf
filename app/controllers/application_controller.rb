class ApplicationController < ActionController::Base

  protect_from_forgery

  include UrlHelper

  layout :conditional_layout

  before_filter :set_locale

  private

  def conditional_layout
    if current_conference
      if @conference_edition && @conference_edition != current_edition
        'previous_edition'
      else
        'application'
      end
    else
      'marketing'
    end
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  protected



  def current_conference
    request.subdomain.present? ? Conference.find_by_subdomain!(request.subdomain) : nil
  end

  def current_edition
    ConferenceEdition.where(conference_id: current_conference).last
  end

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

  helper_method :current_user, :signed_in?, :current_conference, :current_edition

end
