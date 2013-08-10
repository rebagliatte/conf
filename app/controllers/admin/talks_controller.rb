class Admin::TalksController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :talk, :through => :conference_edition

  def index
  end

  def show
  end

  def new
    @conference_edition.languages.map(&:code).each do |locale|
      @talk.translations.build locale: locale
    end
  end

  def create
    if @talk.save
      redirect_to admin_conference_edition_talk_path(@conference_edition, @talk), flash: { success: 'Talk created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @talk.update_attributes(params[:talk])
      redirect_to admin_conference_edition_talk_path(@conference_edition, @talk), flash: { success: 'Talk updated successfully!' }
    else
      render :edit
    end
  end
end
