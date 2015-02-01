class Admin::TicketsController < AdminController

  before_action :set_ticket_params, only: [ :create, :update ]

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :ticket, through: :conference_edition

  def index
  end

  def show
  end

  def new
  end

  def create
    if @ticket.save
      flash[:success] = 'Ticket created successfully!'
      redirect_to admin_conference_edition_ticket_path(@conference_edition.id, @ticket)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket.update(params[:ticket])
      flash[:success] = 'Ticket updated successfully!'
      redirect_to admin_conference_edition_ticket_path(@conference_edition.id, @ticket)
    else
      render :edit
    end
  end

  private

  def set_ticket_params
    params[:ticket] = params.require(:ticket).permit(
      :name,
      :description,
      :price,
      :quantity,
      :start_date,
      :end_date
    )
  end
end
