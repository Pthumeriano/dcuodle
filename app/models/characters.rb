# Catálogo lido de data/characters/*.json. Personagem não é registro de banco: é dado
# versionado, para a comunidade expandir por PR.
module Characters
  DATA = Rails.root.join("data")

  # Baralho embaralhado com seed fixo: nenhum personagem se repete antes de o catálogo
  # esgotar. Mudar EPOCH ou SEED reembaralha o calendário inteiro.
  EPOCH = Date.new(2026, 1, 1)
  SEED = 20260722

  class << self
    def all
      return @all if @all && !Rails.env.development?
      @all = Dir[DATA.join("characters", "*.json")].sort.map { |f| JSON.parse(File.read(f)) }
    end

    def ids
      all.map { |c| c["id"] }
    end

    def vocabularies
      return @vocabularies if @vocabularies && !Rails.env.development?
      @vocabularies = JSON.parse(File.read(DATA.join("vocabularies.json")))
    end

    def daily(date = Date.current)
      deck = ids.shuffle(random: Random.new(SEED))
      deck[(date - EPOCH).to_i % deck.size]
    end
  end
end
