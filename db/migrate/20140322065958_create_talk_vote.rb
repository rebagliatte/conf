class CreateTalkVote < ActiveRecord::Migration
  def change
    create_table :talk_votes do |t|
      t.integer :talk_id, null: false
      t.integer :organizer_id, null: false
      t.integer :vote, null: false
      t.string :comment, null: false, default: ''

      t.timestamps
    end

    add_index :talk_votes, :talk_id
    add_index :talk_votes, :organizer_id
    add_index :talk_votes, [:talk_id, :organizer_id], unique: true
  end
end
