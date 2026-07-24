module Admin
  class DashboardController < BaseController
    def show
      @stats = GameResult.stats
      @users_count = User.count
      @pending_requests = CharacterRequest.pending.count
      @by_day = GameResult.group(:played_on).order(played_on: :desc).limit(14).count
      @played_by_character = GameResult.group(:character_id).count
      @won_by_character = GameResult.won.group(:character_id).count
    end
  end
end
