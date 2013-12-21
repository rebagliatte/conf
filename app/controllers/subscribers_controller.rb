class SubscribersController < ApplicationController
  def create
    @subscriber = current_edition.subscribers.new(params[:subscriber])
    if @subscriber.save
      redirect_to root_path, flash: { success: "Thanks!" }
    else
      render :news
    end
  end
end
