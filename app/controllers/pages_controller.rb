class PagesController < ApplicationController
  def home
    @posts = current_edition.posts.limit(3)
  end
end
