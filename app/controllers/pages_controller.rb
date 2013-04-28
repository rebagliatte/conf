class PagesController < ApplicationController
  def home
    @posts = Post.order('created_at desc').limit(3)
  end
end
