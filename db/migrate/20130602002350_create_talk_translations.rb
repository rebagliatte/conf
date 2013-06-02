class CreateTalkTranslations < ActiveRecord::Migration
  def up
    Talk.create_translation_table!({
      title: :string,
      abstract: :string
    }, {
      migrate_data: true
    })
  end

  def down
    Talk.drop_translation_table! migrate_data: true
  end
end
