class AddCustomSlotKind < ActiveRecord::Migration
  def change
    add_column :slots, :label, :string, null: false, default: ''
  end
end
