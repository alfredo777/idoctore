# encoding: utf-8

class LeftLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :diagnostic do
     process :resize_to_fit => ['', 105]
  end
  if Rails.env == 'development'
    storage :file
   else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


end
