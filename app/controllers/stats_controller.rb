class StatsController < ApplicationController
  before_action :authenticate_user!

  def show
    @stats = current_user.game_results.stats
    @streak = current_user.game_results.current_streak
    @results = current_user.game_results.order(played_on: :desc).limit(30)
  end
end
