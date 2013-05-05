module TalksHelper

  def speaker_names(talk, conference_edition)
    speakers = talk.speakers

    if speakers.count == 1
      speaker = speakers.first
      link_to speaker.name, "#{conference_edition_speakers_path(conference_edition)}#speaker-#{speaker.twitter_username}"
    else
      speakers.map(&:name).to_sentence
    end
  end

end
