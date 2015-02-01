class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :conference_edition_id, null: false
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.float :price, null: false
      t.integer :quantity
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
