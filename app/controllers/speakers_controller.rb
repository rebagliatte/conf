class SpeakersController < ApplicationController
  def index
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @speakers = @conference_edition.speakers.order('name ASC')
  end
end
