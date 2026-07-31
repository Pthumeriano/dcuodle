require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  # O front usa `image` direto no src: tem que sair como URL com digest, não como
  # nome de arquivo cru.
  test "catálogo serve image como url de asset" do
    get "/characters.json"
    assert_match %r{\A/assets/characters/.+\.webp\z}, JSON.parse(response.body).first["image"]
  end
end
