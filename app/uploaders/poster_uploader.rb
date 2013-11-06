# encoding: utf-8

class PosterUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
    # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick

  process :resize_to_fit => [310, 175]

   # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    Settings.image.default_poster
  end
  def store_dir
    "uploads/poster/"
  end


end
