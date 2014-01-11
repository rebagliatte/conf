class ConferencesController < ApplicationController
  def index
    @conferences = Conference.all
  end

  def show
    if current_conference
      @posts = current_edition.posts.limit(3)
      @subscriber = current_edition.subscribers.new()
    else
      message = 'No conference found with that domain/subdomain combination.'
      redirect_to conferences_path, flash: { error: message }
    end
  end
end
