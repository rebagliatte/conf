class Admin::SponsorsController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :sponsor, :through => :conference_edition

  def index
  end

  def show
  end

  def new
  end

  def create
    if @sponsor.save
      redirect_to admin_conference_edition_sponsor_path(@conference_edition, @sponsor), flash: { success: 'Sponsor created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @sponsor.update_attributes(params[:sponsor])
      redirect_to admin_conference_edition_sponsor_path(@conference_edition, @sponsor), flash: { success: 'Sponsor updated successfully!' }
    else
      render :edit
    end
  end
end
