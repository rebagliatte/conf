class AddLatitudeAndLongitudeToEditionVenue < ActiveRecord::Migration
  def change
    add_column :conference_editions, :venue_address, :string, default: ''
    add_column :conference_editions, :venue_latitude, :float, precision: 10, scale: 6
    add_column :conference_editions, :venue_longitude, :float, precision: 10, scale: 6
  end
end
