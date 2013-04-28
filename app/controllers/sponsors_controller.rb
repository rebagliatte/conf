class SponsorsController < ApplicationController
  def index
    @conference_edition_id = params[:conference_edition_id]
    @sponsors = Sponsor.where(conference_edition_id: @conference_edition_id)
    @sponsor_kinds = @sponsors.group_by { |t| t.kind }
  end
end
