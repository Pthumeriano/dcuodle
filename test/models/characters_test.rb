require "test_helper"

# Este teste é a validação do catálogo: ele roda no CI via `bin/rails test`, então
# contribuidor não precisa de rake task nenhuma para checar o JSON que escreveu.
class CharactersTest < ActiveSupport::TestCase
  LIST_ATTRS = %w[groups occupations powers antagonists]

  test "todo personagem segue o contrato" do
    Characters.all.each do |c|
      file = "data/characters/#{c["id"]}.json"
      assert File.exist?(Rails.root.join(file)), "id #{c["id"]} não bate com o nome do arquivo"
      assert_match(/\A[a-z0-9-]+\z/, c["id"], "#{file}: id tem que ser kebab-case")
      assert c["name"].present?, "#{file}: name obrigatório"
      assert_kind_of Array, c["aliases"], "#{file}: aliases obrigatório"
      assert_equal 3, c["hints"]["palette"].size, "#{file}: paleta tem 3 cores"
      c["hints"]["palette"].each { |color| assert_match(/\A#[0-9a-f]{6}\z/, color, "#{file}: cor #{color}") }
      assert c["hints"]["habitation"].present? && c["hints"]["description"].present?, "#{file}: dicas obrigatórias"
    end
  end

  test "todo atributo usa valores do vocabulário" do
    Characters.all.each do |c|
      c["attributes"].each do |attr, value|
        allowed = Characters.vocabularies.fetch(attr)
        assert_kind_of Array, value, "#{c["id"]}: #{attr} tem que ser lista" if LIST_ATTRS.include?(attr)
        Array(value).each do |v|
          assert_includes allowed, v, "#{c["id"]}: #{attr} = #{v} não está em vocabularies.json"
        end
      end
      assert_equal Characters.vocabularies.keys.sort, c["attributes"].keys.sort, "#{c["id"]}: atributos faltando ou sobrando"
    end
  end

  test "personagem do dia é estável e não repete antes do baralho acabar" do
    assert_equal Characters.daily(Date.new(2026, 7, 22)), Characters.daily(Date.new(2026, 7, 22))

    deck = (0...Characters.ids.size).map { |i| Characters.daily(Characters::EPOCH + i) }
    assert_equal Characters.ids.sort, deck.sort, "o baralho tem que cobrir o catálogo sem repetir"
  end
end
