class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.datetime :from
      t.datetime :to
      t.string :kind, null:false, default: 'talk'
      t.integer :conference_edition_id

      t.timestamps
    end
  end
end
