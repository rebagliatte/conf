class RemoveNotificationLimit < ActiveRecord::Migration
  def change
    change_column(:notifications, :recipient_emails, :text, limit: nil)
  end
end
