class CharacterRequestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @character_requests = @character_requests.order(created_at: :desc)
  end

  def new
  end

  def create
    @character_request.user = current_user

    if @character_request.save
      redirect_to character_requests_path, notice: "Pedido enviado. Um admin vai revisar."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def character_request_params
      params.expect(character_request: [ :name, :notes ])
    end
end
