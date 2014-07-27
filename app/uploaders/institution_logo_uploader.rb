# encoding: utf-8

class InstitutionLogoUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  version :profile do
     process :resize_to_fit => ['', 50]
  end

  version :diagnostic do
     process :resize_to_fit => ['', 35]
  end

  version :mini do
     process :resize_to_fit => ['', 8]
  end
  
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
