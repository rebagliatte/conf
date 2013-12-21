# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Include MimeTypes module, to set the content type of the file in case it's incorrect
  include CarrierWave::MimeTypes
  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    model_class = model.class.to_s.underscore

    store_dir = if model_class == 'conference_edition'
      "conference_editions/#{model.id}/#{mounted_as}"
    elsif model.conference_edition_id
      "conference_editions/#{model.conference_edition_id}/#{model_class.pluralize}/#{model.id}/#{mounted_as}"
    else
      "#{model_class.pluralize}/#{model.id}/#{mounted_as}"
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    ['pdf']
  end

end
