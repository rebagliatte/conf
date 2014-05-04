class Admin::SponsorContactsController < AdminController

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
    if @sponsor_contact.update_attributes(params[:sponsor_contact])
      redirect_to admin_conference_edition_sponsor_path(@conference_edition.id, @sponsor_contact.sponsor), flash: { success: 'Contact updated successfully!' }
    else
      render :edit
    end
  end
end
