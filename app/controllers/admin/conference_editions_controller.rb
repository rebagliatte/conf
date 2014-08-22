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

  private

  def set_conference_edition_params
    params[:conference_edition] = params.require(:conference_edition).permit(
      :about,
      :city,
      :conference,
      :conference_id,
      :country,
      :custom_css_file,
      :custom_styles,
      :from_date,
      :intro,
      :is_email_subscription_enabled,
      :is_location_available,
      :is_registration_open,
      :is_schedule_available,
      :is_speaker_listing_available,
      :is_talk_voting_open,
      :kind,
      :logo,
      :news_intro,
      :notes_to_speakers,
      :notes_to_subscribers,
      :promo_video_provider,
      :promo_video_uid,
      :registration_call_to_action,
      :registration_url,
      :tagline,
      :to_date,
      :translations_attributes,
      :venue,
      :venue_address,
      :venue_latitude,
      :venue_longitude
    )
  end
end
