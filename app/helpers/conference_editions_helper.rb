module ConferenceEditionsHelper

  def pretty_date_and_location(ce)
    string = if ce.from_date.month == ce.to_date.month
      "#{ce.from_date.strftime('%b')} #{ce.from_date.strftime('%d')}-#{ce.to_date.strftime('%d')}"
    else
      "#{ce.from_date.strftime('%b %d')} - #{ce.to_date.strftime('%b %d')}"
    end
    string << ", #{ce.from_date.strftime('%Y')}."
    string << " #{ce.city}, #{ce.country}" if ce.city.present? && ce.country.present?
    string
  end

  def pretty_conference_and_year(ce)
    "#{ce.conference.name} #{ce.from_date.year}"
  end

  def pretty_year(ce)
    ce.from_date.year
  end

  def display_settings?(ce)
    ce.new_record? || ce.future?
  end

  def is_coming_soon?(ce)
    ce.from_date > Date.today
  end

  def is_over?(ce)
    ce.to_date < Date.today
  end

end
