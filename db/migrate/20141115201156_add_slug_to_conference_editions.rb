class AddSlugToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :slug, :string, null: false, default: ''
  end
end
