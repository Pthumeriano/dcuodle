class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank? # visitante joga, mas não acessa nada logado

    if user.admin?
      can :manage, :all
      can :access, :admin_panel
    else
      can :read, GameResult, user_id: user.id
      can :create, GameResult
      can :read, CharacterRequest, user_id: user.id
      can :create, CharacterRequest
    end
  end
end
