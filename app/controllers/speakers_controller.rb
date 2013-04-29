class SpeakersController < ApplicationController
  def index
    @speakers = ConferenceEdition.find(params[:conference_edition_id]).speakers
  end
end
