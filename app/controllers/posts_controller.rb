class PostsController < ApplicationController
  def index
    @conference_edition = ConferenceEdition.find_by(slug: params[:conference_edition_slug])
    @posts = Post.where(conference_edition_id: @conference_edition.id)
  end

  def show
    @conference_edition = ConferenceEdition.find_by(slug: params[:conference_edition_slug])
    @post = Post.find(params[:id])
  end
end
