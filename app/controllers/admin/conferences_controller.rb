class Admin::ConferencesController < ApplicationController
  layout 'admin'

  def show
    @conference = Conference.find(params[:id])
  end

  def index
    @conferences = Conference.all
  end

  def new
    @conference = Conference.new
    @conference.conference_editions.build
  end

  def create
    @conference = Conference.new(params[:conference])
    if @conference.save
      redirect_to admin_conference_path(@conference), flash: { success: 'Conference created successfully!' }
    else
      render :new
    end
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
    @conference = Conference.find(params[:id])
    if @conference.update_attributes(params[:conference])
      redirect_to admin_conference_path(@conference), flash: { success: 'Conference updated successfully!' }
    else
      render :edit
    end
  end

end
