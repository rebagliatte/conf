class PagesController < ApplicationController
  def home
    @posts = Post.limit(3)
  end
end
