class AddIsLocationAvailableToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :is_location_available, :boolean, default: false
  end
end
