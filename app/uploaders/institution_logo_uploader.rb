# encoding: utf-8

class InstitutionLogoUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file

  version :profile do
     process :resize_to_fill => ['', 50]
  end

  version :diagnostic do
     process :resize_to_fill => ['', 35]
  end

  version :mini do
     process :resize_to_fill => ['', 8]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
