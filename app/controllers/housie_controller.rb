class HousieController < ApplicationController
  def new
    @service = Housie::Service.new({})
  end

  def create
    @service = Housie::Service.new(housie_params)
    if @service.valid?
      send_data @service.generate, filename: "Housie - #{DateTime.now.strftime('%d %b %Y')}.pdf", type: :pdf
    else
      flash[:error] = @service.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def housie_params
    params.require(:housie).permit(:player_count, columns: [:lower, :higher])
  end
end
