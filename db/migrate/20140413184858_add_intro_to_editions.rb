class AddIntroToEditions < ActiveRecord::Migration
  def change
    add_column :conference_edition_translations, :intro, :string, null: false, default: ''
  end
end
