require "application_system_test_case"

# Único check da lógica do jogo, que vive toda no front (game_controller.js).
class ClassicGameTest < ApplicationSystemTestCase
  test "chute errado colore os atributos, chute certo vence" do
    answer = Characters.all.find { |c| c["id"] == Characters.daily }
    other = Characters.all.find { |c| c["id"] != answer["id"] }

    visit root_path

    fill_in placeholder: "Digite um personagem", with: other["name"]
    click_on "Chutar"
    assert_selector "tr", text: other["name"]
    assert_selector "td.hit, td.partial, td.miss"

    fill_in placeholder: "Digite um personagem", with: answer["name"]
    click_on "Chutar"
    assert_text "Acertou em 2 tentativa(s): #{answer["name"]}"
  end

  test "as dicas destravam em 3, 5 e 7 tentativas" do
    visit root_path
    assert_text "Habitação — em 3 tentativa(s)"

    Characters.all.first(3).each do |c|
      fill_in placeholder: "Digite um personagem", with: c["name"]
      click_on "Chutar"
    end

    assert_text "Habitação:"
    assert_text "Frase — em 2 tentativa(s)"
  end
end
