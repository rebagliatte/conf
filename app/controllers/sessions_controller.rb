class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to root_url, notice: 'You are already signed in'
    elsif params[:organizer_invitation_token]
      @organizer_invitation = OrganizerInvitation.find_by_token(params[:organizer_invitation_token])
      if @organizer_invitation && @organizer_invitation.invitee_id.nil?
        session[:organizer_invitation_token] = @organizer_invitation.token
        render layout: 'admin'
      else
        session[:organizer_invitation_token] = nil
        redirect_to root_url, flash: { error: 'Invalid invitation' }
      end
    else
      render layout: 'admin'
    end
  end

  def create
    auth = request.env['omniauth.auth']

    # Find an identity
    @identity = Identity.find_with_omniauth(auth)

    if @identity.nil?
      # If no identity was found, create a brand new one
      @identity = Identity.create_with_omniauth(auth)
    end

    if signed_in?
      if @identity.user == current_user
        # The identity is already associated with the current user
        redirect_to root_url, notice: 'That account has already been linked with your user'
      else
        # The identity is not associated with the current_user, let's make that happen
        @identity.user = current_user
        @identity.save()
        redirect_to root_url, notice: 'Successfully linked that account!'
      end
    else
      if @identity.user.present?
        # The identity is associated with a user, let's log it in
        self.current_user = @identity.user
        flash[:notice] = 'Signed in!'
      else
        # No user is associated with the identity, let's create a new one
        user = User.create_with_omniauth(auth['info'])
        @identity.update_attributes(user: user)
        self.current_user = user
        flash[:notice] = "Welcome #{current_user.name}!"
      end

      # If a organizer invitations token is present, use it and destroy it
      if session[:organizer_invitation_token]
        invitation = OrganizerInvitation.find_by_token(session[:organizer_invitation_token])

        organizers = invitation.conference_edition.organizers

        unless organizers.include?(current_user)
          organizers << current_user
          invitation.update_attributes!(invitee_id: current_user.id)
          current_user.update_attributes!(email: invitation.invitee_email)
        end

        session[:organizer_invitation_token] = nil
      end

      # Redirect to admin if he/she is an organizer
      if current_user.manageable_editions.any?
        redirect_to admin_conferences_url
      else
        redirect_to root_url
      end
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, notice: "Signed out"
  end

end
