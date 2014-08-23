class Admin::SponsorsController < AdminController

  before_action :set_sponsor_params,
  only: [:create, :update]

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :sponsor, :through => :conference_edition

  def index
  end

  def show
    @sponsor_contacts = @sponsor.sponsor_contacts.where('id IS NOT NULL')
    @sponsor_contact = @sponsor.sponsor_contacts.build()
  end

  def new
    build_translations_for(@conference_edition, @sponsor)
  end

  def create
    if @sponsor.save
      redirect_to admin_conference_edition_sponsor_path(@conference_edition, @sponsor), flash: { success: 'Sponsor created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @sponsor.update(params[:sponsor])
      redirect_to admin_conference_edition_sponsor_path(@conference_edition, @sponsor), flash: { success: 'Sponsor updated successfully!' }
    else
      render :edit
    end
  end

  private

  def set_sponsor_params
    params[:sponsor] = params.require(:sponsor).permit(
      :kind,
      :logo,
      :name,
      :website_url,
      translations_attributes: [
        :description,
        :id,
        :locale
      ]
    )
  end
end
