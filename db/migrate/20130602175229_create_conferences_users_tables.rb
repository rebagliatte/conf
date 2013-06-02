class CreateConferencesUsersTables < ActiveRecord::Migration
  def change
    create_table :conferences_users do |t|
      t.integer :conference_id
      t.integer :user_id
    end

    add_index 'conferences_users', ['conference_id'], name: 'index_conferences_users_on_conference_id'
    add_index 'conferences_users', ['user_id'], name: 'index_conferences_users_on_user_id'
  end
end
