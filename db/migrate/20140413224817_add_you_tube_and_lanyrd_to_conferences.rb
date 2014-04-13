class AddYouTubeAndLanyrdToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :lanyrd_series_name, :string, null: false, default: ''
    add_column :conferences, :youtube_channel_id, :string, null: false, default: ''
  end
end
