class NumberNameGamesController < ApplicationController
  before_action :load_number_name_game, only: [:show, :destroy, :play]

  def new
    @number_name_game = current_user.number_name_games.new
  end

  def create
    @number_name_game = current_user.number_name_games.new(number_name_game_params)
    if @number_name_game.save
      redirect_to number_name_games_path, notice: "Created your number name game!"
    else
      render :new
    end
  end

  def show
  end

  def play
  end

  def index
    @number_name_games = current_user.number_name_games
  end

  def destroy
    @number_name_game.destroy
    redirect_to number_name_games_path, notice: "Deleted your number name game!"
  end

  private

  def load_number_name_game
    @number_name_game = NumberNameGame.find(params[:id])
  end

  def number_name_game_params
    params.require(:number_name_game).permit(:name).merge({numbers: NumberNameGame.parse_number_string(params[:number_name_game][:numbers])})
  end
end
