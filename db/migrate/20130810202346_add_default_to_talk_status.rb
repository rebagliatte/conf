class AddDefaultToTalkStatus < ActiveRecord::Migration
  def up
    change_column :talks, :status, :string, default: 'pending', null: false
  end

  def down
    change_column :talks, :status, :string, default: ''
  end
end
