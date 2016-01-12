class BingoController < ApplicationController
  def new
    @words = []
  end

  def create
    service = BingoService.new(bingo_params)
    if service.valid?
      send_data ZipService.new(service.generate).zip, filename: "bingo #{DateTime.now.strftime('%d %b %Y')}.zip", type: "application/zip"
    else
      @words = service.words.map { |word| {word: word} }
      flash[:alert] =  "Not enough words!"
      render :new
    end
  end

  private

  def bingo_params
    if params[:bingo].present?
      params[:bingo][:words].map { |_, attrs| attrs[:word] }
    end
  end
end
