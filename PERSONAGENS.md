# Plano — Personagens do DCUO no DCUOdle

Meta: adicionar **todos os personagens que aparecem no DC Universe Online**, indo de
episódio em episódio. Este arquivo é o checklist de progresso.

## Como funciona

- **Contrato de dados:** [CLAUDE.md](CLAUDE.md) §5 — um JSON por personagem em
  `data/characters/`, todo valor de atributo tem que existir em `data/vocabularies.json`.
- **Pesquisa:** WebSearch na [DCUO Wiki](https://dcuniverseonline.fandom.com) — o WebFetch
  direto no Fandom retorna 402, mas o resumo do WebSearch puxa o conteúdo da wiki.
- **Fluxo por episódio:** pesquisar o elenco → criar/atualizar os JSONs → `bin/rails test`
  → marcar `[x]` aqui com a lista de ids adicionados.
- **Sem duplicar:** personagem que aparece em vários episódios entra **uma vez**; conta no
  primeiro em que for adicionado. Iconics já entram pelo Base Game.
- **Escopo:** priorizar personagens nomeados (heróis, vilões, NPCs de história, chefes).
  Trash mobs genéricos ficam de fora.

## Legenda

`[ ]` pendente · `[~] ` em progresso · `[x]` completo

## Já no catálogo (167)

- **16 originais curados** (seed inicial, feitos à mão): batman, superman, wonder-woman,
  aquaman, the-flash, green-lantern, cyborg, green-arrow, zatanna, raven, nightwing,
  joker, lex-luthor, harley-quinn, poison-ivy, catwoman.
- **45 do Base Game** (2 lotes bulk — ver *Revisão de atributos* abaixo).
- **29 avulsos** (da memória do usuário — bulk, ver *Revisão* abaixo).
- **Ep. 1-3** (Lanternas, Rogues do Flash, invasão do Brainiac — bulk, ver *Revisão*).
- **Ep. 49 Day of Reckoning:** voivode, luzia *(parcial — falta o resto do elenco)*.
- **Original do usuário (fora do cânon DCUO):** 409-conflict *(liga Noctem)*.

Lista completa dos ids: `ls data/characters/`.

---

## Revisão de atributos

Segundo passo do fluxo: depois de bulk-adicionar, revisar **um por um** contra o cânon
DC / DCUO e ajustar. Em cada personagem, conferir:

- `race` · `gender` · `morality` — corretos?
- `groups` · `occupations` — refletem o papel no DCUO?
- `powers` — é o **power set** certo do DCUO? (ex.: Nature, Fire, Hard Light, Ice…)
- `antagonists` — cross-links coerentes e apontando pra ids que existem?
- `hints.habitation` · `hints.quote` (trocar por fala real do DCUO quando houver) · `hints.palette`

Rodar `bin/rails test` depois de cada ajuste. Marcar `[x]` quando o personagem estiver
conferido. Os 16 originais curados não entram aqui (já foram feitos à mão).

### Base Game — Lote 1

- [ ] circe
- [ ] brainiac
- [ ] bizarro
- [ ] metallo
- [ ] bane
- [ ] doomsday
- [ ] solomon-grundy
- [ ] penguin
- [ ] two-face
- [ ] mr-freeze
- [ ] scarecrow
- [ ] riddler
- [ ] killer-croc
- [ ] deathstroke
- [ ] martian-manhunter
- [ ] supergirl
- [ ] steel
- [ ] robin
- [ ] batgirl

### Base Game — Lote 2

- [ ] hawkman
- [ ] hawkgirl
- [ ] black-canary
- [ ] booster-gold
- [ ] blue-beetle
- [ ] power-girl
- [ ] alfred
- [ ] commissioner-gordon
- [ ] parasite
- [ ] livewire
- [ ] toyman
- [ ] giganta
- [ ] killer-frost
- [ ] clayface
- [ ] mad-hatter
- [ ] hush
- [ ] talia-al-ghul
- [ ] ras-al-ghul
- [ ] sinestro
- [ ] star-sapphire
- [ ] cheetah
- [ ] ares
- [ ] black-manta
- [ ] ocean-master
- [ ] steppenwolf
- [ ] kalibak

### Avulsos (da memória)

- [ ] spectre
- [ ] wildcat
- [ ] eclipso
- [ ] klarion
- [ ] teekl
- [ ] jor-el
- [ ] general-zod
- [ ] ursa
- [ ] non
- [ ] amon-sur
- [ ] kilowog
- [ ] vicki-vale
- [ ] jack-ryder
- [ ] brother-blood
- [ ] starfire
- [ ] brother-eye
- [ ] the-huntress
- [ ] wonder-girl
- [ ] john-stewart
- [ ] doctor-fate
- [ ] atrocitus
- [ ] shazam
- [ ] black-adam
- [ ] kyle-rayner
- [ ] donna-troy
- [ ] trigon
- [ ] felix-faust
- [ ] guy-gardner
- [ ] saint-walker

### Ep. 1 — Fight for the Light

- [ ] krona
- [ ] larfleeze
- [ ] arkillo
- [ ] mongul
- [ ] indigo-1
- [ ] ganthet
- [ ] abin-sur
- [ ] bleez
- [ ] dex-starr
- [ ] tomar-re

### Ep. 2 — Lightning Strikes

- [ ] captain-cold
- [ ] heat-wave
- [ ] mirror-master
- [ ] weather-wizard
- [ ] the-trickster
- [ ] captain-boomerang
- [ ] pied-piper
- [ ] gorilla-grodd
- [ ] abra-kadabra
- [ ] reverse-flash
- [ ] zoom

### Ep. 3 — The Battle for Earth

- [ ] future-batman
- [ ] future-lex-luthor
- [ ] avatar-of-magic
- [ ] avatar-of-tech
- [ ] avatar-of-meta

### Ep. 5 — Hand of Fate

- [ ] swamp-thing

### Ep. 6 — Home Turf

- [ ] t-o-morrow

### Ep. 7 — Origin Crisis

- [ ] red-tornado
- [ ] joe-chill
- [ ] thomas-wayne
- [ ] martha-wayne
- [ ] lara
- [ ] paradox-destroyer

### Ep. 8 — Sons of Trigon

- [ ] psimon
- [ ] mammoth
- [ ] jinx
- [ ] gizmo
- [ ] doctor-light
- [ ] gentleman-ghost
- [ ] john-constantine
- [ ] belial
- [ ] jared-wrath
- [ ] jesse-envy
- [ ] jacob-lust
- [ ] jack-sloth
- [ ] julius-gluttony
- [ ] james-greed

### Ep. 9 — War of the Light Part I

- [ ] brother-warth
- [ ] arisia
- [ ] mogo
- [ ] ranx

### Ep. 10 — Amazon Fury Part I

- [ ] hippolyta

### Ep. 11 — Halls of Power Part I

- [ ] mantis
- [ ] mister-miracle
- [ ] big-barda

### Ep. 12 — War of the Light Part II

- [ ] glomulus
- [ ] parallax
- [ ] predator
- [ ] emotional-entity

### Ep. 13 — Amazon Fury Part II

- [ ] hades
- [ ] cerberus

### Ep. 14 — Halls of Power Part II

- [ ] darkseid
- [ ] orion
- [ ] granny-goodness
- [ ] highfather
- [ ] lashina
- [ ] stompa
- [ ] mad-harriet

### Ep. 15 — Bombshells Paradox & Corrupted Zamaron

- [ ] queen-agapo
- [ ] black-lantern

### Ep. 18 — The Demon's Pit & Blackest Day

- [ ] black-hand
- [ ] lyssa-drak

### Ep. 20 — Blackest Night & Wastelands Wonderland

- [ ] nekron

### Ep. 49 — Day of Reckoning

- [ ] voivode
- [ ] luzia

---

## Base Game (Classic — Metropolis & Gotham)

- [x] **Base Game** — elenco original do jogo (JL, Bat-família, Rogues, Legion of Doom).
  - **Lote 1 (19):** circe, brainiac, bizarro, metallo, bane, doomsday, solomon-grundy,
    penguin, two-face, mr-freeze, scarecrow, riddler, killer-croc, deathstroke,
    martian-manhunter, supergirl, steel, robin, batgirl.
  - **Lote 2 (26):** hawkman, hawkgirl, black-canary, booster-gold, blue-beetle,
    power-girl, alfred, commissioner-gordon, parasite, livewire, toyman, giganta,
    killer-frost, clayface, mad-hatter, hush, talia-al-ghul, ras-al-ghul, sinestro,
    star-sapphire, cheetah, ares, black-manta, ocean-master, steppenwolf, kalibak.
  - Nomes ainda mais secundários (Vandal Savage, Gorilla Grodd, Captain Cold, Reverse-Flash,
    Firestorm, Zatara…) entram junto com os episódios em que aparecem.

## Episódios

- [x] 1. Fight for the Light (2011) — Lanternas: larfleeze, arkillo, mongul, indigo-1,
  ganthet, abin-sur, bleez, dex-starr, tomar-re *(sinestro, atrocitus, kilowog, amon-sur,
  saint-walker, os 3 GLs e star-sapphire já vieram avulsos)*. **+krona** (chefe do alerta
  Oan Sciencells).
- [x] 2. Lightning Strikes (2011) — Rogues do Flash: captain-cold, heat-wave, mirror-master,
  weather-wizard, the-trickster, captain-boomerang, pied-piper, gorilla-grodd, abra-kadabra,
  reverse-flash, zoom.
- [x] 3. The Battle for Earth (2012) — future-batman, future-lex-luthor, avatar-of-magic,
  avatar-of-tech, avatar-of-meta *(Brainiac, Wonder Woman, Circe, Batman já no catálogo)*.
- [x] 4. The Last Laugh (2012) — **0 novos**: DLC de PvP; os Legends (amon-sur, arkillo,
  bizarro, john-stewart, kilowog, power-girl, ursa) e o Joker já estavam no catálogo.
- [x] 5. Hand of Fate (2012) — swamp-thing *(Doctor Fate, Felix Faust, Ra's al Ghul,
  Solomon Grundy, Spectre, Eclipso já no catálogo)*.
- [x] 6. Home Turf (2013) — t-o-morrow *(DLC de Bases/Lairs; Steel já no catálogo)*.
- [x] 7. Origin Crisis (2013) — red-tornado, joe-chill, thomas-wayne, martha-wayne, lara,
  paradox-destroyer *(Future Batman/Lex, Bizarro, Huntress já no catálogo)*.
- [x] 8. Sons of Trigon (2013) — Fearsome Five (psimon, mammoth, jinx, gizmo, doctor-light),
  gentleman-ghost, john-constantine, belial, e os 6 Filhos (jared-wrath, jesse-envy,
  jacob-lust, jack-sloth, julius-gluttony, james-greed) *(Trigon, Raven já no catálogo)*.
- [x] 9. War of the Light Part I (2014) — brother-warth, arisia, mogo, ranx *(quase todo o
  elenco de Lanterna já veio nos Eps 1/avulsos: sinestro, atrocitus, saint-walker, etc.)*.
- [x] 10. Amazon Fury Part I (2014) — hippolyta *(Wonder Woman, Circe, Ares já no catálogo;
  Hades entra nos Parts II/III)*.
- [x] 11. Halls of Power Part I (2014) — mantis, mister-miracle, big-barda *(Kalibak,
  Steppenwolf já no catálogo; Darkseid pendente — não aparece direto aqui)*.
- [x] 12. War of the Light Part II (2014) — glomulus, parallax, predator, emotional-entity
  *(entidade genérica que cobre Ion/Ophidian/Adara/Proselyte/Butcher; Star Sapphire,
  Larfleeze já no catálogo; Krona creditado ao Ep 1)*.
- [x] 13. Amazon Fury Part II (2015) — hades, cerberus *(Ares, Wonder Woman, Circe,
  Hippolyta já no catálogo; Hydra/Minotauro são genéricos)*.
- [x] 14. Halls of Power Part II (2015) — darkseid, orion, granny-goodness, highfather,
  + Fúrias Femininas (lashina, stompa, mad-harriet — estrearam aqui) *(Kalibak,
  Steppenwolf, Mantis, Mister Miracle, Big Barda já no catálogo)*.
- [x] 15. Bombshells Paradox & Corrupted Zamaron (2015) — queen-agapo, black-lantern
  (genérico) *(Bombshells são versões retrô de heroínas já no catálogo)*.
- [x] 16. Desecrated Cathedral & Oa Under Siege (2015) — **0 novos**: Brother Blood, Raven,
  Filhos do Trigon, Black Lanterns e Green Lanterns já no catálogo.
- [x] 17. Unholy Matrimony & The Flash Museum Burglary (2015) — **0 novos**: *Unholy
  Matrimony* (Trigon, Brother Blood, Raven, Filhos do Trigon, Circe) e *Flash Museum
  Burglary* (Liga dos Assassinos — Talia/Ra's al Ghul, The Flash; o boss final "Bomb
  Blast" é mecânica de bombas, não personagem canônico) já estão todos no catálogo.
- [x] 18. The Demon's Pit & Blackest Day (2015) — black-hand, lyssa-drak *(Blackest Day:
  Sinestro, Ranx, Black Lanterns já no catálogo; Nekron creditado ao Ep 20. The Demon's
  Pit: Ra's/Talia al Ghul já no catálogo, restante são Alquimistas genéricos)*.
- [x] 19. The Demon's Plan & Deep Desires (2015) — **0 novos**: *The Demon's Plan* (Black
  Canary, Ra's al Ghul, Green Arrow, Heat Wave, Captain Cold já no catálogo); *Deep Desires*
  (Filhos do Trigon — Julius/Jesse/Jacob já entraram no Ep 8; demônios menores genéricos).
- [x] 20. Blackest Night & Wastelands Wonderland (2016) — nekron *(Blackest Night: Black
  Hand já entrou no Ep 18, Hal Jordan/Sinestro/Black Lanterns já no catálogo. Wastelands
  Wonderland: Jacob/Jack (Filhos do Trigon) e Raven já no catálogo)*.
- [ ] 21. Prison Break & The First Piece (2016)
- [ ] 22. Science Spire & The Phantom Zone (2016)
- [ ] 23. The Will of Darkseid & Brainiac's Bottle Ship (2016)
- [ ] 24. Harley's Heist & Darkseid's War Factory (2016)
- [ ] 25. Iceberg Lounge & A Rip in Time (2016)
- [ ] 26. Wayne Manor Gala & Kandor Central Tower (2016)
- [ ] 27. Amazon Fury Part III (2016)
- [ ] 28. Age of Justice (2017)
- [ ] 29. Riddled with Crime (2017)
- [ ] 30. Earth 3 (2017)
- [ ] 31. Deluge (2018)
- [ ] 31b. Death of Superman (2018)
- [ ] 32. Teen Titans: The Judas Contract (2018)
- [ ] 33. Atlantis (2018)
- [ ] 34. Justice League Dark (2019)
- [ ] 35. Metal Part 1 (2019)
- [ ] 36. Metal Part 2 (2019)
- [ ] 37. Birds of Prey (2020)
- [ ] 38. Wonderverse (2020)
- [ ] 39. Long Live the Legion (2020)
- [ ] 40. World of Flashpoint (2021)
- [ ] 41. House of Legends (2021)
- [ ] 42. Legion of Doom (2021)
- [ ] 43. Dark Knights (2022)
- [ ] 44. The Sins of Black Adam (2022)
- [ ] 45. Shock to the System (2023)
- [ ] 46. Justice League Dark Cursed (2023)
- [ ] 47. Brainiac Returns (2024)
- [ ] 48. Harley Quinn vs. Apokolips (2024)
- [~] 49. Day of Reckoning (2025) — feitos: voivode, luzia · falta o resto do elenco
- [ ] 50. Fearful Day (2025)
- [ ] 51. Raging Night (2025)
- [ ] 52. Hope Burns Bright (2026)
- [ ] 53. Shadows Over Argo (2026)

---

*Lista de episódios: [shadowdragonmedia](https://shadowdragonmedia.blogspot.com/p/dcuo-episode-list.html)
· [DCUO Bloguide](https://dcuobloguide.com/episodes/).*
