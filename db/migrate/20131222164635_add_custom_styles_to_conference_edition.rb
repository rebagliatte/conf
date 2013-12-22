class AddCustomStylesToConferenceEdition < ActiveRecord::Migration
  def change
    remove_columns :conference_editions, :promo_image
  end
end
