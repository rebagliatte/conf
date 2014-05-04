class AddSentAtToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :sent_at, :datetime
  end
end
