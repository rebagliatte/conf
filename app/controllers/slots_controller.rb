class SlotsController < ApplicationController
  def index
    @conference_edition = ConferenceEdition.find_by(slug: params[:conference_edition_slug])
  end
end
