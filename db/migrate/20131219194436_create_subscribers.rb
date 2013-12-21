class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :conference_edition_id
      t.string :email

      t.timestamps
    end

    add_column :conference_editions, :is_email_subscription_enabled, :boolean, null: false, default: true
    add_column :conference_edition_translations, :notes_to_subscribers, :text, default: ''
  end
end
