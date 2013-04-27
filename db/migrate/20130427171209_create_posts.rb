class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ''
      t.string :body, default: ''
      t.string :summary, default: ''
      t.integer :conference_edition_id

      t.timestamps
    end
  end
end
