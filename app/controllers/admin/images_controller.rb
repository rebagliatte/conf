class Admin::ImagesController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :image, through: :conference_edition

  def new
  end

  def create
    if @image.save
      redirect_to appearance_admin_conference_conference_edition_path(@conference_edition.conference, @conference_edition), flash: { success: 'Image created successfully!' }
    else
      render :new
    end
  end

  def destroy
    @image.destroy
    redirect_to appearance_admin_conference_conference_edition_path(@conference_edition.conference, @conference_edition), flash: { success: 'Image removed' }
  end
end
