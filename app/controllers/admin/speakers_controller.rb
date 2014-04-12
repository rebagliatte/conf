class Admin::SpeakersController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :speaker, through: :conference_edition

  def index
    @speakers = @speakers.approved.group_by { |s| s.confirmation_status }
  end

  def show
  end

  def new
  end

  def create
    if @speaker.save
      redirect_to admin_conference_edition_speaker_path(@conference_edition, @speaker), flash: { success: 'Speaker created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @speaker.update_attributes(params[:speaker])
      confirmation_only = params[:speaker].keys == ["confirmation_status"]

      if confirmation_only
        redirect_to admin_conference_edition_speakers_path(@conference_edition), flash: { success: "Speaker #{ params[:speaker]["confirmation_status"] }!" }
      else
        redirect_to admin_conference_edition_speaker_path(@conference_edition, @speaker), flash: { success: 'Speaker updated successfully!' }
      end
    else
      render :edit
    end
  end
end
