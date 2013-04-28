class ConferenceEditionsController < ApplicationController
  def show
    @conference_edition = ConferenceEdition.last
  end
end
