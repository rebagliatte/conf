module SlotsHelper

  def available_dates(conference_edition)
    conference_edition.event_dates.map{ |date| [date.strftime("%b %d"), date] }
  end

  def available_talks(slot)
    slot.conference_edition.talks.confirmed.map{ |talk| [talk.to_s, talk.id] }
  end

  def timespan(slot)
    "#{slot.start_time.strftime('%H:%M')} - #{slot.end_time.strftime('%H:%M')}"
  end

end
