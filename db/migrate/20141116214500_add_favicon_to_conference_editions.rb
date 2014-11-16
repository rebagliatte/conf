class AddFaviconToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :favicon, :string, null: false, default: ''
  end
end
