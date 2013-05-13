class ConferencesController < ApplicationController
  def index
    @conferences = Conference.all
  end

  def show
    @posts = current_edition.posts.limit(3)
  end
end
