class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.integer :conference_edition_id, null: false
      t.timestamps
    end

    Page.create_translation_table!({
      title: { type: :string, null: false, default: '' },
      content: { type: :text, null: false, default: '' }
    })
  end

  def down
    drop_table :pages
    Page.drop_translation_table!
  end
end
