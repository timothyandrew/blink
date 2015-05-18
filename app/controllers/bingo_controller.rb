class BingoController < ApplicationController
  def generate
    send_data BingoService.new.generate, filename: "bingo #{DateTime.now.strftime('%d %b %Y')}.png", type: "image/png"
  end
end
