module TalksHelper

  def speaker_names(talk, conference_edition)
    speakers = talk.speakers

    if speakers.count == 1
      speakers.first.name
    else
      speakers.map(&:name).to_sentence
    end
  end

  def status_class(talk)
    case talk.status
    when 'approved' then 'success'
    when 'rejected' then 'warning'
    when 'pending' then 'info'
    end
  end

  def available_statuses(status)
    Talk::VALID_STATUS_TRANSITIONS[status]
  end

  def status_cta_copy(status)
    case status
    when 'approved' then 'approve'
    when 'rejected' then 'reject'
    when 'pending' then 'move back to pending'
    when 'confirmed' then 'speaker has confirmed'
    when 'cancelled' then 'speaker has cancelled'
    end
  end

  def status_cta_class(status)
    string = 'btn btn-large '
    string += status == 'pending' ? '' : 'btn-primary '
    string += ['rejected', 'cancelled'].include?(status) ? 'btn-danger' : ''
  end

  def status_form_class(status)
    string = 'form-horizontal '
    string += ['confirmed', 'cancelled'].include?(status) ? 'pull-right' : 'pull-left'
  end

end
