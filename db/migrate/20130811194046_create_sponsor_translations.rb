class CreateSponsorTranslations < ActiveRecord::Migration
  def up
    Sponsor.create_translation_table!({
      description: {type: :text, default: ''}
    }, {
      migrate_data: true
    })
  end

  def down
    Sponsor.drop_translation_table! migrate_data: true
  end
end
