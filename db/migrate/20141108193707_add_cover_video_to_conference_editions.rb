class AddCoverVideoToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :cover_video_webm, :string, null: false, default: ''
    add_column :conference_editions, :cover_video_mp4, :string, null: false, default: ''
  end
end
