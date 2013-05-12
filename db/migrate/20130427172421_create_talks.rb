class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title, null:false, default: ''
      t.string :abstract, default: ''
      t.string :status, default: ''
      t.string :slides_url, default: ''
      t.string :video_url, default: ''
      t.integer :slot_id
      t.integer :room_id

      t.timestamps
    end
  end
end
