class Admin::SpeakersController < AdminController

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
      @speaker.translations.build locale: locale
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
    if @speaker.update_attributes(params[:speaker])
      visibility_only = params[:speaker].keys == ["is_promoted"]

      if visibility_only
        promtion_status = if params[:speaker]["is_promoted"] == 'true'
          'promoted. The speaker will now be displayed on the homepage.'
        else
          'demoted.  The speaker will no longer be displayed on the homepage.'
        end
        redirect_to admin_conference_edition_speakers_path(@conference_edition), flash: { success: "Speaker #{ promtion_status }." }
      else
        redirect_to admin_conference_edition_speaker_path(@conference_edition, @speaker), flash: { success: 'Speaker updated successfully!' }
      end
    else
      render :edit
    end
  end
end
