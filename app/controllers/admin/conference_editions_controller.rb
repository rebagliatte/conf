class Admin::ConferenceEditionsController < AdminController

  load_and_authorize_resource :conference
  load_and_authorize_resource :conference_edition, through: :conference

  def show
  end

  def new
  end

  def create
    if @conference_edition.save
      redirect_to admin_conference_conference_edition_path(@conference, @conference_edition), flash: { success: 'Conference Edition created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @conference_edition.update_attributes(params[:conference_edition])
      redirect_to admin_conference_conference_edition_path(@conference, @conference_edition), flash: { success: 'Conference Edition updated successfully!' }
    else
      render :edit
    end
  end
end
