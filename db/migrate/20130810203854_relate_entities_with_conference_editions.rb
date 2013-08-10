class RelateEntitiesWithConferenceEditions < ActiveRecord::Migration
  def change
    # Add relationship with conference editions
    add_column :speakers, :conference_edition_id, :integer, null: false
    add_column :talks, :conference_edition_id, :integer, null: false
    add_column :rooms, :conference_edition_id, :integer, null: false

    # Make it required for existing entities
    change_column :posts, :conference_edition_id, :integer, null: false
    change_column :slots, :conference_edition_id, :integer, null: false
    change_column :sponsors, :conference_edition_id, :integer, null: false
  end
end
