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
   O WebFetch direto no Fandom retorna **402** — não insista. Use o helper
   local `./wiki.sh` (gitignorado; ele fala com a API do MediaWiki, que devolve
   conteúdo limpo sem o ruído de itens/coleções do WebSearch):

   ```sh
   ./wiki.sh links "Episode_22:_Phantom_Zone_%26_Science_Spire"  # acha as instâncias
   ./wiki.sh cast  "The_Phantom_Zone"                            # seção ===Characters===
   ./wiki.sh text  "The_Science_Spire"                           # wikitext cru (fallback)
   ```

   Um episódio tem 1-2 instâncias (duo/raid). **Ache as instâncias na seção
   `==Content==` da página do episódio** (`./wiki.sh text` e olhe o Content) —
   NÃO confie no dump de `links`, que mistura conteúdo de outros episódios (já
   apontou pro Patchwork Themyscira do Wonderverse dentro do Amazon Fury III).
   Puxe o `cast` de cada instância. Se vier vazio (a página usa tabela em vez de
   lista, ou é um redirect `#REDIRECT [[...]]`), siga o redirect / caia pro
   `text` e garimpe os `[[Links]]`. Se o helper sumir, recrie: curl na API +
   parse do `===Characters===`.

3. **Cruzar com o catálogo.** `ls data/characters/`. Personagem que já existe
   **não** entra de novo (regra "uma vez, creditado no primeiro episódio").
   Pule também: trash mobs genéricos e NPCs originais do DCUO sem cânon DC
   (ex.: "Mercenary Captain Eckhart"). Escopo = nomeados (heróis, vilões,
   chefes, NPCs de história).

   **Variantes entram** (Bombshell, JSA, Flashpoint, Future…) como personagens
   próprios: nome `Base (Variante)`, id `base-variante`, um grupo por família no
   vocabulário (`bombshell`, `jsa`…), atributos ajustados por lore (morality,
   occupations, habitation, paleta) pra não clonar a base. Variante creditada no
   primeiro episódio em que aparece.

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
   - `description` = descrição curta do personagem (use `"-"` como placeholder).

5. **Validar:** `bin/rails test test/models/characters_test.rb`. Tem que passar
   0 failures antes de marcar feito.

6. **Marcar no PERSONAGENS.md** (três lugares, sempre):
   - Troque `[ ]` por `[x]` na linha do episódio (seção "## Episódios"),
     listando os ids adicionados e, entre `*(...)*`, quem já estava no catálogo
     / o que foi pulado e por quê / vocabulário tocado.
   - **Registre cada id novo na seção "## Revisão de atributos"** como `- [ ]`,
     num subtítulo `### Ep. N — Nome` (crie se não existir, na ordem). Isso não
     é opcional: **todo personagem adicionado entra na revisão**, senão a revisão
     um-a-um esquece dele. Personagem fora de episódio (ex.: chefe de alerta do
     Base Game) vai no subtítulo `### Adendos`.
   - Atualize a contagem em "## Já no catálogo (N)".

   Siga o formato das linhas/blocos já existentes.

## Nota

Episódio pode render **0 novos** (todo o elenco já está no catálogo) — isso é um
resultado válido; marque `[x]` com a justificativa, como nos eps 4/16/17/19.
