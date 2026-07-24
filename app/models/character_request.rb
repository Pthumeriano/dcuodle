class CharacterRequest < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, approved: 1, rejected: 2 }, default: :pending

  validates :name, presence: true
  validate :not_already_in_catalog

  private
    def not_already_in_catalog
      return if name.blank?
      errors.add(:name, "já está no jogo") if Characters.all.any? { |c| c["name"].casecmp?(name) }
    end
end
