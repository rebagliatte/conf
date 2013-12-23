class Admin::ConferenceEditionsController < AdminController

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
    if @conference_edition.update_attributes(params[:conference_edition])
      redirect_to admin_conference_conference_edition_path(@conference, @conference_edition), flash: { success: 'Conference Edition updated successfully!' }
    else
      render :edit
    end
  end

  def appearance
  end

  def edit_appearance
  end

  def update_appearance
    if @conference_edition.update_attributes(params[:conference_edition])
      redirect_to appearance_admin_conference_conference_edition_path(@conference, @conference_edition), flash: { success: 'Conference Edition updated successfully!' }
    else
      render :edit_appearance
    end
  end

end
