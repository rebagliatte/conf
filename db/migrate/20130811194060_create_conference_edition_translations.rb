class CreateConferenceEditionTranslations < ActiveRecord::Migration
  def up
    ConferenceEdition.create_translation_table!({
      tagline: {type: :string, default: ''},
      country: {type: :string, default: ''},
      city: {type: :string, default: ''},
      venue: {type: :string, default: ''}
    }, {
      migrate_data: true
    })
  end

  def down
    ConferenceEdition.drop_translation_table! migrate_data: true
  end
end
