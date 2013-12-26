class AddCustomCssToConferenceEdition < ActiveRecord::Migration
  def change
    add_column :conference_editions, :custom_css_file, :string, default: ''
  end
end
