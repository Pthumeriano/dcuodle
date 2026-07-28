---
name: revisar-personagem
description: >
  Revisa um personagem já no catálogo do DCUOdle contra o cânon DC/DCUO,
  atributo por atributo, e preenche a description (que hoje está "-"). É o
  segundo passo do fluxo do PERSONAGENS.md ("Revisão de atributos"), depois do
  bulk-add feito pela skill arrochar-personagens. Use quando o usuário disser
  "revisar personagem", "revisa o <id>", "confere o <id>" ou pedir para
  processar a checklist de revisão.
argument-hint: "[id do personagem | próximo]"
license: MIT
---

# Revisar Personagem

Confere **um personagem** do catálogo contra o cânon DC/DCUO e ajusta o JSON. É
o passo 2 do fluxo: a skill [arrochar-personagens](../arrochar-personagens/SKILL.md)
adiciona em massa; esta revisa um a um. A checklist mestre é a seção
**"Revisão de atributos"** do [PERSONAGENS.md](../../../PERSONAGENS.md).

## Passos

1. **Achar o alvo.** Se o usuário deu um id, use-o. Senão, o próximo `[ ]` na
   seção "Revisão de atributos" do PERSONAGENS.md (na ordem). Leia o JSON em
   `data/characters/<id>.json`. **Todo personagem é alvo** — inclusive os 16
   originais curados.

2. **Pesquisar o cânon** com `./wiki.sh` (mesmo helper do arrochar; a API do
   MediaWiki, não o WebFetch que dá 402):

   ```sh
   ./wiki.sh text "Nome_Do_Personagem"   # infobox: race, power, faction, location, affiliation
   ```

   Foque no **DCUO**: a wiki traz o power set do jogo (Nature, Fire, Ice, Hard
   Light, Quantum, Rage, Celestial, Atomic…), a facção (hero/antihero/villain) e
   a localização. Sem página? Use o cânon DC geral e marque a incerteza.

3. **Conferir campo a campo** (corrigir no JSON quando divergir):
   - `race` · `gender` · `morality` — batem com o cânon?
   - `groups` — reflete a afiliação real (Liga, Titãs, Lanternas, uma família de
     variante…)? Todo valor tem que existir em
     [data/vocabularies.json](../../../data/vocabularies.json).
   - `occupations` — o papel no DCUO/DC.
   - `powers` — é o **power set do DCUO**? Esse é o campo que mais escapa no
     bulk. Ajuste pro conjunto certo; valor novo entra no vocabulário (kebab,
     singular).
   - `antagonists` — coerentes e apontando pra **ids que existem** no catálogo
     (ou nomes no vocabulário de antagonists). Prefira rivalidades recíprocas
     reais (ex.: captain-atom↔major-force, static↔ebon).
   - `hints.habitation` — cidade/local reconhecível.
   - `hints.description` — **hoje está "-"** em quase todos; escreva uma descrição
     curta em PT que sirva de dica (a dica liberada com 5 tentativas), sem
     entregar o nome nem os aliases.
   - `hints.palette` — 3 cores hex minúsculas coerentes com o visual.

4. **Validar:** `bin/rails test test/models/characters_test.rb` (0 failures).

5. **Marcar `[x]`** na linha do personagem na seção "Revisão de atributos" do
   PERSONAGENS.md. Se algum vocabulário foi tocado, anote no fim da linha.

## Notas

- Mudou vocabulário? A validação é o teste — não crie rake task (CLAUDE.md §5).
- Vários personagens por vez: repita o ciclo, um commit no fim ou por lote,
  como o usuário preferir.
