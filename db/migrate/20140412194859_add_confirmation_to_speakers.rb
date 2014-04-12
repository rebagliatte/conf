class AddConfirmationToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :confirmation_status, :string, null: false, default: 'unconfirmed'
  end
end
