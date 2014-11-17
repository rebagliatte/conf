class Admin::ImagesController < AdminController

  before_action :set_image_params, only: [ :create ]

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :image, through: :conference_edition

  def new
  end

  def create
    if @image.save
      redirect_to appearance_admin_conference_conference_edition_path(@conference_edition.conference, @conference_edition.id), flash: { success: 'Image created successfully!' }
    else
      render :new
    end
  end

  def destroy
    @image.destroy
    redirect_to appearance_admin_conference_conference_edition_path(@conference_edition.conference, @conference_edition.id), flash: { success: 'Image removed' }
  end

  private

  def set_image_params
    params[:image] = params.require(:image).permit(
      :image
    )
  end
end
