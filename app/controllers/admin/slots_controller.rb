class Admin::SlotsController < AdminController

  before_action :set_slot_params, only: [ :create, :update ]

  load_and_authorize_resource :conference_edition
  load_and_authorize_resource :slot, through: :conference_edition

  def index
    @days = @conference_edition.event_dates
    @current_day = params[:day] || @days.first.to_s
    @current_day_slots = @slots.where(day: @current_day)
  end

  def show
  end

  def new
    last_slot = @conference_edition.slots.where('id IS NOT NULL').last

    if last_slot
      @slot.day = last_slot.day
      @slot.start_time = last_slot.end_time
      @slot.end_time = last_slot.end_time + 30.minutes
    end
  end

  def create
    if @slot.save
      redirect_to admin_conference_edition_slots_path(@conference_edition.id), flash: { success: 'Slot created successfully!' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @slot.update(params[:slot])
      redirect_to admin_conference_edition_slots_path(@conference_edition.id), flash: { success: 'Slot updated successfully!' }
    else
      render :edit
    end
  end

  private

  def set_slot_params
    params[:slot] = params.require(:slot).permit(
      :day,
      :end_time,
      :kind,
      :label,
      :room_id,
      :start_time,
      :talk,
      :talk_id
    )
  end
end
