class AddRegistrationCallToActionNotes < ActiveRecord::Migration
  def change
    add_column :conference_edition_translations, :registration_call_to_action, :text, default: ''
  end
end
