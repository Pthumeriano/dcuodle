require "test_helper"

class AdminTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "visitante é mandado para o login" do
    get admin_root_path
    assert_redirected_to new_user_session_path
  end

  test "membro logado bate na porta e volta" do
    sign_in users(:member)

    get admin_root_path
    assert_redirected_to root_path

    get admin_users_path
    assert_redirected_to root_path
  end

  test "admin abre o painel inteiro" do
    sign_in users(:admin)

    get admin_root_path
    assert_response :success

    get admin_users_path
    assert_response :success
    assert_select "td", text: users(:member).email

    get admin_user_path(users(:member))
    assert_response :success

    get admin_character_requests_path
    assert_response :success
  end

  test "admin aprova pedido" do
    sign_in users(:admin)
    request = character_requests(:kite_man)

    patch admin_character_request_path(request), params: { character_request: { status: :approved } }

    assert request.reload.approved?
  end
end
