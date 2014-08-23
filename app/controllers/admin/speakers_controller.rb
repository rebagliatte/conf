class Admin::SpeakersController < AdminController

  before_action :set_speaker_params, only: [ :create, :update ]

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :speaker, through: :conference_edition

  def index
    @statuses = Speaker::STATUSES
    @current_status = params[:status] || 'confirmed'
    @speakers_in_current_status = @speakers.where(status: @current_status)
  end

  def show
  end

  def new
    @conference_edition.languages.map(&:code).each do |locale|
      @speaker.translations.build(locale: locale)
    end
  end

  def create
    if @speaker.save
      redirect_to admin_conference_edition_speaker_path(@conference_edition, @speaker), flash: { success: 'Speaker created successfully!' }
    else
      render :new
    end
  end

  def edit
    build_missing_translations_for(@conference_edition, @speaker)
  end

  def update
    if @speaker.update(params[:speaker])
      visibility_only = params[:speaker].keys == ["is_promoted"]

      if visibility_only
        promtion_status = if params[:speaker]["is_promoted"] == 'true'
          'will now be displayed on the homepage!'
        else
          'will no longer be displayed on the homepage.'
        end
        redirect_to admin_conference_edition_speakers_path(@conference_edition), flash: { success: "#{ @speaker.name } #{ promtion_status }" }
      else
        redirect_to admin_conference_edition_speaker_path(@conference_edition, @speaker), flash: { success: 'Speaker updated successfully!' }
      end
    else
      render :edit
    end
  end

  private

  def set_speaker_params
    params[:speaker] = params.require(:speaker).permit(
      :accomodation_details,
      :arrival_date,
      :avatar,
      :avatar_cache,
      :bio,
      :city,
      :company,
      :conference_edition_id,
      :country,
      :email,
      :github_username,
      :is_promoted,
      :job_title,
      :lanyrd_username,
      :name,
      :phone,
      :status,
      :talk,
      :talk_id,
      :talks,
      :twitter_username,
      :user_id,
      :website,
      translations_attributes: [
        :id,
        :bio,
        :locale
      ]
    )
  end
end
