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

  private

  def set_conference_edition_params
    params[:conference_edition] = params.require(:conference_edition).permit(
      :from_date, :to_date, :kind, :promo_video_provider, :promo_video_uid, \
      :logo, :conference, :conference_id, \
      :translations_attributes, :tagline, :country, :city, :venue, \
      :sponsorship_packages_pdf, :registration_url, :is_registration_open, \
      :is_call_for_proposals_open, :is_call_for_sponsorships_open, \
      :is_schedule_available, :is_location_available, :notes_to_speakers, \
      :is_email_subscription_enabled, :notes_to_subscribers, :custom_styles, \
      :speakers_call_to_action, :sponsors_call_to_action, :custom_css_file, \
      :venue_address, :venue_latitude, :venue_longitude, :news_intro, :about, \
      :registration_call_to_action, :is_talk_voting_open, \
      :is_speaker_listing_available, :intro
    )
  end
end
