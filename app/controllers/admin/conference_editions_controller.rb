class Admin::ConferenceEditionsController < AdminController

  load_and_authorize_resource

  def show
  end

  def index
  end

  def new
  end

  def create
    if @conference_edition.save
      redirect_to admin_conference_edition_path(@conference_edition), flash: { success: 'Conference Edition created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @conference_edition.update_attributes(params[:conference_edition])
      redirect_to admin_conference_edition_path(@conference_edition), flash: { success: 'Conference Edition updated successfully!' }
    else
      render :edit
    end
  end
end
