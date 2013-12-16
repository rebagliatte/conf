class ImproveCallForProposals < ActiveRecord::Migration
  def change
    add_column :talks, :notes_to_organizers, :text, default: ''
    add_column :talks, :language, :string, null: false
    add_column :conference_editions, :notes_to_speakers, :text, default: ''
    add_column :speakers, :lanyrd_username, :string, default: ''
    add_column :speakers, :job_title, :string, default: ''
    add_column :speakers, :phone, :string, default: ''
    add_column :speakers, :website, :string, default: ''
  end
end
