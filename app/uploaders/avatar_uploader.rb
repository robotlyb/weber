# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  storage :file
  include CarrierWave::RMagick

	process :resize_to_fit => [310,175]

  def default_url
    Settings.image.default_avatar
	end
	def store_dir
		"uploads/avatar/"
	end
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

end
