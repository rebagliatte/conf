# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include MiniMagick support:
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Include MimeTypes module, to set the content type of the image in case it's incorrect
  include CarrierWave::MimeTypes
  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    asset_path("fallback/" + [version_name, "default.jpg"].compact.join('_'))
  end

  # Create different versions of your uploaded files:

  # Make them 60px tall, keeping ratio
  version :inline_x_60 do
    process resize_to_fit: [nil, 60]
  end

  # Make them 30px tall, keeping ratio
  version :inline_x_30 do
    process resize_to_fit: [nil, 30]
  end

  # Make them 230px wide, keeping ratio
  version :inline_y_230 do
    process resize_to_fit: [230, nil]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
