class AddSlugToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :slug, :string, null: false, default: ''
    add_column :talks, :slug, :string, null: false, default: ''
  end
end
