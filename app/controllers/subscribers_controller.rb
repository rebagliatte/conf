class SubscribersController < ApplicationController
  def create
    @subscriber = current_edition.subscribers.create(subscriber_params)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:conference_edition_id, :email)
  end
end
