# encoding: utf-8

class InlineImageUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    "uploads/inline_image/#{DateTime.now.to_i}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
