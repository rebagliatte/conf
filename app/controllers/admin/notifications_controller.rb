class Admin::NotificationsController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :notification, through: :conference_edition

  def index
    @notifications = @conference_edition.notifications.order('created_at DESC')
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

    if trigger_emails && @notification.save
      redirect_to admin_conference_edition_notification_path(@conference_edition, @notification), flash: { success: 'Notification sent successfully!' }
    else
      render :new
    end
  end

  private

  def trigger_emails
    sender_email = @notification.organizer.email

    @notification.recipient_users.each do |recipient|
      language_code = recipient.talks.first.language_code.to_sym

      subject = @notification.subject(language_code)
      body = @notification.body(language_code)

      UserMailer.notification_email(subject, body, recipient.email, sender_email).deliver
    end
  end
end
