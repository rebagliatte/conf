module TalksHelper

  def speaker_names(talk, conference_edition)
    speakers = talk.speakers

    if speakers.count == 1
      speakers.first.name
    else
      speakers.map(&:name).to_sentence
    end
  end

end
