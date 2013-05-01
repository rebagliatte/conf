class SlotsController < ApplicationController
  def index
    @slots = Slot.includes(:talks).where(conference_edition_id: params[:conference_edition_id]).order('from_datetime')
    @slot_days = @slots.group_by { |t| t.from_datetime.beginning_of_day }
  end
end
