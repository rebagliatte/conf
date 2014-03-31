class UserMailer < ActionMailer::Base
  def organizer_invitation_email(organizer_invitation, signup_url)
    @organizer_invitation = organizer_invitation
    @inviter_name = @organizer_invitation.inviter.name
    @conference_name = @organizer_invitation.conference.name
    @signup_url = signup_url

    mail(
      from: @organizer_invitation.conference.email,
      to: @organizer_invitation.invitee_email,
      subject: "Join #{ @conference_name } organizing team"
    )
  end

  def notification_email(notification)
    @body = notification.body

    mail(
      from: notification.organizer.email,
      to: notification.recipient_emails,
      subject: notification.subject
    )
  end
end
