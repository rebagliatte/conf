class CreateNotifications < ActiveRecord::Migration
  def up
    create_table :notifications do |t|
      t.integer :conference_edition_id, null: false
      t.integer :organizer_id, null: false
      t.string :recipients, null: false, default: ''
      t.string :recipient_emails, null: false, default: ''
      t.timestamps
    end

    Notification.create_translation_table!({
      subject: { type: :string, null: false, default: '' },
      body: { type: :text, null: false, default: '' }
    })
  end

  def down
    drop_table :notifications
    Notification.drop_translation_table!
  end
end
