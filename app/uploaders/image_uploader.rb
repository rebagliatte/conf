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
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    model_class = model_class(model)

    if is_model_class?(model, 'conference_edition')
      "conference_editions/#{model.id}/#{mounted_as}"
    elsif model.has_attribute?(:conference_edition_id)
      "conference_editions/#{model.conference_edition_id}/#{model_class.pluralize}/#{model.id}/#{mounted_as}"
    else
      "#{model_class.pluralize}/#{model.id}/#{mounted_as}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    asset_path("fallback/" + [version_name, "default.jpg"].compact.join('_'))
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Conditional Versions

  # Make them 30px tall, keeping ratio
  version :inline_x_30, if: :is_conference_edition? do
    process resize_to_fit: [nil, 30]
  end

  # Make them 60px tall, keeping ratio
  version :inline_x_60, if: :is_sponsor? do
    process resize_to_fit: [nil, 60]
  end

  # Make them 230px wide, keeping ratio
  version :inline_y_230, if: :is_thumbnable? do
    process resize_to_fit: [230, nil]
  end

  # Make them 230px x 230px, keeping ratio
  version :square_230_230, if: :is_speaker? do
    process resize_to_fill: [230, 230]
  end

  protected

  def is_conference_edition?(picture)
    is_model_class?(model, 'conference_edition')
  end

  def is_sponsor?(picture)
    is_model_class?(model, 'sponsor')
  end

  def is_speaker?(picture)
    is_model_class?(model, 'speaker')
  end

  def is_thumbnable?(picture)
    is_model_class?(model, 'speaker') || is_model_class?(model, 'sponsor') || is_model_class?(model, 'user')
  end

  def model_class(model)
    model.class.to_s.underscore
  end

  def is_model_class?(model, class_name)
    model_class(model) == class_name
  end

end
