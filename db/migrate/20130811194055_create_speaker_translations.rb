class CreateSpeakerTranslations < ActiveRecord::Migration
  def up
    Speaker.create_translation_table!({
      bio: {type: :text, default: ''}
    }, {
      migrate_data: true
    })
  end

  def down
    Speaker.drop_translation_table! migrate_data: true
  end
end
