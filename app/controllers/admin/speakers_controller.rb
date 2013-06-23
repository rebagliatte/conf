class Admin::SpeakersController < AdminController
  def index
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @speakers = @conference_edition.speakers
  end

  def show
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @speaker = Speaker.find(params[:id])
  end

  def new
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @speaker = Speaker.new
  end

  def create
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @speaker = Speaker.new(params[:speaker])
    if @speaker.save
      redirect_to admin_conference_edition_speaker_path(@conference_edition, @speaker), flash: { success: 'Speaker created successfully!' }
    else
      render :new
    end
  end

  def edit
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @speaker = Speaker.find(params[:id])
  end

  def update
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @speaker = Speaker.find(params[:id])
    if @speaker.update_attributes(params[:speaker])
      redirect_to admin_conference_edition_speaker_path(@conference_edition, @speaker), flash: { success: 'Speaker updated successfully!' }
    else
      render :edit
    end
  end
end
