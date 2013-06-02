class CreatePostTranslations < ActiveRecord::Migration
  def up
    Post.create_translation_table!({
      title: :string,
      summary: :string,
      body: :text
    }, {
      migrate_data: true
    })
  end

  def down
    Post.drop_translation_table! migrate_data: true
  end
end
