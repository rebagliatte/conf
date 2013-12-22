class ImproveDbRestrictions < ActiveRecord::Migration
  def change
    change_column :conference_editions, :is_registration_open, :boolean, default: false
    change_column :images, :conference_edition_id, :integer, null: false
    change_column :images, :image, :string, null: false
  end

  def down
    change_column :conference_editions, :is_registration_open, :boolean, default: true
    change_column :images, :conference_edition_id, :integer, null: true
    change_column :images, :image, :string, null: true
  end
end
