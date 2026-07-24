class ResultsController < ApplicationController
  before_action :authenticate_user!

  # A partida é reportada pelo front — é assim que o jogo foi desenhado. O que o backend
  # garante é que só existe um resultado por dia: sem regravar para melhorar a estatística.
  def create
    result = current_user.game_results.new(
      mode: "classic",
      played_on: Date.current,
      character_id: Characters.daily,
      attempts: params[:attempts],
      won: params[:won]
    )
    authorize! :create, result

    head result.save ? :created : :conflict
  end
end
