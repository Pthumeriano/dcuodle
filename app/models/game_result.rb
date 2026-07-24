class GameResult < ApplicationRecord
  belongs_to :user

  validates :character_id, inclusion: { in: ->(_) { Characters.ids } }
  validates :attempts, numericality: { greater_than: 0 }
  validates :played_on, uniqueness: { scope: [ :user_id, :mode ] }

  scope :won, -> { where(won: true) }

  # Agregação em SQL: o painel nunca carrega a tabela inteira em memória.
  def self.stats
    total = count
    victories = won.count
    {
      played: total,
      won: victories,
      win_rate: total.zero? ? 0.0 : (victories * 100.0 / total).round(1),
      average_attempts: won.average(:attempts)&.round(1),
      distribution: won.group(:attempts).order(:attempts).count
    }
  end

  # Dias consecutivos vencidos até a última partida vencida.
  def self.current_streak
    days = won.order(played_on: :desc).pluck(:played_on)
    days.each_with_index.take_while { |day, i| day == days.first - i }.size
  end
end
