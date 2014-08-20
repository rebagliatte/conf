class Admin::ConferencesController < AdminController

  before_action :set_conference_params, only: [ :create, :update ]
  load_and_authorize_resource

  def show
  end

  def index
  end

  def new
    @conference.conference_editions.build
  end

  def create
    if @conference.save
      first_edition = @conference.conference_editions.first
      first_edition.organizers << current_user

      redirect_url = admin_conference_edition_organizers_path(first_edition)
      message = "Conference created successfully! Go ahead and invite in some co-organizers."
      redirect_to redirect_url, flash: { success: message }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @conference.update(params[:conference])
      redirect_to admin_conference_path(@conference), flash: { success: 'Conference updated successfully!' }
    else
      render :edit
    end
  end

  private

  def set_conference_params
    params[:conference] = params.require(:conference).permit(
      :custom_domain,
      :disqus_shortname,
      :email,
      :facebook_page_username,
      :lanyrd_series_name,
      :name,
      :owner_id,
      :subdomain,
      :twitter_hashtag,
      :twitter_username,
      :youtube_channel_id,
      :language_ids => [],
      :conference_editions_attributes => [
        :city,
        :country,
        :from_date,
        :kind,
        :logo,
        :to_date,
        :venue
      ]
    )
  end
end
