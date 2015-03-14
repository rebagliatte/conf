class TalksController < ApplicationController
  def new
    if current_edition.cfp_open?
      @talk = current_edition.talks.new
      @talk.speakers.build
    else
      redirect_to root_path, flash: { success: 'Call for proposals is now closed' }
    end
  end

  def create
    @talk = current_edition.talks.new(talk_params)
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
    if @talk.update(talk_params)
      redirect_to talk_path(@talk), flash: { success: 'Talk updated successfully!' }
    else
      render :edit
    end
  end

  def index
    @conference_edition = ConferenceEdition.find_by(slug: params[:conference_edition_slug])
    @talks = @conference_edition.talks.confirmed
  end

  def show
    @conference_edition = ConferenceEdition.find_by(slug: params[:conference_edition_slug])
    @talk = @conference_edition.talks.confirmed.find(params[:id])
    @speaker = @talk.speakers.first
  end

  private

  def talk_params
    params.require(:talk).permit(
      :abstract,
      :notes_to_organizers,
      :language,
      :title,
      :speaker_ids,
      :conference_edition,
      :conference_edition_id,
      :translations_attributes,
      speakers_attributes: [
        :user_id,
        :conference_edition_id,
        :name,
        :bio,
        :company,
        :job_title,
        :avatar,
        :avatar_cache,
        :city,
        :country,
        :twitter_username,
        :github_username,
        :lanyrd_username,
        :email,
        :phone,
        :website
      ]
    )
  end
end
