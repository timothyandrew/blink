require 'zip'

class ZipService
  def initialize(blobs)
    @blobs = blobs
  end

  def zip
    Zip::OutputStream.write_buffer(::StringIO.new('')) do |out|
      @blobs.each_with_index do |blob, i|
        out.put_next_entry("#{i + 1}.png")
        out.write blob
      end
    end.string
  end
end
