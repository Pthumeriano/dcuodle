require "test_helper"

class GameTest < ActionDispatch::IntegrationTest
  test "a página do jogo renderiza" do
    get root_path
    assert_response :success
    assert_select "[data-controller=game]"
  end

  test "o catálogo é servido inteiro" do
    get characters_path(format: :json)
    assert_response :success
    assert_equal Characters.ids.size, response.parsed_body.size
  end

  test "o endpoint do dia devolve só a data e o id" do
    get api_daily_path(format: :json)
    assert_response :success
    assert_equal %w[character_id date], response.parsed_body.keys.sort
    assert_includes Characters.ids, response.parsed_body["character_id"]
  end
end
