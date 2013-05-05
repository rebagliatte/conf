module ConferenceEditionsHelper

  def tagline(ce)
    tagline = if ce.from_date.month == ce.to_date.month
      "#{ce.from_date.strftime('%b')} #{ce.from_date.strftime('%d')}-#{ce.to_date.strftime('%d')}"
    else
      "#{ce.from_date.strftime('%b %d')} - #{ce.to_date.strftime('%b %d')}"
    end
    tagline << ", #{ce.from_date.strftime('%Y')}. #{ce.city}, #{ce.country}"
  end

end
