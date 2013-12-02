class Admin::ConferencesController < AdminController

  load_and_authorize_resource

  def show
  end

  def index
  end

  def new
    @conference.conference_editions.build
  end

  def create
    if @conference.save
      redirect_to admin_conference_path(@conference), flash: { success: 'Conference created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @conference.update_attributes(params[:conference])
      redirect_to admin_conference_path(@conference), flash: { success: 'Conference updated successfully!' }
    else
      render :edit
    end
  end
end
