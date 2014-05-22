# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    rand = (0...150).map { o[rand(o.length)] }.join
     "#{rand}.png" if original_filename
  end

end
