module DownloadHelper
  TIMEOUT = 5
  PATH    = Rails.root.join("tmp/downloads")

  def downloads
    Dir[PATH.join("*")]
  end

  def wait_for_download
    Timeout.timeout(TIMEOUT) do
      sleep 0.1 until !downloading? && downloads.any?
    end
  end

  def downloading?
    downloads.grep(/\.crdownload$/).any?
  end

  def download_content
    wait_for_download
    File.read(downloads.first)
  rescue Timeout::Error
    nil
  end

  def clear_downloads
    FileUtils.rm_f(downloads)
  end
end
