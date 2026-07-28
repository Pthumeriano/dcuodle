# CLAUDE.md

Orientações para o Claude Code trabalhar neste repositório.

> **Estado atual:** o projeto é um `rails new` recém-gerado, sem código de domínio. Tudo
> descrito abaixo é a **estrutura alvo** — o contrato que a implementação deve seguir, não
> o que já existe no disco.

## 1. Visão geral

DCUOdle é um jogo no estilo Wordle/Loldle com personagens da **DC Comics**. O modo principal
é o **Classic**: o jogador tem que acertar o personagem do dia.

Rails monolítico fullstack. **A lógica do jogo roda no front-end.** O backend existe para
guardar estatísticas dos jogadores, receber pedidos de novos personagens e servir o painel
administrativo.

## 2. Stack e comandos

Ruby 4.0.4 · Rails 8.1.3 · SQLite · Propshaft · importmap (sem bundler JS) · Hotwire
(Turbo + Stimulus) · Solid Cache/Queue/Cable · Kamal.

```sh
bin/setup                 # instala dependências e prepara o banco
bin/dev                   # servidor de desenvolvimento
bin/rails test            # minitest (unit + integração) — inclui a validação do catálogo
bin/rails test:system     # exige Chrome instalado
node --test 'test/javascript/*.mjs'   # lógica pura do front (runner nativo do Node)
bin/rubocop               # rubocop-rails-omakase
bin/brakeman --no-pager
bin/bundler-audit
bin/importmap audit
bin/ci                    # tudo de uma vez, igual ao .github/workflows/ci.yml
```

Gems adicionadas ao omakase: **devise** (autenticação) e **cancancan** (autorização).
Fora essas, **não adicione gems ou pacotes npm sem necessidade real**:

- nada de esbuild/webpack/node — importmap resolve;
- nada de ActiveAdmin ou Administrate — atritam com Propshaft/importmap e o painel é
  simples o bastante para ser feito à mão;
- nada de rolify — o `role` enum cobre os dois níveis que existem;
- nada de gem de JSON Schema — a validação dos dados é Ruby puro numa rake task.

## 3. Regras do jogo (Classic)

A cada palpite, os atributos do personagem chutado são comparados com os do personagem do
dia:

| Atributo      | Cardinalidade | Feedback                                     |
| ------------- | ------------- | -------------------------------------------- |
| `gender`      | único         | ✅ acerto / ❌ erro                           |
| `race`        | único         | ✅ / ❌                                       |
| `morality`    | único         | ✅ / ❌                                       |
| `groups`      | lista         | ✅ igual / 🟡 interseção não vazia / ❌ nenhuma |
| `occupations` | lista         | ✅ igual / 🟡 interseção não vazia / ❌ nenhuma |
| `powers`      | lista         | ✅ / 🟡 / ❌                                   |
| `antagonists` | lista         | ✅ / 🟡 / ❌                                   |

Dicas liberadas por número de tentativas:

| Tentativas | Dica              |
| ---------- | ----------------- |
| 3          | habitação         |
| 5          | descrição         |
| 7          | paleta de cores   |

## 4. Arquitetura — a fronteira front/back

- O front baixa `GET /characters.json` (catálogo completo) e `GET /api/daily` (só o id do
  personagem do dia), e faz **toda** a comparação localmente.
- O progresso da partida fica em `localStorage`, na chave `dcdle:classic:<YYYY-MM-DD>`, de
  modo que um refresh não perde o jogo.
- Ao terminar a partida, se houver sessão, o front faz `POST /api/results`. **Jogar sem
  conta funciona 100%** — só não persiste estatística.
- O backend **nunca** valida palpites, e `characters.json` **nunca** contém a resposta do
  dia.
- A resposta é descobrível por quem inspecionar a rede. Isso é aceitável para um jogo
  casual: **não gaste esforço em ofuscação.**
- O dia vira à meia-noite em `America/Fortaleza` (`config.time_zone` em
  `config/application.rb`). Front e back usam a mesma data.

## 5. Dados dos personagens — o contrato

O catálogo é feito de **um arquivo JSON por personagem**, para que contribuições da
comunidade não conflitem entre si:

```
data/
  characters/
    batman.json          # nome do arquivo == id do personagem
    zatanna.json
  vocabularies.json      # valores permitidos por atributo (fonte da verdade)
```

### Schema de um personagem

```json
{
  "id": "batman",
  "name": "Batman",
  "aliases": ["Bruce Wayne"],
  "image": "batman.webp",
  "attributes": {
    "gender": "male",
    "morality": "hero",
    "groups": ["justice-league", "batman-family"],
    "occupations": ["vigilante", "ceo"],
    "powers": ["peak-human", "genius-intellect"],
    "antagonists": ["joker", "penguin"]
  },
  "hints": {
    "habitation": "Gotham City",
    "description": "-",
    "palette": ["#1c1c1c", "#3a3f5c", "#f2c94c"]
  }
}
```

Regras:

- `id` em kebab-case, **igual ao nome do arquivo** e **imutável** — é a chave usada nas
  estatísticas. Renomear um id invalida o histórico.
- Todo valor dentro de `attributes` tem que existir em `data/vocabularies.json`. Valor
  novo? Adicione ao vocabulário **no mesmo PR**, em kebab-case e no singular.
- `antagonists` referencia `id`s de outros personagens quando eles existirem no catálogo;
  nomes soltos são permitidos, mas também entram no vocabulário.
- `palette`: exatamente 3 cores hex de 6 dígitos.
- `image`: nome do arquivo em `app/assets/images/characters/`.

### Como adicionar um personagem

1. Copie um JSON existente em `data/characters/` e edite.
2. Rode `bin/rails test`.
3. Abra um PR tocando **um arquivo** (mais `vocabularies.json`, se necessário).

### Como o catálogo chega ao front

Sem build step e sem artefato versionado. `app/models/characters.rb` lê
`Dir.glob("data/characters/*.json")`, ordena por `id`, memoiza em produção e recarrega em
desenvolvimento. O endpoint `GET /characters.json` serve o catálogo com `fresh_when etag:`
— o cache HTTP (Thruster) faz o resto.

**Não crie um `public/characters.json` compilado.** Um artefato gerado é mais uma coisa
para dessincronizar.

### Validação

A validação é um **teste**, não uma rake task: `test/models/characters_test.rb` varre
`data/characters/*.json` e cobra campos obrigatórios, `id` igual ao nome do arquivo,
valores dentro do vocabulário e formato da paleta.

Isso é de propósito. Uma rake task exigiria manter o mesmo check em três lugares (task +
`config/ci.rb` + workflow); o teste já roda em `bin/rails test`, que o CI executa. Ao
adicionar regra nova ao contrato, adicione a asserção lá — **não** crie
`characters:validate`.

## 6. Backend

### Autenticação — Devise

`rails generate devise:install` e `devise User`, com os módulos
`database_authenticatable`, `registerable`, `rememberable`, `validatable`. Gere as views
(`devise:views`) só quando de fato precisar customizá-las.

As rotas do jogo são **públicas**. `authenticate_user!` só em `/stats`,
`/character_requests` e `/admin`.

### Autorização — CanCanCan

`User` tem `enum :role, { member: 0, admin: 1 }`, default `member`.

Toda a política de acesso vive em `app/models/ability.rb` — não espalhe checagens de
`current_user.admin?` pelos controllers e views:

```ruby
if user.admin?
  can :manage, :all
  can :access, :admin_panel
else
  can :read, :all
  can :create, CharacterRequest
  can :read, GameResult, user_id: user.id
end
```

Controllers usam `authorize!` ou `load_and_authorize_resource`. O `ApplicationController`
trata `rescue_from CanCan::AccessDenied` redirecionando com flash.

### Modelos

- **`GameResult`** — `user`, `mode`, `played_on` (date), `character_id` (string, **não**
  FK: personagem não é registro de banco), `attempts`, `won`. Índice único em
  `[user_id, mode, played_on]`: uma partida por modo por dia. Os scopes das métricas
  (`won`, `by_day`, streaks) ficam no modelo, nunca nas views.
- **`CharacterRequest`** — `user`, `name`, `notes`, `status`
  (`pending`/`approved`/`rejected`). Aprovar um pedido é o sinal para alguém criar o
  arquivo em `data/characters/` via PR. **O app não escreve em `data/` em runtime.**

### Rotas

```
GET  /characters.json          # catálogo completo
GET  /api/daily                # { date:, character_id: }
POST /api/results              # grava a partida (requer sessão)
GET  /stats                    # estatísticas do usuário logado
     resources :character_requests
     namespace :admin
```

### Escolha do personagem do dia

Baralho embaralhado de forma determinística — `ids.shuffle(random: Random.new(SEED))` —
indexado pelo número de dias desde uma data de início. Garante que nenhum personagem se
repita antes de o catálogo se esgotar.

## 7. Painel administrativo (`/admin`)

Controllers e views próprios, sem gem de admin:

```
app/controllers/admin/
  base_controller.rb                # authenticate_user! + authorize! :access, :admin_panel
  dashboard_controller.rb           # estatísticas gerais
  users_controller.rb               # lista de usuários; show com stats do usuário
  character_requests_controller.rb  # aprovar / rejeitar pedidos
app/views/admin/...                 # ERB simples, mesmo CSS do resto do app
```

- Todo controller de `Admin::` herda de `Admin::BaseController`. A autorização mora **só**
  lá.
- **Dashboard:** partidas por dia, taxa de vitória, distribuição de tentativas,
  personagens mais e menos acertados, total de usuários, pedidos pendentes. Tudo com
  agregação SQL (`group`/`count`/`average`) — **nunca** carregue `GameResult.all` em
  memória para contar no Ruby.
- **`Admin::UsersController#show`:** estatísticas individuais (partidas, vitórias, streak
  atual e máxima, histórico). Na listagem, cuide do N+1 com `includes`/`counter_cache`.
- O painel é somente leitura sobre `GameResult`. A única ação de escrita é mudar o
  `status` de um `CharacterRequest`.

## 8. Convenções de código

- Estilo omakase; `bin/rubocop` é a autoridade.
- Minitest, não RSpec. Testes obrigatórios para `Ability` (principalmente o que um membro
  **não** pode fazer) e para os endpoints de `/admin`.
- ERB + Stimulus. Sem framework SPA, sem componentes JS pesados.
- CSS puro em `app/assets/stylesheets`.
- Identificadores de domínio, nomes de modelos e chaves de JSON em **inglês**; comentários,
  mensagens de commit e conversa com o usuário em **português**.
