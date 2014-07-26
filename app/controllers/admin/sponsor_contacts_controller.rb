class Admin::SponsorContactsController < AdminController

  before_action :set_sponsor_contact_params, only: [:create, :update]

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :sponsor_contact, :through => :conference_edition

  def create
    if @sponsor_contact.save
      redirect_to admin_conference_edition_sponsor_path(@conference_edition.id, @sponsor_contact.sponsor), flash: { success: 'Contact updated successfully!' }
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @sponsor_contact.update(params[:sponsor_contact])
      redirect_to admin_conference_edition_sponsor_path(@conference_edition.id, @sponsor_contact.sponsor), flash: { success: 'Contact updated successfully!' }
    else
      render :edit
    end
  end

  private

  def set_sponsor_contact_params
    params[:sponsor_contact] = params.require(:sponsor_contact).permit(
      :conference_edition_id, :sponsor_id, :language, :language_id, :name, :email
    )
  end
end
