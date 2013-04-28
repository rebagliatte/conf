class AddFieldsToConferenceEdition < ActiveRecord::Migration
  def change
    add_column :conference_editions, :status, :string, null: false, default: 'past'
  end
end
