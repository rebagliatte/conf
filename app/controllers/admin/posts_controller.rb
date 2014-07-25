class Admin::PostsController < AdminController

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :post, through: :conference_edition

  def index
  end

  def show
  end

  def new
    @conference_edition.languages.map(&:code).each do |locale|
      @post.translations.build locale: locale
    end
  end

  def create
    if @post.save
      redirect_to admin_conference_edition_post_path(@conference_edition, @post), flash: { success: 'Post created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(params[:post])
      redirect_to admin_conference_edition_post_path(@conference_edition, @post), flash: { success: 'Post updated successfully!' }
    else
      render :edit
    end
  end
end
