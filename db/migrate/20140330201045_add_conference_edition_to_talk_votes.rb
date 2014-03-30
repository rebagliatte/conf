class AddConferenceEditionToTalkVotes < ActiveRecord::Migration
  def change
    add_column :talk_votes, :conference_edition_id, :integer
  end
end
