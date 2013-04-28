class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null:false, default: ''
      t.string :nickname, default: ''
      t.string :email, default: ''
      t.string :image, default: ''
      t.string :role, default: 'user'

      t.timestamps
    end
  end
end
