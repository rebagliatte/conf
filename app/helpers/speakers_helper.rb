module SpeakersHelper

  def avatar_for(speaker)
    image_src = if speaker.avatar.present?
      speaker.avatar
    elsif speaker.email
      email_hash = Digest::MD5.hexdigest(speaker.email).to_s
      "http://www.gravatar.com/avatar/#{email_hash}?s=45"
    end

    image_tag(image_src)
  end

end
