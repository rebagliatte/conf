# encoding: utf-8

class StylesheetUploader < CarrierWave::Uploader::Base

  # Include the Sprockets helpers for Rails asset pipeline compatibility:
  include Sprockets::Rails::Helper

  # Include MimeTypes module, to set the content type of the file in case it's incorrect
  include CarrierWave::MimeTypes
  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "conference_editions/#{model.id}/#{mounted_as}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    ['css']
  end

end
