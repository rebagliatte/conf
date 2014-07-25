class ApplicationController < ActionController::Base
  protect_from_forgery

  include UrlHelper

  layout :conditional_layout

  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def build_missing_translations_for(conference_edition, record)
    missing_translations = conference_edition.languages.pluck(:code) - record.translations.pluck(:locale)
    missing_translations.each do |locale|
      record.translations.build(locale: locale)
    end
  end

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

  def is_request_internal
    Rails.application.secrets.confnu_server_names.split(' ').include?(request.domain)
  end

  def current_conference
    @current_conference ||= if !is_request_internal
      Conference.find_by(custom_domain: request.domain)
    elsif request.subdomain.present?
      Conference.find_by(subdomain: request.subdomain)
    end
  end

  def current_edition
    @current_edition ||= ConferenceEdition.where(conference_id: current_conference).last
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  helper_method :current_user, :signed_in?, :current_conference, :current_edition
end
