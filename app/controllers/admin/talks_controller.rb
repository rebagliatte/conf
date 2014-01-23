class Admin::TalksController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :talk, through: :conference_edition

  def index
    @talks = Talk.all.group_by { |s| s.status }
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
    missing_translations = @conference_edition.languages.pluck(:code) - @talk.translations.pluck(:locale)
    missing_translations.each do |locale|
      @talk.translations.build locale: locale
    end
  end

  def update
    if @talk.update_attributes(params[:talk])
      redirect_to admin_conference_edition_talk_path(@conference_edition, @talk), flash: { success: 'Talk updated successfully!' }
    else
      render :edit
    end
  end
end
