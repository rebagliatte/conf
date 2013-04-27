class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :name, null:false, default: ''
      t.string :description, default: ''
      t.string :twitter_username, default: ''
      t.string :github_username, default: ''
      t.string :email, default: ''
      t.integer :talk_id

      t.timestamps
    end
  end
end
