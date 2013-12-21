class ConferencesController < ApplicationController
  def index
    @conferences = Conference.all
  end

  def show
    @posts = current_edition.posts.limit(3)
    @subscriber = current_edition.subscribers.new()
  end
end
