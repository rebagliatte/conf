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
      link = edit_admin_conference_conference_edition_path(@conference, @conference.conference_editions.first)
      message = "Conference created successfully! Want to add more details on its \
      #{view_context.link_to('first edition', link)}?".html_safe
      redirect_to admin_conference_path(@conference), flash: { success: message }
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
