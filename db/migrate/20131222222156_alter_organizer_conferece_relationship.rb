class AlterOrganizerConfereceRelationship < ActiveRecord::Migration
  def change
    # Don't relate confereces and users
    remove_index(:conferences_users, name: 'index_conferences_users_on_conference_id')
    remove_index(:conferences_users, name: 'index_conferences_users_on_user_id')
    drop_table :conferences_users

    # Relate users to conference editions instead
    create_table :conference_editions_users do |t|
      t.integer :conference_edition_id
      t.integer :user_id
    end

    add_index 'conference_editions_users', ['conference_edition_id'], name: 'index_conference_editions_users_on_conference_edition_id'
    add_index 'conference_editions_users', ['user_id'], name: 'index_conference_editions_users_on_user_id'
  end
end
