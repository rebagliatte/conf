class AddCfpDeadlineToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :cfp_deadline, :date
  end
end
