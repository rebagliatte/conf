class TalksController < ApplicationController
  def new
    if current_edition.is_call_for_proposals_open
      @talk = current_edition.talks.new
      @talk.speakers.build
    else
      redirect_to root_path, flash: { success: 'Call for proposals is now closed' }
    end
  end

  def create
    @talk = current_edition.talks.new(params[:talk])
    @talk.status = 'pending'
    if @talk.save
      redirect_to root_path, flash: { success: 'Thanks! Your talk proposal has been submitted successfully.' }
    else
      render :new
    end
  end

  def edit
    @talk = Talk.find(params[:id])
  end

  def update
    if @talk.update(params[:talk])
      redirect_to talk_path(@talk), flash: { success: 'Talk updated successfully!' }
    else
      render :edit
    end
  end

  def index
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @talks = @conference_edition.talks.confirmed
  end

  def show
    @talk = Talk.confirmed.find(params[:id])
    @speaker = @talk.speakers.first
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
  end
end
