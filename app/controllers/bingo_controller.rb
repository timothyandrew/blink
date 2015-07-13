class BingoController < ApplicationController
  def generate
    images = BingoService.new.generate
    send_data ZipService.new(images).zip, filename: "bingo #{DateTime.now.strftime('%d %b %Y')}.zip", type: "application/zip"
  end
end
