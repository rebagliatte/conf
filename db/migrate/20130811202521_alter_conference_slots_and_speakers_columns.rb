class AlterConferenceSlotsAndSpeakersColumns < ActiveRecord::Migration
  def change
    change_column :conferences, :subdomain, :string, default: '', null: false
    change_column :conferences, :name, :string, default: '', null: false
    change_column :conferences, :email, :string, default: '', null: false
    change_column :conferences, :owner_id, :integer, null: false

    change_column :slots, :from_datetime, :datetime, null: false
    change_column :slots, :to_datetime, :datetime, null: false

    change_column :speakers, :email, :string, default: '', null: false
  end
end
