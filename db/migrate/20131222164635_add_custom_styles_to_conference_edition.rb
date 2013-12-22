class AddCustomStylesToConferenceEdition < ActiveRecord::Migration
  def change
    remove_columns :conference_editions, :promo_image
    add_column :conference_editions, :custom_styles, :text, default: ''
  end
end
