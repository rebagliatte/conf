class AlterSpeakers < ActiveRecord::Migration
  def up
    remove_column :speakers, :is_confirmed
    add_column :speakers, :status, :string, null: false, default: ''
    add_column :conference_editions, :is_speaker_listing_available, :boolean, null: false, default: false
  end

  def down
    add_column :speakers, :is_confirmed, :boolean, null: false, default: false
    remove_column :speakers, :status
    remove_column :conference_editions, :is_speaker_listing_available
  end
end
