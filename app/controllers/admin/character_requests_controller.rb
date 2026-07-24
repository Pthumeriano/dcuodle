module Admin
  class CharacterRequestsController < BaseController
    # Única escrita do painel: mudar o status. Aprovar é o sinal para alguém abrir o PR
    # com o arquivo em data/characters — o app não escreve lá.
    def index
      @character_requests = CharacterRequest.includes(:user).order(status: :asc, created_at: :desc)
    end

    def update
      request = CharacterRequest.find(params[:id])
      request.update!(status: params.expect(character_request: [ :status ])[:status])
      redirect_to admin_character_requests_path, notice: "Pedido marcado como #{request.status}."
    end
  end
end
