class PostsController < ApplicationController
  def index
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @posts = Post.where(conference_edition_id: @conference_edition.id)
  end

  def show
    @post = Post.find(params[:id])
  end
end
