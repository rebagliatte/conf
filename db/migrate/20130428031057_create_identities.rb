class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider, null:false, default: ''
      t.string :uid, null:false, default: ''
      t.integer :user_id

      t.timestamps
    end

    add_index :identities, :user_id
  end
end
