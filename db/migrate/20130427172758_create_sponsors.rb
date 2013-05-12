class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name, null:false, default: ''
      t.string :description, default: ''
      t.string :kind, default: ''
      t.string :logo, default: ''
      t.integer :conference_edition_id

      t.timestamps
    end
  end
end
