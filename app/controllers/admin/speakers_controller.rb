class Admin::SpeakersController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :speaker, through: :conference_edition

  def index
    @speakers = @conference_edition.speakers.approved
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
      redirect_to admin_conference_edition_speaker_path(@conference_edition, @speaker), flash: { success: 'Speaker updated successfully!' }
    else
      render :edit
    end
  end
end
