class SponsorsController < ApplicationController
  def index
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
  end
end
