class Admin::CodesController < AdminController

  before_action :set_code_params, only: [ :create, :update ]

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :code, through: :conference_edition

  def index
  end

  def show
  end

  def new
  end

  def create
    if @code.save
      flash[:success] = 'Code created successfully!'
      redirect_to admin_conference_edition_code_path(@conference_edition.id, @code)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @code.update(params[:code])
      flash[:success] = 'Code updated successfully!'
      redirect_to admin_conference_edition_code_path(@conference_edition.id, @code)
    else
      render :edit
    end
  end

  private

  def set_code_params
    params[:code] = params.require(:code).permit(
      :code,
      :discount,
      :start_date,
      :end_date,
      :quantity
    )
  end
end
