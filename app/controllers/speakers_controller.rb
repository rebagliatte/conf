class SpeakersController < ApplicationController
  def index
    @conference_edition = ConferenceEdition.find_by(slug: params[:conference_edition_slug])
    @speakers = @conference_edition.speakers.approved
  end
end
