class TalksController < ApplicationController
  def new
    @talk = Talk.new
  end

  def create
    @talk = Talk.new(params[:talk])
    @talk.status = 'pending'
    if @talk.save
      redirect_to conference_edition_talk_path(current_edition, @talk), flash: { success: 'Talk created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @talk.update_attributes(params[:talk])
      redirect_to talk_path(@talk), flash: { success: 'Talk updated successfully!' }
    else
      render :edit
    end
  end

  def index
  end

  def show
    @talk = Talk.find(params[:id])
  end
end
