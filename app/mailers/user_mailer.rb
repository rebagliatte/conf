class UserMailer < ActionMailer::Base
  def organizer_invitation_email(organizer_invitation, signup_url)
    @organizer_invitation = organizer_invitation
    @inviter_name = @organizer_invitation.inviter.name
    @conference_name = @organizer_invitation.conference.name
    @signup_url = signup_url

    from_email = @organizer_invitation.inviter.try(:email) || @organizer_invitation.conference.email

    subject = "Join #{ @conference_name } organizing team"
    mail(from: from_email, to: @organizer_invitation.invitee_email, subject: subject)
  end
end
