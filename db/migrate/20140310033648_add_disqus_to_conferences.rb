class AddDisqusToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :disqus_shortname, :string, default: '', null: false
  end
end
