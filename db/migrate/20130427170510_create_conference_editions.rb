class CreateConferenceEditions < ActiveRecord::Migration
  def change
    create_table :conference_editions do |t|
      t.integer :conference_id, null:false
      t.date :from_date, null:false
      t.date :to_date, null:false
      t.string :tagline, default: ''
      t.string :kind, null: false, default: 'single_track'
      t.string :status, null: false, default: 'past'
      t.string :country, default: ''
      t.string :city, default: ''
      t.string :venue, default: ''
      t.string :promo_video_provider, default: ''
      t.string :promo_video_uid, default: ''
      t.string :promo_image, default: ''
      t.string :logo, default: ''

      t.timestamps
    end
  end
end
