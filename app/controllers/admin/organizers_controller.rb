class Admin::OrganizersController < AdminController
  load_and_authorize_resource :conference_edition

  # Organizers

  def index
    @organizers = @conference_edition.organizers
    @pending_invitations = @conference_edition.organizer_invitations.pending
  end

  def show
    @organizer = @conference_edition.organizers.find(params[:id])
  end

  def edit
    @organizer = @conference_edition.organizers.find(params[:id])
  end

  def update
    @organizer = @conference_edition.organizers.find(params[:id])

    if @organizer.update(user_params)
      flash[:success] = 'Organizer updated successfully'
      redirect_to(admin_conference_edition_organizer_path(@conference_edition.id, @organizer))
    else
      render :edit
    end
  end

  # Organizer invitations

  def new
    @organizer_invitation = @conference_edition.organizer_invitations.new()
  end

  def create
    @organizer_invitation = @conference_edition.organizer_invitations.new(organizer_invitation_params)
    @organizer_invitation.inviter = current_user

    if @organizer_invitation.save
      signup_url = new_organizer_signup_url(@organizer_invitation.token)
      UserMailer.organizer_invitation_email(@organizer_invitation, signup_url).deliver

      path = admin_conference_edition_organizers_path(@conference_edition)
      redirect_to(path, flash: { success: 'The invitation has been sent successfully!' })
    else
      render :new
    end
  end

  private

  def user_params
    params[:user] = params.require(:user).permit(
      :name,
      :nickname,
      :email,
      :image
    )
  end

  def organizer_invitation_params
    params[:organizer_invitation] = params.require(:organizer_invitation).permit(
      :invitee_email,
      :invitee_id,
      :inviter_id,
      :token
    )
  end
end
