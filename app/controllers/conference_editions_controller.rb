class ConferenceEditionsController < ApplicationController
  def index
    @conference_edition = ConferenceEdition.previous_editions
  end

  def show
  end
end
