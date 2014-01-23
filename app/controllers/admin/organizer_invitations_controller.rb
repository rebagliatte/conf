class Admin::OrganizerInvitationsController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :organizer_invitation, through: :conference_edition

  def new
  end

  def create
    @organizer_invitation.inviter = current_user

    if @organizer_invitation.save
      signup_url = new_organizer_signup_url(@organizer_invitation.token)
      UserMailer.organizer_invitation_email(@organizer_invitation, signup_url).deliver

      path = organizers_admin_conference_conference_edition_path(@conference_edition.conference, @conference_edition)
      redirect_to path, flash: { success: 'The invitation has been sent successfully!' }
    else
      render :new
    end
  end

end