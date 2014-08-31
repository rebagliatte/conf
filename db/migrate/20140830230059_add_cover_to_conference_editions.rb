class AddCoverToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :cover, :string, default: ''
  end
end
