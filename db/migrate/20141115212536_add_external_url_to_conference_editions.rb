class AddExternalUrlToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :external_url, :string, null: false, default: ''
  end
end
