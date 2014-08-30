module ConferenceEditionsHelper

  def pretty_date(ce)
    string = if ce.from_date.month == ce.to_date.month
      "#{ce.from_date.strftime('%b')} #{ce.from_date.strftime('%d')}-#{ce.to_date.strftime('%d')}"
    else
      "#{ce.from_date.strftime('%b %d')} - #{ce.to_date.strftime('%b %d')}"
    end
    string << ", #{ce.from_date.strftime('%Y')}"
    string
  end

  def pretty_city(ce)
    "#{ce.city}, #{ce.country}"
  end

  def pretty_conference_and_year(ce)
    "#{ce.conference.name} #{ce.from_date.year}"
  end

  def pretty_year(ce)
    ce.from_date.year
  end

  def full_venue_address(ce)
    if ce.venue_address.present? && ce.city.present? && ce.country.present?
      "#{ce.venue}. #{ce.venue_address}, #{ce.city} - #{ce.country}"
    end
  end

  def is_coming_soon?(ce)
    ce.from_date > Date.today
  end

  def is_over?(ce)
    ce.to_date < Date.today
  end

  def display_registration_link?(ce)
    !is_over?(ce) && ce.is_registration_open && ce.registration_url.present?
  end

  def display_call_for_sponsorships?(ce)
    is_coming_soon?(ce) && ce.is_call_for_sponsorships_open
  end

  def available_image_uploads(ce)
    maximum = Image::MAX_IMAGES_PER_EDITION
    uploaded_images = ce.images.count
    maximum - uploaded_images
  end

end
