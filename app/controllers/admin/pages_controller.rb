class Admin::PagesController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :page, through: :conference_edition

  def index
  end

  def show
  end

  def new
    @conference_edition.languages.map(&:code).each do |locale|
      @page.translations.build locale: locale
    end
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
end
