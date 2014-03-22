class AddIsTalkVotingOpenToEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :is_talk_voting_open, :boolean, default: false
  end
end
