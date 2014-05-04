class Admin::NotificationsController < AdminController
  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :notification, through: :conference_edition

  def index
    @notifications = @conference_edition.notifications.order('created_at DESC')
  end

  def show
  end

  def new
    build_missing_translations_for(@conference_edition, @notification)
  end

  def create
    notification_attributes = params[:notification].merge(
      conference_edition_id: @conference_edition.id,
      organizer_id: current_user.id
    )

    @notification = Notification.new(notification_attributes)

    if @notification.save
      redirect_to preview_admin_conference_edition_notification_path(@conference_edition, @notification), flash: { success: 'Notification saved successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    @notification.assign_attributes(params[:notification])

    if composed_emails(@notification) && @notification.save
      redirect_to preview_admin_conference_edition_notification_path(@conference_edition, @notification), flash: { success: 'Notification updated successfully!' }
    else
      render :edit
    end
  rescue => ex
    flash.now[:error] = ex.message
    render :edit
  end

  def preview
    @composed_emails = composed_emails(@notification)
  end

  def trigger
    @notification.update_attributes(sent_at: Time.now, recipient_emails: @notification.recipient_users.pluck(:email).join(','))
    if trigger_emails
      redirect_to admin_conference_edition_notification_path(@conference_edition, @notification), flash: { success: 'Notification sent successfully!' }
    else
      render :preview
    end
  end

  private

  def trigger_emails
    sender_email = @notification.organizer.email

    composed_emails(@notification).each do |email|
      UserMailer.notification_email(email[:subject], email[:body], email[:recipient_email], sender_email).deliver
    end
  end

  def composed_emails(notification)
    composed_emails = []

    # For sponsors send one notification per sponsor per language
    if notification.recipients == 'sponsors'
      grouped_recipients = notification.recipient_users.group_by { |r| [r.sponsor, r.language] }

      grouped_recipients.each do |sponsor_and_language, recipients|
        language_code = sponsor_and_language[1].code.to_sym
        interpolable_variables = {
          'emails' => recipients.map(&:email).join(', '),
          'names' => recipients.map(&:name).join('/'),
          'company' => sponsor_and_language[0].name
        }

        composed_emails << composed_email(notification, interpolable_variables['emails'], language_code, interpolable_variables)
      end

    # For speakers and subscribers, send one notification per recipient
    else
      notification.recipient_users.each do |recipient|
        case recipient.class.to_s
        when 'Subscriber'
          language_code = notification.conference_edition.languages.first.code.to_sym
          interpolable_variables = {
            'email' => recipient.email
          }
        when 'Speaker'
          language_code = recipient.talks.first.language_code.to_sym
          interpolable_variables = {
            'email' => recipient.email,
            'name' => recipient.name,
            'company' => recipient.company,
            'selected_talk_title' => recipient.selected_talk_title
          }
        end

        composed_emails << composed_email(notification, recipient.email, language_code, interpolable_variables)
      end
    end

    # Return an array with all the composed emails
    composed_emails
  end

  def composed_email(notification, recipient_email, language_code, interpolable_variables)
    {
      recipient_email: recipient_email,
      subject: liquify(notification, notification.subject(language_code), interpolable_variables),
      body: view_context.markdown(liquify(notification, notification.body(language_code), interpolable_variables))
    }
  end

  def liquify(record, text, available_variables)
    ::Liquid::Template.parse(text).render(available_variables)
  end
end
