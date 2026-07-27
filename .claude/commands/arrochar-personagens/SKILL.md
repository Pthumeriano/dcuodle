---
name: arrochar-personagens
description: >
  Adiciona ao catálogo do DCUOdle os personagens de um episódio do DC Universe
  Online, seguindo o checklist em PERSONAGENS.md. Pesquisa o elenco na DCUO
  Wiki, cria um JSON por personagem novo em data/characters/ conforme o contrato
  do CLAUDE.md §5, valida com bin/rails test e marca o episódio como feito.
  Use quando o usuário disser "arrochar personagens", "arrocha o ep N",
  "continuar os personagens" ou pedir para processar um episódio do DCUO.
argument-hint: "[ep N | nome do episódio]"
license: MIT
---

# Arrochar Personagens

Fluxo de adicionar os personagens de **um episódio do DCUO** ao catálogo. O
arquivo [PERSONAGENS.md](../../../PERSONAGENS.md) é o checklist mestre e a fonte
da verdade do progresso — leia ele primeiro, sempre.

## Passos

1. **Achar o alvo.** Se o usuário nomeou o episódio, use-o. Senão, o próximo
   `[ ]` na lista de "## Episódios" do PERSONAGENS.md.

2. **Pesquisar o elenco** na [DCUO Wiki](https://dcuniverseonline.fandom.com).
   O WebFetch direto no Fandom retorna **402** — não insista. Use a API do
   MediaWiki, que devolve o roster limpo (a seção `===Characters===`), sem o
   ruído de itens/coleções que o WebSearch e o dump de links trazem:

   ```sh
   curl -sL -A "Mozilla/5.0" \
     "https://dcuniverseonline.fandom.com/api.php?action=parse&page=PAGINA&format=json&prop=wikitext" \
     | python3 -c "import sys,json;print(json.load(sys.stdin)['parse']['wikitext']['*'])"
   ```

   Um episódio tem 1-2 instâncias (duo/raid). Descubra os nomes das páginas de
   instância com `prop=links` na página do episódio, depois puxe o
   `===Characters===` de cada instância.

3. **Cruzar com o catálogo.** `ls data/characters/`. Personagem que já existe
   **não** entra de novo (regra "uma vez, creditado no primeiro episódio").
   Pule também: trash mobs genéricos e NPCs originais do DCUO sem cânon DC
   (ex.: "Mercenary Captain Eckhart"). Escopo = nomeados (heróis, vilões,
   chefes, NPCs de história).

4. **Criar um JSON por personagem novo** em `data/characters/<id>.json`,
   seguindo o contrato do [CLAUDE.md](../../../CLAUDE.md) §5. Pontos que o teste
   cobra e é fácil escorregar:
   - Os **7 atributos** são obrigatórios e exatos: `race gender morality groups
     occupations powers antagonists`. Nada a mais, nada a menos.
   - **Todo valor** de atributo tem que existir em
     [data/vocabularies.json](../../../data/vocabularies.json). Valor novo?
     Adicione no mesmo passo, em **kebab-case singular**. Isso vale inclusive
     para `antagonists` (ids soltos entram no vocabulário).
   - `powers` = o **power set do DCUO** quando mapeia (Nature, Fire, Ice, Hard
     Light, Quantum, Rage…); senão o mais próximo do vocabulário.
   - `palette` = exatamente 3 cores hex **minúsculas** de 6 dígitos.
   - `id` = nome do arquivo, kebab-case. Mantenha o artigo em nomes "The X"
     (the-flash, the-atom, the-huntress).
   - `image` = `"<id>.webp"` — o asset **não** precisa existir (o teste não
     checa; a pasta está vazia). Só referencie.
   - `quote` = fala real do personagem no DCUO/cânon quando houver.

5. **Validar:** `bin/rails test test/models/characters_test.rb`. Tem que passar
   0 failures antes de marcar feito.

6. **Marcar no PERSONAGENS.md:** troque `[ ]` por `[x]` na linha do episódio,
   listando os ids adicionados e, entre `*(...)*`, quem já estava no catálogo /
   o que foi pulado e por quê / vocabulário tocado. Atualize a contagem em
   "## Já no catálogo (N)". Siga o formato das linhas dos episódios já feitos.

## Nota

Episódio pode render **0 novos** (todo o elenco já está no catálogo) — isso é um
resultado válido; marque `[x]` com a justificativa, como nos eps 4/16/17/19.
