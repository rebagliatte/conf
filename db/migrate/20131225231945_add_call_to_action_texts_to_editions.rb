class AddCallToActionTextsToEditions < ActiveRecord::Migration
  def change
    add_column :conference_edition_translations, :speakers_call_to_action_text, :text, default: ''
    add_column :conference_edition_translations, :sponsors_call_to_action_text, :text, default: ''
  end
end
