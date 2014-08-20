class Admin::PostsController < AdminController

  before_action :set_post_params, only: [ :create, :update ]

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

  private

  def set_post_params
    params[:post] = params.require(:post).permit(:body, :conference_edition, \
      :conference_edition_id, :image, :summary, :title, :translations_attributes
    )
  end
end
