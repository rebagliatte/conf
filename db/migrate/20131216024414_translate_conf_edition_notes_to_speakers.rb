class TranslateConfEditionNotesToSpeakers < ActiveRecord::Migration
  def change
    add_column :conference_edition_translations, :notes_to_speakers, :text, default: ''
    remove_columns :conference_editions, :notes_to_speakers
  end
end
