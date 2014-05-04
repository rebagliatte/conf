class CreateSponsorContacts < ActiveRecord::Migration
  def up
    create_table :sponsor_contacts do |t|
      t.integer :conference_edition_id, null: false
      t.integer :sponsor_id, null: false
      t.integer :language_id, null: false
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.timestamps
    end
  end

  def down
    drop_table :notifications
  end
end
