class AddRankingToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :ranking, :integer
  end
end
