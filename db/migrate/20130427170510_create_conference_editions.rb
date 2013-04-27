class CreateConferenceEditions < ActiveRecord::Migration
  def change
    create_table :conference_editions do |t|
      t.string :name, null: false, default: ''
      t.string :description, default: ''
      t.string :venue, default: ''
      t.string :kind, default: 'single_track'
      t.string :promotional_video_url, default: ''

      t.timestamps
    end
  end
end
