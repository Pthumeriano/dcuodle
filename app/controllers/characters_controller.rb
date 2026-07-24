class CharactersController < ApplicationController
  def index
    fresh_when etag: Characters.all, public: true
    render json: Characters.all
  end

  # Só o id do dia. A comparação é toda no front.
  def daily
    render json: { date: Date.current, character_id: Characters.daily }
  end
end
