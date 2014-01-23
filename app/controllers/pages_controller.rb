class PagesController < ApplicationController
  def show
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @page = Page.find(params[:id])
  end
end
