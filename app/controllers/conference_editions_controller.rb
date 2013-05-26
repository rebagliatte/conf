class ConferenceEditionsController < ApplicationController
  def index
    @conference_editions = ConferenceEdition.previous_editions
  end
end
