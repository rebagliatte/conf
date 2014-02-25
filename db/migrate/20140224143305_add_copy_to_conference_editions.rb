class AddCopyToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_edition_translations, :news_intro, :text, default: ''
    add_column :conference_edition_translations, :about, :text, default: ''
  end
end
