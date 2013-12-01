class AlterConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :is_registration_open, :boolean, default: true
    add_column :conference_editions, :is_call_for_proposals_open, :boolean, default: true
    add_column :conference_editions, :is_call_for_sponsorships_open, :boolean, default: true
    add_column :conference_editions, :is_schedule_available, :boolean, default: false
    remove_column :conference_editions, :status
  end
end
