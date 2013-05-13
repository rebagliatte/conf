class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :subdomain, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :twitter_username, default: ''
      t.string :twitter_hashtag, default: ''
      t.string :facebook_page_username, default: ''

      t.timestamps
    end
  end
end
