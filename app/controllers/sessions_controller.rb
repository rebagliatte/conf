class SessionsController < ApplicationController
  layout 'admin'

  def new
    if params[:organizer_invitation_token]
      # Load organizer invitation
      organizer_invitation = OrganizerInvitation.find_by(token: params[:organizer_invitation_token])

      # Check if the invitation is still valid
      if organizer_invitation && organizer_invitation.invitee_id.nil?
        session[:organizer_invitation_token] = organizer_invitation.token

        # Assign the invitation to the current user if there is one
        if current_user
          handle_invitation_token
          session[:redirect_path] = admin_conference_path(organizer_invitation.conference)
          flash[:success] = 'Welcome to the team!'
        else
          @organizer_invitation = organizer_invitation
        end
      else
        session[:organizer_invitation_token] = nil
        flash[:danger] = 'Invalid invitation'
      end
    end

    if current_user
      redirect_to(session[:redirect_path] || root_url)
    else
      @user = User.new
    end
  end

  def create
    auth = request.env['omniauth.auth']

    # Authenticate
    if auth.present?
      authenticate_with_external_services(auth)
    else
      authenticate_with_email_and_password
    end

    if current_user
      # Handle organizer invitations
      handle_invitation_token if session[:organizer_invitation_token]

      # Redirect
      redirect_to(session[:redirect_path] || root_url)
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, flash: { info: 'Signed out' }
  end

  private

  #
  # Authenticate with github or twitter
  #
  def authenticate_with_external_services(auth)
    # Find an identity
    @identity = Identity.find_with_omniauth(auth)

    if @identity.nil?
      # If no identity was found, create a brand new one
      @identity = Identity.create_with_omniauth(auth)
    end

    if signed_in?
      if @identity.user == current_user
        # The identity is already associated with the current user
        redirect_to root_url, info: 'That account has already been linked with your user'
      else
        # The identity is not associated with the current_user, let's make that happen
        @identity.user = current_user
        @identity.save()
        redirect_to root_url, info: 'Successfully linked that account!'
      end
    else
      if @identity.user.present?
        # The identity is associated with a user, let's log it in
        self.current_user = @identity.user
        flash[:info] = 'Welcome back!'
      else
        # No user is associated with the identity, let's create a new one
        user = User.create_with_omniauth(auth['info'])
        @identity.update(user: user)
        self.current_user = user
        flash[:info] = "Welcome #{current_user.name}!"
      end
    end
  end

  #
  # Authenticate with email/password
  #
  def authenticate_with_email_and_password
    @user = User.find_by(email: params[:user][:email])

    if @user
      # Try to log it in
      if @user.has_internal_authentication?
        if @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          flash[:success] = 'Welcome back'
        else
          flash.now[:danger] = 'Invalid email or password'
          render :new
        end
      else
        provider = @user.identities.first.provider
        flash.now[:danger] = "This email is already linked to a #{provider} account."
        render :new
      end
    else
      # Create it
      @user = User.new(
        email: params[:user][:email],
        name: params[:user][:email].split('@').first,
        password: params[:user][:password],
        internal_authentication: true
      )

      if @user.save
        session[:user_id] = @user.id
        flash[:success] = 'Signed up'
      else
        render :new
      end
    end
  end

  #
  # Handle organizer invitations
  #
  def handle_invitation_token
    invitation = OrganizerInvitation.find_by(token: session[:organizer_invitation_token])

    organizers = invitation.conference_edition.organizers

    if !organizers.include?(current_user)
      # Add the user as an organizer
      organizers << current_user

      # Expire the invitation
      invitation.update_attributes!(invitee_id: current_user.id)

      # Store the invitee email if it isn't set already
      if current_user.email.blank?
        current_user.update_attributes!(email: invitation.invitee_email)
      end
    end

    session[:organizer_invitation_token] = nil
  end
end
