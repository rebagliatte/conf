class AddColumnsToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :owner_id, :integer
    add_column :conferences, :available_languages, :string, default: 'en'
  end
end
