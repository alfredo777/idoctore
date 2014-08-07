# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  
  version :gigant do
     process :resize_to_fill => [150, 150]
  end

  version :modern do
     process :resize_to_fill => [45, 45]
  end
  if Rails.env == 'development'
    storage :file
   else
    storage :fog
  end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
      %w(jpg jpeg gif ico png)
  end


end
