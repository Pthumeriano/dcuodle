module Admin
  class UsersController < BaseController
    def index
      # Contagem no SQL: sem N+1 e sem carregar game_results.
      @users = User
        .left_joins(:game_results)
        .group(:id)
        .select("users.*, COUNT(game_results.id) AS played_count")
        .order(:email)
    end

    def show
      @user = User.find(params[:id])
      @stats = @user.game_results.stats
      @streak = @user.game_results.current_streak
      @results = @user.game_results.order(played_on: :desc).limit(30)
    end
  end
end
