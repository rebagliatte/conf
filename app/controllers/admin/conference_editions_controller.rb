class Admin::ConferenceEditionsController < AdminController
  def show
    @conference_edition = ConferenceEdition.find(params[:id])
  end

  def index
    @conference_editions = ConferenceEdition.all
  end

  def new
    @conference_edition = ConferenceEdition.new
  end

  def create
    @conference_edition = ConferenceEdition.new(params[:conference_edition])
    if @conference_edition.save
      redirect_to admin_conference_edition_path(@conference_edition), flash: { success: 'Conference Edition created successfully!' }
    else
      render :new
    end
  end

  def edit
    @conference_edition = ConferenceEdition.find(params[:id])
  end

  def update
    @conference_edition = ConferenceEdition.find(params[:id])
    if @conference_edition.update_attributes(params[:conference_edition])
      redirect_to admin_conference_edition_path(@conference_edition), flash: { success: 'Conference Edition updated successfully!' }
    else
      render :edit
    end
  end
end
