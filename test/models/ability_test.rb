require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  test "visitante joga, mas não acessa nada logado" do
    ability = Ability.new(nil)

    assert ability.cannot?(:create, GameResult.new)
    assert ability.cannot?(:create, CharacterRequest.new)
    assert ability.cannot?(:access, :admin_panel)
  end

  test "membro só enxerga o que é dele" do
    ability = Ability.new(users(:member))

    assert ability.can?(:create, GameResult.new)
    assert ability.can?(:read, game_results(:member_win))
    assert ability.cannot?(:read, game_results(:admin_win))
    assert ability.cannot?(:read, character_requests(:kite_man).dup.tap { |r| r.user = users(:admin) })
    assert ability.cannot?(:access, :admin_panel)
    assert ability.cannot?(:manage, User.new)
    assert ability.cannot?(:update, character_requests(:kite_man)), "membro não muda status do próprio pedido"
  end

  test "admin pode tudo" do
    ability = Ability.new(users(:admin))

    assert ability.can?(:access, :admin_panel)
    assert ability.can?(:manage, User.new)
    assert ability.can?(:update, character_requests(:kite_man))
  end
end
