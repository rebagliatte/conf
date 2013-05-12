class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :name, null:false, default: ''
      t.text :bio, default: ''
      t.string :company, default: ''
      t.string :avatar, default: ''
      t.string :city, default: ''
      t.string :country, default: ''
      t.string :twitter_username, default: ''
      t.string :github_username, default: ''
      t.string :email, default: ''
      t.integer :user_id

      t.timestamps
    end
  end
end
