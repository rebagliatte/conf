class Admin::PagesController < AdminController

  before_action :set_page_params, only: [ :create, :update ]

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :page, through: :conference_edition

  def index
  end

  def show
  end

  def new
    build_translations_for(@conference_edition, @page)
  end

  def create
    if @page.save
      redirect_to admin_conference_edition_page_path(@conference_edition, @page), flash: { success: 'Page created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update(params[:page])
      redirect_to admin_conference_edition_page_path(@conference_edition, @page), flash: { success: 'Page updated successfully!' }
    else
      render :edit
    end
  end

  private

  def set_page_params
    params[:page] = params.require(:page).permit(
      translations_attributes: [
        :id,
        :title,
        :content,
        :locale
      ]
    )
  end
end
