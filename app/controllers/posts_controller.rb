class PostsController < ApplicationController
  def index
    @posts = Post.where(conference_edition_id: params[:conference_edition_id])
  end

  def show
    @post = Post.find(params[:id])
  end
end
