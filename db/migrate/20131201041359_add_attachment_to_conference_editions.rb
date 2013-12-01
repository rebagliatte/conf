class AddAttachmentToConferenceEditions < ActiveRecord::Migration
  def change
    add_column :conference_editions, :sponsorship_packages_pdf, :string, default: ''
  end
end
