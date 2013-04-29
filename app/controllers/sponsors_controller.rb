class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.where(conference_edition_id: params[:conference_edition_id])
    @sponsor_kinds = @sponsors.group_by { |t| t.kind }
  end
end
