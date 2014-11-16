class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: Rails.application.secrets.http_user, password: Rails.application.secrets.http_password if Rails.env.staging?
  protect_from_forgery

  include UrlHelper

  layout :conditional_layout

  before_action :set_locale
  before_action :enforce_current_edition
  before_action :allow_iframe_requests

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def build_translations_for(conference_edition, record)
    missing_translations = conference_edition.languages.pluck(:code) - record.translations.pluck(:locale)
    missing_translations.each do |locale|
      record.translations.build(locale: locale)
    end
  end

  def not_found
    old_url = request.url
    new_url = old_url.sub('conference_editions', 'editions').sub('talks', 'sessions')

    if old_url != new_url
      redirect_to(new_url, status: :moved_permanently)
    end
  end

  private

  def conditional_layout
    current_conference ? 'application' : 'marketing'
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
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
    @current_edition ||= if params[:conference_edition_id]
      current_conference.conference_editions.find(params[:conference_edition_id])
    else
      current_conference.conference_editions.last
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  def enforce_current_edition
    if current_conference && !current_edition
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  helper_method :current_user, :signed_in?, :current_conference, :current_edition
end
