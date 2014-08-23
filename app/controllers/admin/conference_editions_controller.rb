class Admin::ConferenceEditionsController < AdminController

  before_action :set_conference_edition_params, only: [ :create, :update, :update_appearance ]

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
    if @conference_edition.update(params[:conference_edition])
      redirect_to appearance_admin_conference_conference_edition_path(@conference, @conference_edition), flash: { success: 'Conference Edition updated successfully!' }
    else
      render :edit_appearance
    end
  end

  # Call for proposals

  def call_for_proposals
  end

  def update_call_for_proposals
    conference_edition_params = params.require(:conference_edition).permit(
      :is_call_for_proposals_open,
      translations_attributes: [
        :id,
        :notes_to_speakers,
        :locale
      ]
    )
    url = call_for_proposals_admin_conference_conference_edition_path(@conference, @conference_edition)

    if @conference_edition.update(conference_edition_params)
      redirect_to url, flash: { success: 'Updated!' }
    else
      render :call_for_proposals
    end
  end

  # Call for sponsors

  def call_for_sponsors
  end

  def update_call_for_sponsors
    conference_edition_params = params.require(:conference_edition).permit(
      :is_call_for_sponsors_open,
      :sponsorship_packages_pdf,
      translations_attributes: [
        :id,
        :sponsors_call_to_action,
        :locale
      ]
    )
    url = call_for_sponsors_admin_conference_conference_edition_path(@conference, @conference_edition)

    if @conference_edition.update(conference_edition_params)
      redirect_to url, flash: { success: 'Updated!' }
    else
      render :call_for_sponsors
    end
  end

  # Registration settings

  def registration_settings
  end

  def update_registration_settings
    conference_edition_params = params.require(:conference_edition).permit(
      :is_registration_open,
      :registration_url,
      translations_attributes: [
        :id,
        :registration_call_to_action,
        :locale
      ]
    )
    url = registration_settings_admin_conference_conference_edition_path(@conference, @conference_edition)

    if @conference_edition.update(conference_edition_params)
      redirect_to url, flash: { success: 'Updated!' }
    else
      render :registration_settings
    end
  end

  # Subscriber settings

  def subscriber_settings
  end

  def update_subscriber_settings
    conference_edition_params = params.require(:conference_edition).permit(
      :is_email_subscription_enabled,
      translations_attributes: [
        :id,
        :notes_to_subscribers,
        :locale
      ]
    )
    url = subscriber_settings_admin_conference_conference_edition_path(@conference, @conference_edition)

    if @conference_edition.update(conference_edition_params)
      redirect_to url, flash: { success: 'Updated!' }
    else
      render :subscriber_settings
    end
  end

  # Schedule settings

  def update_schedule_settings
    conference_edition_params = params.require(:conference_edition).permit(
      :is_schedule_available
    )
    url = admin_conference_edition_slots_path(@conference_edition)

    if @conference_edition.update(conference_edition_params)
      redirect_to url, flash: { success: 'Done!' }
    else
      redirect_to url, flash: { error: @conference_edition.errors.full_messages }
    end
  end

  private

  def set_conference_edition_params
    params[:conference_edition] = params.require(:conference_edition).permit(
      :city,
      :conference,
      :conference_id,
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
end
