class CreateConferenceEditions < ActiveRecord::Migration
  def change
    create_table :conference_editions do |t|
      t.integer :conference_year, null: false
      t.string :description, default: ''
      t.string :kind, null: false, default: 'single_track'
      t.string :status, null: false, default: 'past'
      t.string :country, default: ''
      t.string :city, default: ''
      t.string :venue, default: ''
      t.string :promotional_video_url, default: ''

      t.timestamps
    end
  end
end
