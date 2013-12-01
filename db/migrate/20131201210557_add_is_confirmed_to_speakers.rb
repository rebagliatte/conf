class AddIsConfirmedToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :is_confirmed, :boolean, default: false
  end
end
