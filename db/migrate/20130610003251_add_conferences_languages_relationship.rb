class AddConferencesLanguagesRelationship < ActiveRecord::Migration
  def change
    create_table :conferences_languages do |t|
      t.integer :conference_id
      t.integer :language_id
    end

    add_index 'conferences_languages', ['conference_id'], name: 'index_conferences_languages_on_conference_id'
    add_index 'conferences_languages', ['language_id'], name: 'index_conferences_languages_on_language_id'
  end
end
