class HousieController < ApplicationController
  def new
  end

  def create
    service = Housie::Service.new(housie_params)
    send_data service.generate, filename: "Housie - #{DateTime.now.strftime('%d %b %Y')}.pdf", type: :pdf
  end

  private

  def housie_params
    params.require(:housie).permit(:player_count)
  end
end
