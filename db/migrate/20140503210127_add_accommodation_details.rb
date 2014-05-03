class AddAccommodationDetails < ActiveRecord::Migration
  def change
    add_column :speakers, :arrival_date, :datetime
    add_column :speakers, :accomodation_details, :text, null: false, default: ''
  end
end
