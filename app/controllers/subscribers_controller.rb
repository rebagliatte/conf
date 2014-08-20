class SubscribersController < ApplicationController
  def create
    @subscriber = current_edition.subscribers.new(subscriber_params)
    if @subscriber.save
      flash[:success] = 'Thanks!'
    else
      flash[:error] = 'Invalid email'
    end
    redirect_to root_path
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:conference_edition_id, :email)
  end
end
