class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :conference_edition_id, null: false
      t.string :code, null: false, default: ''
      t.integer :discount, null: false
      t.date :start_date
      t.date :end_date
      t.integer :quantity

      t.timestamps
    end
  end
end
