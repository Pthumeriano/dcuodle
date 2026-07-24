module Admin
  # A autorização do painel inteiro mora aqui — nenhum controller de Admin:: repete isso.
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action { authorize! :access, :admin_panel }
  end
end
