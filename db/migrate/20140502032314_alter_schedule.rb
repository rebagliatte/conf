class AlterSchedule < ActiveRecord::Migration
  def up
    remove_column(:talks, :slot_id)
    remove_column(:talks, :room_id)
    add_column(:slots, :room_id, :integer)
    add_column(:slots, :talk_id, :integer)
    remove_column(:slots, :from_datetime)
    remove_column(:slots, :to_datetime)
    add_column(:slots, :day, :date, null: false)
    add_column(:slots, :start_time, :time, null: false)
    add_column(:slots, :end_time, :time, null: false)
  end

  def down
    add_column(:talks, :slot_id, :integer)
    add_column(:talks, :room_id, :integer)
    remove_column(:slots, :room_id)
    remove_column(:slots, :talk_id)
    add_column(:slots, :from_datetime, :datetime)
    add_column(:slots, :to_datetime, :datetime)
    remove_column(:slots, :day)
    remove_column(:slots, :start_time)
    remove_column(:slots, :end_time)
  end
end
