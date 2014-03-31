class Admin::NotificationsController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :notification, through: :conference_edition

  def index
  end

  def show
  end

  def new
    @conference_edition.languages.map(&:code).each do |locale|
      @notification.translations.build locale: locale
    end
  end

  def create
    notification_attributes = params[:notification].merge(
      conference_edition_id: @conference_edition.id,
      organizer_id: current_user.id
    )

    @notification = Notification.new(notification_attributes)

    if @notification.save
      redirect_to admin_conference_edition_notification_path(@conference_edition, @notification), flash: { success: 'Notification sent successfully!' }
    else
      render :new
    end
  end
end
