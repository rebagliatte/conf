class ConferenceEditionsController < ApplicationController
  def index
    @conference_editions = ConferenceEdition.previous_editions
  end

  def show
    @conference_edition = ConferenceEdition.find(params[:id])
  end
end
