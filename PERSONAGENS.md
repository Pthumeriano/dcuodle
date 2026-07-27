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
- **Variantes** (Bombshell, JSA, Flashpoint, Future…) entram como personagens próprios
  **quando aparecem** num episódio. Nome no formato `Base (Variante)` (ex.: `Wonder Woman
  (Bombshell)`), id `base-variante` (`wonder-woman-bombshell`). Cada família de variante é
  um grupo no vocabulário (`bombshell`, `jsa`…) e os atributos são ajustados por lore
  (morality, occupations, habitation, paleta) pra não virar cópia da base num jogo de
  dedução. Variante que aparece em vários episódios: creditada no primeiro.

## Legenda

`[ ]` pendente · `[~] ` em progresso · `[x]` completo

## Já no catálogo (231)

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
- [ ] batman-gcpd
- [ ] batman-ninja
- [ ] batman-primal
- [ ] batman-steampowered
- [ ] lex-luthor-cybernetic
- [ ] lex-luthor-professor
- [ ] lex-luthor-general
- [ ] lex-luthor-space-commander
- [ ] future-batman *(retag: +grupo elseworld)*
- [ ] future-lex-luthor *(retag: +grupo elseworld)*

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
- [ ] wonder-woman-bombshell
- [ ] harley-quinn-bombshell
- [ ] supergirl-bombshell
- [ ] catwoman-bombshell

### Ep. 18 — The Demon's Pit & Blackest Day

- [ ] black-hand
- [ ] lyssa-drak

### Ep. 20 — Blackest Night & Wastelands Wonderland

- [ ] nekron

### Ep. 21 — Prison Break & The First Piece

- [ ] the-atom

### Ep. 22 — Science Spire & The Phantom Zone

- [ ] lois-lane

### Ep. 24 — Harley's Heist & Darkseid's War Factory

- [ ] lightray

### Ep. 25 — Iceberg Lounge & A Rip in Time

- [ ] rip-hunter
- [ ] vixen
- [ ] vandal-savage
- [ ] batwoman
- [ ] starro

### Ep. 26 — Wayne Manor Gala & Kandor Central Tower

- [ ] superboy
- [ ] alura

### Ep. 27 — Amazon Fury Part III

- [ ] typhon

### Ep. 28 — Age of Justice

- [ ] per-degaton
- [ ] lady-blackhawk
- [ ] wonder-woman-jsa

### Ep. 29 — Riddled with Crime

- [ ] man-bat
- [ ] query
- [ ] echo

### Ep. 30 — Earth 3

- [ ] ultraman
- [ ] owlman
- [ ] superwoman
- [ ] johnny-quick
- [ ] alexander-luthor

### Ep. 31 — Deluge

- [ ] mera
- [ ] corum-rath
- [ ] alan-scott
- [ ] black-lightning
- [ ] kid-flash

### Ep. 31b — Death of Superman

- [ ] hank-henshaw
- [ ] fire
- [ ] jimmy-olsen
- [ ] xa-du

### Ep. 32 — Teen Titans: The Judas Contract

- [ ] terra
- [ ] red-robin
- [ ] beast-boy
- [ ] jericho
- [ ] adeline-wilson
- [ ] robin *(revisão: alias corrigido pra só Damian Wayne)*

### Ep. 33 — Atlantis

- [ ] aqualad
- [ ] king-shark
- [ ] murk

### Ep. 34 — Justice League Dark

- [ ] phantom-stranger
- [ ] deadman
- [ ] steve-trevor
- [ ] tala
- [ ] etrigan
- [ ] mordru

### Ep. 35 — Metal Part 1

- [ ] the-batman-who-laughs
- [ ] the-red-death
- [ ] the-merciless

### Ep. 36 — Metal Part 2

- [ ] the-drowned
- [ ] dawnbreaker
- [ ] barbatos

### Ep. 49 — Day of Reckoning

- [ ] voivode
- [ ] luzia

### Adendos (chefes de alerta esquecidos)

- [ ] major-force

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
  - **Adendos** (chefes de alerta esquecidos, adicionados depois): major-force (alerta
    Bludhaven; +captain-atom no vocabulário de antagonists).

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
  paradox-destroyer, + variantes de realidade alternativa do raid Nexus of Reality:
  batman-gcpd, batman-ninja, batman-primal, batman-steampowered, lex-luthor-cybernetic,
  lex-luthor-professor, lex-luthor-general, lex-luthor-space-commander *(grupo `elseworld`;
  Bizarro, Huntress já no catálogo. Future Batman/Lex já existiam — retag +elseworld pra
  família ficar coerente. +grupo elseworld no vocabulário)*.
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
  (genérico), + variantes Bombshell: wonder-woman-bombshell, harley-quinn-bombshell,
  supergirl-bombshell, catwoman-bombshell *(The Catwoman = Bombshell Catwoman. Variantes
  entram como personagens próprios desde a decisão de incluí-las — grupo `bombshell`,
  atributos ajustados por lore 1940s. +grupos bombshell/jsa no vocabulário)*.
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
- [x] 21. Prison Break & The First Piece (2016) — the-atom *(Hawkgirl, Hawkman,
  Heat Wave, Captain Cold, Gorilla Grodd, Doctor Light, Abra Kadabra já no catálogo;
  os dois Mercenary Captain, Eckhart e Carlson, são NPCs genéricos do DCUO. +chronos no
  vocabulário de antagonists, nemesis do Atom)*.
- [x] 22. Science Spire & The Phantom Zone (2016) — lois-lane *(The Phantom Zone:
  General Zod, Ursa, Non, Jor-El já no catálogo como avulsos; Captain Zul e o
  Malfunctioning Jor-El A.I. são variantes/NPCs. Science Spire: Superman, Lex Luthor
  já no catálogo; Captain Venz, Senior Officer Gohz, Repair Golem e os soldados
  kryptonianos são NPCs genéricos do DCUO)*.
- [x] 23. The Will of Darkseid & Brainiac's Bottle Ship (2016) — **0 novos**: *Will of
  Darkseid* (Steppenwolf, Mad Harriet, Kalibak, Mantis, Superman, Lex Luthor, Flash,
  Professor Zoom = reverse-flash já no catálogo; Colonel Arrgany, Imperial Goreborer e os
  Field Units são NPCs/vendors) e *Bottle Ship* (Brainiac, Supergirl, General Zod, Superman,
  Lex Luthor já no catálogo; Brood Guardian é genérico).
- [x] 24. Harley's Heist & Darkseid's War Factory (2016) — lightray *(Harley's Heist:
  Harley Quinn, Catwoman, Poison Ivy, Huntress, Black Canary, Zatanna já no catálogo.
  War Factory: Superman, Lex Luthor, Orion, Big Barda, Mister Miracle, Darkseid, Granny
  Goodness, Mad Harriet, Mantis, Lashina, Steppenwolf, Stompa já no catálogo; Parademons,
  Drones e Field Units são NPCs genéricos)*.
- [x] 25. Iceberg Lounge & A Rip in Time (2016) — rip-hunter, vixen, vandal-savage,
  batwoman, starro *(A Rip in Time: Black Adam, Captain Cold, Heat Wave já no catálogo;
  Mercenaries, Kahndaqi e Savage Zealots são mobs. Iceberg Lounge: invasão do Starro que
  controla o Penguin, com Batwoman (Katherine Kane) de NPC — Batman, Catwoman, Poison Ivy,
  Harley Quinn, Penguin já no catálogo; Pengbots e thralls são genéricos. +vandal-savage no
  vocabulário de antagonists)*.
- [x] 26. Wayne Manor Gala & Kandor Central Tower (2016) — superboy, alura *(Wayne Manor
  Gala: Harley Quinn, Catwoman, Poison Ivy, Killer Croc, Black Canary, Huntress, Zatanna já
  no catálogo. Kandor Central Tower: Superman, Supergirl, General Zod, Lex Luthor, Doomsday
  já no catálogo; soldados kryptonianos são mobs)*.
- [x] 27. Amazon Fury Part III (2016) — typhon *(Gods and Monsters + Journey to Olympus:
  Wonder Woman, Circe, Ares, Hades já no catálogo; Typhon, o "Deus dos Monstros", é o vilão
  novo. Lieutenant Helene, Captain Cruz e os monstros/gorgons são NPCs genéricos)*.
- [x] 28. Age of Justice (2017) — per-degaton, lady-blackhawk, wonder-woman-jsa *(tema
  Segunda Guerra; JSA. Justice For All: Vandal Savage — alias "Baron Von Savage" —, Rip
  Hunter, Wildcat já no catálogo. Ultimate Soldier: Gentleman Ghost, Solomon Grundy, Ra's al
  Ghul já no catálogo; o próprio Ultimate Soldier e os Savage Temporal Commanders são
  NPCs/originais. JSA Wonder Woman virou variante wonder-woman-jsa; Bombshell Wonder Woman
  creditada ao ep15, primeira aparição)*.
- [x] 29. Riddled with Crime (2017) — man-bat, query, echo *(disputa de território em
  Gotham. Turf War (Joker/Riddler): Clayface, Deathstroke, Killer Croc, Poison Ivy, Scarecrow,
  Bane, Harley Quinn, Hush, Mr. Freeze, Solomon Grundy já no catálogo; Query e Echo (capangas
  do Charada) entram. Rise of the Bat / Gotham City Zoo: Batwoman, Talia al Ghul, Nightwing já
  no catálogo, +Man-Bat; os Batman-Bat/Joker-Bat/Riddler-Bat e Man-Bat Commandos são mobs do
  soro)*.
- [x] 30. Earth 3 (2017) — ultraman, owlman, superwoman, johnny-quick, alexander-luthor
  *(o Sindicato do Crime da Terra-3: Ultraman/Owlman/Superwoman/Johnny Quick no grupo novo
  `crime-syndicate`; Alexander Luthor é o único herói da Terra-3 (independent, antag ultraman).
  Superman, Batman, Wonder Woman, The Flash, Cyborg, Lex Luthor já no catálogo. Power
  Ring/Grid/Deathstorm/Atomica não aparecem neste episódio; Mayor Gordon, drones e mechs são
  NPCs. +grupo crime-syndicate e +antagonist ultraman no vocabulário)*.
- [x] 31. Deluge (2018) — mera, corum-rath, alan-scott, black-lightning, kid-flash
  *(invasão do Starro Conquistador controlando heróis em Atlântida — Starro já entrou no
  ep25. Aquaman, Ocean Master, Black Manta, Mirror Master, Captain Cold, Trickster, Weather
  Wizard e todos os "Controlled X" já no catálogo; entram Mera, o líder atlante Corum Rath e
  os heróis ainda ausentes que aparecem controlados: Alan Scott (Lanterna Verde da JSA),
  Black Lightning, Kid Flash)*.
- [x] 31b. Death of Superman (2018) — hank-henshaw, fire, jimmy-olsen, xa-du *(Superman,
  Doomsday, Bizarro, Superboy, Steel, Lois Lane, Booster Gold, Power Girl, Supergirl, Guy
  Gardner já no catálogo; entram Hank Henshaw (Cyborg Superman), Fire (Beatriz da Costa),
  Jimmy Olsen e o Rei Fantasma Xa-Du. +antagonist solomon-grundy no vocabulário, nemesis do
  Alan Scott)*.
- [x] 32. Teen Titans: The Judas Contract (2018) — terra, red-robin, beast-boy, jericho,
  adeline-wilson *(Cyborg, Starfire, Nightwing, Raven, Donna Troy, Psimon, Gizmo, Jinx,
  Mammoth, Deathstroke já no catálogo. Terra é a traidora do contrato; Beast Boy (Mutano)
  faltava. Os dois Robins: "Robin (Damian Wayne)" = o `robin` do catálogo (alias corrigido
  pra só Damian) e Red Robin = Tim Drake, entra novo. Wonder Dog e H.I.V.E. Master são
  pet/NPC genérico)*.
- [x] 33. Atlantis (2018) — aqualad, king-shark, murk *(Aquaman, Ocean Master, Mera, Corum
  Rath, Black Manta já no catálogo; entram Aqualad (Kaldur'ahm), King Shark e o comandante
  atlante Murk. The Faceless One, Golems, Brine e Sea Beast são vilão obscuro/monstros
  genéricos, fora de escopo)*.
- [x] 34. Justice League Dark (2019) — phantom-stranger, deadman, steve-trevor, tala,
  etrigan, mordru *(Zatanna, John Constantine, Doctor Fate, Shazam, Batwoman, Felix Faust,
  Klarion, Teekl já no catálogo; entram Phantom Stranger, Deadman, Steve Trevor, a feiticeira
  Tala, Etrigan e Mordru. ARGUS e Bound Daemon são NPCs. +antagonists klarion, doctor-fate no
  vocabulário, nemeses de Etrigan e Mordru)*.
- [x] 35. Metal Part 1 (2019) — the-batman-who-laughs, the-red-death, the-merciless *(Dark
  Nights: Metal. Os Cavaleiros das Trevas (Batmen malignos do Multiverso Sombrio) no grupo novo
  `dark-knights`. Nightwing, Hal Jordan (=green-lantern), Robin, Deathstroke, Killer Croc,
  Commissioner Gordon, Wonder Woman, Ares, Hades, Bane, Mr. Freeze, Poison Ivy, Sinestro já no
  catálogo; Dark Robin e os vendors são mobs/NPCs)*.
- [x] 36. Metal Part 2 (2019) — the-drowned, dawnbreaker, barbatos *(mais Cavaleiros das
  Trevas + Barbatos, o deus-morcego que os forjou (também no grupo dark-knights). Batman
  Who Laughs/Red Death/Merciless creditados ao ep35. Hawkgirl, Martian Manhunter, Batman,
  Wonder Woman já no catálogo; Lady Blackhawk (Thanagar) é reskin, e os suppliers são NPCs)*.
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
