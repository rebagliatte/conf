class Admin::ConferenceEditionsController < AdminController

  before_action :set_conference_edition_params, only: [ :create, :update ]

  load_and_authorize_resource :conference
  load_and_authorize_resource :conference_edition, through: :conference

  def show
  end

  def new
  end

  def create
    @conference_edition.organizers << current_user
    if @conference_edition.save
      @conference_edition.languages.map(&:code).each do |locale|
        @conference_edition.translations.where(locale: locale).first_or_create!
      end
      redirect_to admin_conference_conference_edition_path(@conference, @conference_edition), flash: { success: 'Conference Edition created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @conference_edition.update(params[:conference_edition])
      redirect_to admin_conference_conference_edition_path(@conference, @conference_edition), flash: { success: 'Conference Edition updated successfully!' }
    else
      render :edit
    end
  end

  # Appearance

  def appearance
  end

  def edit_appearance
  end

  def update_appearance
    permitted_params = [
      :cover,
      :custom_css_file
    ]
    update_settings('appearance', permitted_params)
  end

  # Call for proposals

  def call_for_proposals
  end

  def update_call_for_proposals
    permitted_params = [
      :cfp_deadline,
      translations_attributes: [
        :id,
        :notes_to_speakers,
        :locale
      ]
    ]
    update_settings('call_for_proposals', permitted_params)
  end

  # Call for sponsors

  def call_for_sponsors
  end

  def update_call_for_sponsors
    permitted_params = [
      :is_call_for_sponsors_open,
      :sponsorship_packages_pdf,
      translations_attributes: [
        :id,
        :sponsors_call_to_action,
        :locale
      ]
    ]
    update_settings('call_for_sponsors', permitted_params)
  end

  # Registration settings

  def registration_settings
  end

  def update_registration_settings
    permitted_params = [
      :is_registration_open,
      :registration_url,
      translations_attributes: [
        :id,
        :registration_call_to_action,
        :locale
      ]
    ]
    update_settings('registration_settings', permitted_params)
  end

  # Subscriber settings

  def subscriber_settings
  end

  def update_subscriber_settings
    permitted_params = [
      :is_email_subscription_enabled,
      translations_attributes: [
        :id,
        :notes_to_subscribers,
        :locale
      ]
    ]
    update_settings('subscriber_settings', permitted_params)
  end

  # Schedule settings

  def update_schedule_settings
    permitted_params = [
      :is_schedule_available
    ]
    update_settings('subscriber_settings', permitted_params, admin_conference_edition_slots_path(@conference_edition))
  end

  private

  def set_conference_edition_params
    params[:conference_edition] = params.require(:conference_edition).permit(
      :city,
      :country,
      :from_date,
      :is_location_available,
      :kind,
      :logo,
      :promo_video_provider,
      :promo_video_uid,
      :to_date,
      :venue_address,
      :venue_latitude,
      :venue_longitude,
      translations_attributes: [
        :id,
        :tagline,
        :about,
        :news_intro,
        :venue,
        :locale
      ]
    )
  end

  def update_settings(action, permitted_params, success_url = nil)
    if !success_url
      success_url = send("#{action}_admin_conference_conference_edition_path", @conference, @conference_edition)
    end

    if params[:conference_edition].blank?
      redirect_to success_url, flash: { info: 'Nothing selected' }
    else
      conference_edition_params = params.require(:conference_edition).permit(permitted_params)

      if @conference_edition.update(conference_edition_params)
        redirect_to success_url, flash: { success: 'Updated!' }
      else
        render(action.to_sym)
      end
    end
  end
end
