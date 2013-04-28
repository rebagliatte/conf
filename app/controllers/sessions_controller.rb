class SessionsController < ApplicationController

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
        redirect_to root_url, notice: 'Signed in!'
      else
        # No user is associated with the identity, let's create a new one
        user = User.create_with_omniauth(auth['info'])
        @identity.update_attributes(user: user)
        self.current_user = user

        redirect_to root_url, notice: 'Successfully created a new user and its first identity'
      end
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, notice: "Signed out!"
  end

end
