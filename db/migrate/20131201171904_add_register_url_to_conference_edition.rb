class AddRegisterUrlToConferenceEdition < ActiveRecord::Migration
  def change
    add_column :conference_editions, :registration_url, :string, default: ''
  end
end
