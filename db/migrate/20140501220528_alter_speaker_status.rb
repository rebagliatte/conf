class AlterSpeakerStatus < ActiveRecord::Migration
  def up
    add_column :speakers, :is_promoted, :boolean, default: false
    Speaker.where(confirmation_status: 'confirmed').update_all(is_promoted: true)
    remove_column :speakers, :confirmation_status
    change_column :speakers, :status, :string, default: 'pending', null: false
  end

  def down
    remove_column :speakers, :is_promoted
    change_column :speakers, :status, :string, null: false, default: ''
    add_column :speakers, :confirmation_status, :string, null: false, default: 'unconfirmed'
    change_column :speakers, :status, :string, default: '', null: false
  end
end
