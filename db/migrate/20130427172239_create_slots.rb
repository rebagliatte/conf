class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.datetime :from_datetime
      t.datetime :to_datetime
      t.string :kind, null:false, default: 'talk'
      t.integer :conference_edition_id

      t.timestamps
    end
  end
end
