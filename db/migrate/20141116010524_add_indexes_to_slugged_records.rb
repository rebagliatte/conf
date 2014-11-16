class AddIndexesToSluggedRecords < ActiveRecord::Migration
  def change
    add_index(:conference_editions, [:slug, :conference_id], unique: true)
    add_index(:pages, [:slug, :conference_edition_id], unique: true)
    add_index(:posts, [:slug, :conference_edition_id], unique: true)
    add_index(:talks, [:slug, :conference_edition_id], unique: true)
  end
end
