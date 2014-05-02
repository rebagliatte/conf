module SlotsHelper

  def available_dates(conference_edition)
    conference_edition.event_dates.map{ |date| [date.strftime("%b %d"), date] }
  end

  def available_talks(slot)
    talk_hash = slot.conference_edition.talks.confirmed.map{ |talk| [talk.to_s, talk.id] }
    talk_hash.reject! {| key, value | slot.taken_talks_ids.include?(value) }
    talk_hash
  end

  def timespan(slot)
    "#{slot.start_time.strftime('%H:%M')} - #{slot.end_time.strftime('%H:%M')}"
  end

end
