class SubscribersController < ApplicationController
  def create
    @subscriber = current_edition.subscribers.new(params[:subscriber])
    if @subscriber.save
      flash[:success] = 'Thanks!'
    else
      flash[:error] = 'Invalid email'
    end
    redirect_to root_path
  end
end
