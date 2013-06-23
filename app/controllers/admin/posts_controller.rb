class Admin::PostsController < AdminController
  def index
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @posts = @conference_edition.posts
  end

  def show
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @post = @conference_edition.posts.find(params[:id])
  end

  def new
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @post = @conference_edition.posts.build

    @conference_edition.languages.map(&:code).each do |locale|
      @post.translations.build locale: locale
    end
  end

  def create
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @post = @conference_edition.posts.build(params[:post])
    if @post.save
      redirect_to admin_conference_edition_post_path(@conference_edition, @post), flash: { success: 'Post created successfully!' }
    else
      render :new
    end
  end

  def edit
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @post = @conference_edition.posts.find(params[:id])
  end

  def update
    @conference_edition = ConferenceEdition.find(params[:conference_edition_id])
    @post = @conference_edition.posts.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to admin_conference_edition_post_path(@conference_edition, @post), flash: { success: 'Post updated successfully!' }
    else
      render :edit
    end
  end
end
