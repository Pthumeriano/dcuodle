class User < ApplicationRecord
  # Sem :recoverable — não há ActionMailer configurado, então "esqueci a senha" seria um
  # botão quebrado. Ligue junto com o mailer, não antes.
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  enum :role, { member: 0, admin: 1 }, default: :member

  has_many :game_results, dependent: :destroy
  has_many :character_requests, dependent: :destroy
end
