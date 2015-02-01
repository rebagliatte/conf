class PagesController < ApplicationController
  def show
    @conference_edition = ConferenceEdition.find_by(slug: params[:conference_edition_slug])
    @page = Page.find(params[:id])
  end
end
