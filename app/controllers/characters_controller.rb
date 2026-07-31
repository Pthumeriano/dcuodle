class CharactersController < ApplicationController
  def index
    fresh_when etag: Characters.all, public: true
    # `image` sai como URL pronta: só o Propshaft sabe o digest do arquivo.
    render json: Characters.all.map { |c| c.merge("image" => helpers.image_path("characters/#{c["image"]}")) }
  end

  # Só o id do dia. A comparação é toda no front.
  def daily
    render json: { date: Date.current, character_id: Characters.daily }
  end
end
