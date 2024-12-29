;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Szablon startowy: brak wyników, brak pytań, brak odpowiedzi
;; Tworzymy pierwsze pytanie.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule start
   (not (exists (wynik $?)))
   (not (exists (pytanie $?)))
   (not (exists (odpowiedz $?)))
   =>
   (assert (pytanie "What type of game are you looking for?" "I want a Wargame" "A Strategy Game")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WYBÓR GłóWNY: Wargame vs A Strategy Game
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule choose-wargame
   ?o <- (odpowiedz "I want a Wargame")
   ?p <- (pytanie "What type of game are you looking for?" "I want a Wargame" "A Strategy Game")
   =>
   (retract ?o ?p)
   (assert (pytanie "For how many players?" "Just me" "2 or more")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; For how many players?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-just-me
   ?o <- (odpowiedz "Just me")
   ?p <- (pytanie "For how many players?" "Just me" "2 or more")
   =>
   (retract ?o ?p)
   (assert (pytanie "Which theme do you prefer?" "Historic Battles" "Modern Air Support" "Science Fiction")))

(defrule wargame-2plus
   ?o <- (odpowiedz "2 or more")
   ?p <- (pytanie "For how many players?" "Just me" "2 or more")
   =>
   (retract ?o ?p)
   (assert (pytanie "Do you have any wargaming experience?" "It's new to me" "Yes")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; JUST ME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-just-me-historic
   ?o <- (odpowiedz "Historic Battles")
   ?p <- (pytanie "Which theme do you prefer?" "Historic Battles" "Modern Air Support" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (wynik "Field Commander Series (Historic Battles)")))

(defrule wargame-just-me-modern
   ?o <- (odpowiedz "Modern Air Support")
   ?p <- (pytanie "Which theme do you prefer?" "Historic Battles" "Modern Air Support" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (wynik "Thunderbolt: Apache Leader (Modern Air Support)")))

(defrule wargame-just-me-scifi
   ?o <- (odpowiedz "Science Fiction")
   ?p <- (pytanie "Which theme do you prefer?" "Historic Battles" "Modern Air Support" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (wynik "Space Infantry (Science Fiction)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; 2 or more
;; Pytanie o doświadczenie
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-2plus-new
   ?o <- (odpowiedz "It's new to me")
   ?p <- (pytanie "Do you have any wargaming experience?" "It's new to me" "Yes")
   =>
   (retract ?o ?p)
   (assert (pytanie "Are you a fan of Risk?" "Yes" "No")))

(defrule wargame-2plus-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Do you have any wargaming experience?" "It's new to me" "Yes")
   =>
   (retract ?o ?p)
   (assert (pytanie "Want to command Roman legions?" "Yes" "No")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; Doświadczenie: It's new to me -> Are you a fan of Risk?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-risk-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Are you a fan of Risk?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Risk: Legacy")))

(defrule wargame-risk-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Are you a fan of Risk?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "World history, or high fantasy?" "World history" "High fantasy")))

(defrule wargame-new-world
   ?o <- (odpowiedz "World history")
   ?p <- (pytanie "World history, or high fantasy?" "World history" "High fantasy")
   =>
   (retract ?o ?p)
   (assert (wynik "Memoir '44 (History)")))

(defrule wargame-new-fantasy
   ?o <- (odpowiedz "High fantasy")
   ?p <- (pytanie "World history, or high fantasy?" "World history" "High fantasy")
   =>
   (retract ?o ?p)
   (assert (wynik "Battles of Westeros (Fantasy)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; Doświadczenie: Yes -> Want to command Roman legions?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-roman-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Want to command Roman legions?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Commands & Colors: Ancients")))

(defrule wargame-roman-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Want to command Roman legions?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Lead 19th Century battle lines?" "Yes" "No")))

(defrule wargame-19th-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Lead 19th Century battle lines?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "1812: The Invasion of Canada")))

(defrule wargame-19th-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Lead 19th Century battle lines?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "How about World War II?" "Yes" "No")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; World War II?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-ww2-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "How about World War II?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Card- or dice-driven combat?" "Card" "Dice")))

(defrule wargame-ww2-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "How about World War II?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Modern Warfare, then?" "Yes, I like the immediacy" "No, I'm tired of real wars")))

(defrule wargame-ww2-card
   ?o <- (odpowiedz "Card")
   ?p <- (pytanie "Card- or dice-driven combat?" "Card" "Dice")
   =>
   (retract ?o ?p)
   (assert (wynik "Combat Commander Series (shuffle shuffle)")))

(defrule wargame-ww2-dice
   ?o <- (odpowiedz "Dice")
   ?p <- (pytanie "Card- or dice-driven combat?" "Card" "Dice")
   =>
   (retract ?o ?p)
   (assert (wynik "Tide of Iron (roll roll roll)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; Modern Warfare
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-modern-yes
   ?o <- (odpowiedz "Yes, I like the immediacy")
   ?p <- (pytanie "Modern Warfare, then?" "Yes, I like the immediacy" "No, I'm tired of real wars")
   =>
   (retract ?o ?p)
   (assert (wynik "Labyrinth: The War on Terror")))

(defrule wargame-modern-no
   ?o <- (odpowiedz "No, I'm tired of real wars")
   ?p <- (pytanie "Modern Warfare, then?" "Yes, I like the immediacy" "No, I'm tired of real wars")
   =>
   (retract ?o ?p)
   (assert (pytanie "Science Fictions or alternate history?" "Alt-History" "Science Fiction")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WARGAME ŚCIEŻKA
;; Sci-Fi or Alt-History
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wargame-alt
   ?o <- (odpowiedz "Alt-History")
   ?p <- (pytanie "Science Fictions or alternate history?" "Alt-History" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (pytanie "Tactical miniatures, or large-scale strategy?" "Tactical miniatures" "Large-scale strategy")))

(defrule wargame-scifi
   ?o <- (odpowiedz "Science Fiction")
   ?p <- (pytanie "Science Fictions or alternate history?" "Alt-History" "Science Fiction")
   =>
   (retract ?o ?p)
   (assert (pytanie "Space ships or giant robots?" "Space ships" "Giant robots")))

(defrule wargame-alt-tactical
   ?o <- (odpowiedz "Tactical miniatures")
   ?p <- (pytanie "Tactical miniatures, or large-scale strategy?" "Tactical miniatures" "Large-scale strategy")
   =>
   (retract ?o ?p)
   (assert (wynik "Dust Tactics (Tactical)")))

(defrule wargame-alt-strategy
   ?o <- (odpowiedz "Large-scale strategy")
   ?p <- (pytanie "Tactical miniatures, or large-scale strategy?" "Tactical miniatures" "Large-scale strategy")
   =>
   (retract ?o ?p)
   (assert (wynik "Fortress America (Strategic)")))

(defrule wargame-scifi-ships
   ?o <- (odpowiedz "Space ships")
   ?p <- (pytanie "Space ships or giant robots?" "Space ships" "Giant robots")
   =>
   (retract ?o ?p)
   (assert (wynik "Battleship Galaxies (Ships)")))

(defrule wargame-scifi-robots
   ?o <- (odpowiedz "Giant robots")
   ?p <- (pytanie "Space ships or giant robots?" "Space ships" "Giant robots")
   =>
   (retract ?o ?p)
   (assert (wynik "Battletech (Mechs)")))

(defrule choose-strategy-override
   ?o <- (odpowiedz "A Strategy Game")
   ?p <- (pytanie "What type of game are you looking for?" "I want a Wargame" "A Strategy Game")
   =>
   (retract ?o ?p)
   (assert (pytanie "What kind of theme?" "Horror" "Science Fiction" "Fantasy")))

(defrule strategy-theme-scifi
   ?o <- (odpowiedz "Science Fiction")
   ?p <- (pytanie "What kind of theme?" "Horror" "Science Fiction" "Fantasy")
   =>
   (retract ?o ?p)
   (assert (pytanie "Star Wars fan?" "Yes" "No")))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SCIENCE FICTION GAŁĄŹ DLA A STRATEGY GAME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule scifi-starwars-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Star Wars fan?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Grand adventure or tactical space combat?" "Adventure" "Pew! Pew!")))

(defrule scifi-starwars-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Star Wars fan?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Star Trek, then?" "Yes" "No")))

(defrule scifi-starwars-adventure
   ?o <- (odpowiedz "Adventure")
   ?p <- (pytanie "Grand adventure or tactical space combat?" "Adventure" "Pew! Pew!")
   =>
   (retract ?o ?p)
   (assert (wynik "Star Wars Living Card Game")))

(defrule scifi-starwars-tactical
   ?o <- (odpowiedz "Pew! Pew!")
   ?p <- (pytanie "Grand adventure or tactical space combat?" "Adventure" "Pew! Pew!")
   =>
   (retract ?o ?p)
   (assert (wynik "Star Wars: X-Wing Miniature Game")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STAR TREK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule scifi-trek-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Star Trek, then?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "One-on-one, or working together?" "One-on-one" "Working together")))

(defrule scifi-trek-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Star Trek, then?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Battlestar Galactica?" "Yes" "No")))

(defrule scifi-trek-one
   ?o <- (odpowiedz "One-on-one")
   ?p <- (pytanie "One-on-one, or working together?" "One-on-one" "Working together")
   =>
   (retract ?o ?p)
   (assert (wynik "Star Trek: Fleet Captains (Competitive)")))

(defrule scifi-trek-work
   ?o <- (odpowiedz "Working together")
   ?p <- (pytanie "One-on-one, or working together?" "One-on-one" "Working together")
   =>
   (retract ?o ?p)
   (assert (wynik "Star Trek Expeditions (Cooperative)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BATTLESTAR GALACTICA?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule scifi-bsg-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Battlestar Galactica?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Battlestar Galactica: the Board Game")))

(defrule scifi-bsg-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Battlestar Galactica?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Explore, Expand, Exploit, and Exterminate?" "Of course!" "That's not right!")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4X PYTANIE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule scifi-4x-yes
   ?o <- (odpowiedz "Of course!")
   ?p <- (pytanie "Explore, Expand, Exploit, and Exterminate?" "Of course!" "That's not right!")
   =>
   (retract ?o ?p)
   (assert (pytanie "So, just how epic are we getting?" "We got all day" "It's a work night...")))

(defrule scifi-4x-no
   ?o <- (odpowiedz "That's not right!")
   ?p <- (pytanie "Explore, Expand, Exploit, and Exterminate?" "Of course!" "That's not right!")
   =>
   (retract ?o ?p)
   (assert (pytanie "How about being an alien race?" "That sounds fun" "Maybe not")))

(defrule scifi-epic-day
   ?o <- (odpowiedz "We got all day")
   ?p <- (pytanie "So, just how epic are we getting?" "We got all day" "It's a work night...")
   =>
   (retract ?o ?p)
   (assert (wynik "Twilight Imperium: 3rd Edition (Epic)")))

(defrule scifi-epic-work
   ?o <- (odpowiedz "It's a work night...")
   ?p <- (pytanie "So, just how epic are we getting?" "We got all day" "It's a work night...")
   =>
   (retract ?o ?p)
   (assert (wynik "Eclipse (Shorter 4X)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Alien race?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule scifi-alien-yes
   ?o <- (odpowiedz "That sounds fun")
   ?p <- (pytanie "How about being an alien race?" "That sounds fun" "Maybe not")
   =>
   (retract ?o ?p)
   (assert (pytanie "Doing battle..." "Cosmic Encounter" "Rex: Final Days of an Empire" "Conquest of Planet Earth")))

(defrule scifi-alien-no
   ?o <- (odpowiedz "Maybe not")
   ?p <- (pytanie "How about being an alien race?" "That sounds fun" "Maybe not")
   =>
   (retract ?o ?p)
   (assert (pytanie "How about a card game?" "Sure, that works" "I like my boards")))

(defrule scifi-doing-cosmic
   ?o <- (odpowiedz "Cosmic Encounter")
   ?p <- (pytanie "Doing battle..." "Cosmic Encounter" "Rex: Final Days of an Empire" "Conquest of Planet Earth")
   =>
   (retract ?o ?p)
   (assert (wynik "Cosmic Encounter (In Space)")))

(defrule scifi-doing-rex
   ?o <- (odpowiedz "Rex: Final Days of an Empire")
   ?p <- (pytanie "Doing battle..." "Cosmic Encounter" "Rex: Final Days of an Empire" "Conquest of Planet Earth")
   =>
   (retract ?o ?p)
   (assert (wynik "Rex: Final Days of an Empire (For the Galactic Centre)")))

(defrule scifi-doing-conquest
   ?o <- (odpowiedz "Conquest of Planet Earth")
   ?p <- (pytanie "Doing battle..." "Cosmic Encounter" "Rex: Final Days of an Empire" "Conquest of Planet Earth")
   =>
   (retract ?o ?p)
   (assert (wynik "Conquest of Planet Earth (For Earth)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Card game or boards?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule scifi-card-game
   ?o <- (odpowiedz "Sure, that works")
   ?p <- (pytanie "How about a card game?" "Sure, that works" "I like my boards")
   =>
   (retract ?o ?p)
   (assert (pytanie "A Deck builder?" "Yes" "No")))

(defrule scifi-boards
   ?o <- (odpowiedz "I like my boards")
   ?p <- (pytanie "How about a card game?" "Sure, that works" "I like my boards")
   =>
   (retract ?o ?p)
   (assert (pytanie "If not an alien, I'll be a..." "Athlete" "Galactic Corporation" "Space Crew" "Merchant")))

(defrule scifi-deck-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "A Deck builder?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Core Worlds (Deck Builder)")))

(defrule scifi-deck-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "A Deck builder?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "A Living Card Game?" "Yes" "No")))

(defrule scifi-lcg-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "A Living Card Game?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Android: Netrunner (LCG)")))

(defrule scifi-lcg-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "A Living Card Game?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Race for the Galaxy (Engine Builder Card Game)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Boards path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule scifi-role-athlete
   ?o <- (odpowiedz "Athlete")
   ?p <- (pytanie "If not an alien, I'll be a..." "Athlete" "Galactic Corporation" "Space Crew" "Merchant")
   =>
   (retract ?o ?p)
   (assert (wynik "Dreadball: The Futuristic Sport Game (Athlete)")))

(defrule scifi-role-corp
   ?o <- (odpowiedz "Galactic Corporation")
   ?p <- (pytanie "If not an alien, I'll be a..." "Athlete" "Galactic Corporation" "Space Crew" "Merchant")
   =>
   (retract ?o ?p)
   (assert (wynik "Phantom League (Galactic Corporation)")))

(defrule scifi-role-crew
   ?o <- (odpowiedz "Space Crew")
   ?p <- (pytanie "If not an alien, I'll be a..." "Athlete" "Galactic Corporation" "Space Crew" "Merchant")
   =>
   (retract ?o ?p)
   (assert (pytanie "How will you succeed?" "Teamwork and high-speed planning" "Teamwork and dexterity")))

(defrule scifi-role-merchant
   ?o <- (odpowiedz "Merchant")
   ?p <- (pytanie "If not an alien, I'll be a..." "Athlete" "Galactic Corporation" "Space Crew" "Merchant")
   =>
   (retract ?o ?p)
   (assert (pytanie "Seriously?" "Yes" "No")))

(defrule scifi-crew-planning
   ?o <- (odpowiedz "Teamwork and high-speed planning")
   ?p <- (pytanie "How will you succeed?" "Teamwork and high-speed planning" "Teamwork and dexterity")
   =>
   (retract ?o ?p)
   (assert (wynik "Space Alert (Teamwork and planning)")))

(defrule scifi-crew-dexterity
   ?o <- (odpowiedz "Teamwork and dexterity")
   ?p <- (pytanie "How will you succeed?" "Teamwork and high-speed planning" "Teamwork and dexterity")
   =>
   (retract ?o ?p)
   (assert (wynik "Space Cadets (Teamwork and dexterity)")))

(defrule scifi-merchant-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Seriously?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Merchant of Venus (Serious business)")))

(defrule scifi-merchant-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Seriously?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Galaxy Trucker (For a giggle)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HORROR ŚCIEŻKA DLA "A Strategy Game"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule strategy-theme-horror-override
   ?o <- (odpowiedz "Horror")
   ?p <- (pytanie "What kind of theme?" "Horror" "Science Fiction" "Fantasy")
   =>
   (retract ?o ?p)
   (assert (pytanie "What's your favorite monster?" "Zombies" "Cthulhu" "Classic Movie Monsters")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HORROR: ZOMBIES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule horror-zombies
   ?o <- (odpowiedz "Zombies")
   ?p <- (pytanie "What's your favorite monster?" "Zombies" "Cthulhu" "Classic Movie Monsters")
   =>
   (retract ?o ?p)
   (assert (pytanie "Boards or Cards?" "Board Game" "Card Game")))

(defrule horror-zombies-board
   ?o <- (odpowiedz "Board Game")
   ?p <- (pytanie "Boards or Cards?" "Board Game" "Card Game")
   =>
   (retract ?o ?p)
   (assert (pytanie "Survival of the Fittest or Zombies vs Humans?" "Survival of the Fittest" "Zombies vs Humans")))

(defrule horror-zombies-card
   ?o <- (odpowiedz "Card Game")
   ?p <- (pytanie "Boards or Cards?" "Board Game" "Card Game")
   =>
   (retract ?o ?p)
   (assert (wynik "Resident Evil Deckbuilding Game")))

;; Board Game -> Survival or Humans vs Zombies
(defrule horror-zombies-survival
   ?o <- (odpowiedz "Survival of the Fittest")
   ?p <- (pytanie "Survival of the Fittest or Zombies vs Humans?" "Survival of the Fittest" "Zombies vs Humans")
   =>
   (retract ?o ?p)
   (assert (wynik "City of Horror")))

(defrule horror-zombies-humans
   ?o <- (odpowiedz "Zombies vs Humans")
   ?p <- (pytanie "Survival of the Fittest or Zombies vs Humans?" "Survival of the Fittest" "Zombies vs Humans")
   =>
   (retract ?o ?p)
   (assert (pytanie "Does anyone want to play as the zombies?" "Yes" "No")))

(defrule horror-zombies-as-zombies-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Does anyone want to play as the zombies?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Zombicide (We're all humans here)")))

(defrule horror-zombies-as-zombies-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Does anyone want to play as the zombies?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Last Night on Earth (Sure! Braaaains...)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HORROR: CTHULHU
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule horror-cthulhu
   ?o <- (odpowiedz "Cthulhu")
   ?p <- (pytanie "What's your favorite monster?" "Zombies" "Cthulhu" "Classic Movie Monsters")
   =>
   (retract ?o ?p)
   (assert (pytanie "Ever wanted to play on his side?" "Well, maybe a little..." "No")))

(defrule horror-cthulhu-maybe
   ?o <- (odpowiedz "Well, maybe a little...")
   ?p <- (pytanie "Ever wanted to play on his side?" "Well, maybe a little..." "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Mansions of Madness")))

(defrule horror-cthulhu-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Ever wanted to play on his side?" "Well, maybe a little..." "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "An epic investigation or a geteway game?" "I want an epic!" "Geteway, please")))

(defrule horror-cthulhu-epic
   ?o <- (odpowiedz "I want an epic!")
   ?p <- (pytanie "An epic investigation or a geteway game?" "I want an epic!" "Geteway, please")
   =>
   (retract ?o ?p)
   (assert (wynik "Arkham Horror (I want an epic!)")))

(defrule horror-cthulhu-getaway
   ?o <- (odpowiedz "Geteway, please")
   ?p <- (pytanie "An epic investigation or a geteway game?" "I want an epic!" "Geteway, please")
   =>
   (retract ?o ?p)
   (assert (wynik "Elder Sign (Geteway, please)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HORROR: CLASSIC MOVIE MONSTERS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule horror-classic
   ?o <- (odpowiedz "Classic Movie Monsters")
   ?p <- (pytanie "What's your favorite monster?" "Zombies" "Cthulhu" "Classic Movie Monsters")
   =>
   (retract ?o ?p)
   (assert (pytanie "Card-based combat or a mystery?" "I'll crush you!" "I'd rather be a detective")))

(defrule horror-classic-crush
   ?o <- (odpowiedz "I'll crush you!")
   ?p <- (pytanie "Card-based combat or a mystery?" "I'll crush you!" "I'd rather be a detective")
   =>
   (retract ?o ?p)
   (assert (wynik "Nightfall")))

(defrule horror-classic-detective
   ?o <- (odpowiedz "I'd rather be a detective")
   ?p <- (pytanie "Card-based combat or a mystery?" "I'll crush you!" "I'd rather be a detective")
   =>
   (retract ?o ?p)
   (assert (wynik "Betrayal at House on the Hill")))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FANTASY ŚCIEŻKA DLA "A Strategy Game"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule strategy-theme-fantasy-override
   ?o <- (odpowiedz "Fantasy")
   ?p <- (pytanie "What kind of theme?" "Horror" "Science Fiction" "Fantasy")
   =>
   (retract ?o ?p)
   (assert (pytanie "Do you want a dungeon crawling adventure?" "Yes" "No")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DUNGEON CRAWLING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-dungeon-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Do you want a dungeon crawling adventure?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "A serious one?" "Yes" "No")))

(defrule fantasy-dungeon-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Do you want a dungeon crawling adventure?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "How about managing your own dungeon?" "Yes" "No")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; A SERIOUS ONE?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-serious-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "A serious one?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Munchkin")))

(defrule fantasy-serious-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "A serious one?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "How many players?" "Just the two of us" "More then two")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HOW MANY PLAYERS?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-2players
   ?o <- (odpowiedz "Just the two of us")
   ?p <- (pytanie "How many players?" "Just the two of us" "More then two")
   =>
   (retract ?o ?p)
   (assert (pytanie "Crush or out-maneuver your enemies?" "Fight" "Maneuver")))

(defrule fantasy-more-players
   ?o <- (odpowiedz "More then two")
   ?p <- (pytanie "How many players?" "Just the two of us" "More then two")
   =>
   (retract ?o ?p)
   (assert (pytanie "Cooperative or Competitive?" "Cooperative" "Competitive")))

;; Just two of us
(defrule fantasy-2players-fight
   ?o <- (odpowiedz "Fight")
   ?p <- (pytanie "Crush or out-maneuver your enemies?" "Fight" "Maneuver")
   =>
   (retract ?o ?p)
   (assert (wynik "Claustrophobia")))

(defrule fantasy-2players-maneuver
   ?o <- (odpowiedz "Maneuver")
   ?p <- (pytanie "Crush or out-maneuver your enemies?" "Fight" "Maneuver")
   =>
   (retract ?o ?p)
   (assert (wynik "Dungeon Twister 2: Prison")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MORE THAN TWO PLAYERS: Cooperative or Competitive?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-more-coop
   ?o <- (odpowiedz "Cooperative")
   ?p <- (pytanie "Cooperative or Competitive?" "Cooperative" "Competitive")
   =>
   (retract ?o ?p)
   (assert (pytanie "Playing with kids?" "Yes" "No")))

(defrule fantasy-more-competitive
   ?o <- (odpowiedz "Competitive")
   ?p <- (pytanie "Cooperative or Competitive?" "Cooperative" "Competitive")
   =>
   (retract ?o ?p)
   (assert (pytanie "Do you want a campaign?" "Yes" "Just one game")))

;; Cooperative branch
(defrule fantasy-kids-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Playing with kids?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Mice & Mystics")))

(defrule fantasy-kids-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Playing with kids?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Dungeons & Dragons: Legend of Drizzt")))

;; Competitive branch
(defrule fantasy-campaign-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Do you want a campaign?" "Yes" "Just one game")
   =>
   (retract ?o ?p)
   (assert (wynik "Descent: Journeys in the Dark 2nd Edition")))

(defrule fantasy-campaign-one
   ?o <- (odpowiedz "Just one game")
   ?p <- (pytanie "Do you want a campaign?" "Yes" "Just one game")
   =>
   (retract ?o ?p)
   (assert (wynik "Dungeon Run")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NO DUNGEON CRAWLING -> MANAGING YOUR OWN DUNGEON?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-manage-dungeon-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "How about managing your own dungeon?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Dungeon Lords")))

(defrule fantasy-manage-dungeon-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "How about managing your own dungeon?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Want the whole questing then, eh?" "Yes" "No")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WANT THE WHOLE QUESTING THEN, EH?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-quest-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Want the whole questing then, eh?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Competitive or Cooperative?" "Competitive" "Cooperative - if I can backstab" "Cooperative")))

(defrule fantasy-quest-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Want the whole questing then, eh?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Do you like Deck builders?" "Yes" "No")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; QUESTING: Competitive / Cooperative with backstab / Cooperative
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-quest-competitive
   ?o <- (odpowiedz "Competitive")
   ?p <- (pytanie "Competitive or Cooperative?" "Competitive" "Cooperative - if I can backstab" "Cooperative")
   =>
   (retract ?o ?p)
   (assert (pytanie "Mind getting trounced by random events?" "Yes, Strategy matters" "No, it's the experience that counts")))

(defrule fantasy-quest-backstab
   ?o <- (odpowiedz "Cooperative - if I can backstab")
   ?p <- (pytanie "Competitive or Cooperative?" "Competitive" "Cooperative - if I can backstab" "Cooperative")
   =>
   (retract ?o ?p)
   (assert (wynik "Shadows over Camelot")))

(defrule fantasy-quest-coop
   ?o <- (odpowiedz "Cooperative")
   ?p <- (pytanie "Competitive or Cooperative?" "Competitive" "Cooperative - if I can backstab" "Cooperative")
   =>
   (retract ?o ?p)
   (assert (pytanie "Board game or card game?" "Boards" "Cards")))

;; Competitive branch (questing)
(defrule fantasy-random-yes
   ?o <- (odpowiedz "Yes, Strategy matters")
   ?p <- (pytanie "Mind getting trounced by random events?" "Yes, Strategy matters" "No, it's the experience that counts")
   =>
   (retract ?o ?p)
   (assert (wynik "Mage Knight")))

(defrule fantasy-random-no
   ?o <- (odpowiedz "No, it's the experience that counts")
   ?p <- (pytanie "Mind getting trounced by random events?" "Yes, Strategy matters" "No, it's the experience that counts")
   =>
   (retract ?o ?p)
   (assert (pytanie "Is storytelling important?" "Yes" "Not as much as combat!")))

(defrule fantasy-story-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Is storytelling important?" "Yes" "Not as much as combat!")
   =>
   (retract ?o ?p)
   (assert (wynik "Tales of the Arabian Nights (Yes)")))

(defrule fantasy-story-no
   ?o <- (odpowiedz "Not as much as combat!")
   ?p <- (pytanie "Is storytelling important?" "Yes" "Not as much as combat!")
   =>
   (retract ?o ?p)
   (assert (wynik "Talisman (Not as much as combat!)")))

;; Cooperative (no backstab) branch (questing)
(defrule fantasy-board-or-cards-boards
   ?o <- (odpowiedz "Boards")
   ?p <- (pytanie "Board game or card game?" "Boards" "Cards")
   =>
   (retract ?o ?p)
   (assert (wynik "Defenders of the Realm (Boards)")))

(defrule fantasy-board-or-cards-cards
   ?o <- (odpowiedz "Cards")
   ?p <- (pytanie "Board game or card game?" "Boards" "Cards")
   =>
   (retract ?o ?p)
   (assert (wynik "Lord of the Rings Living Card Game (Cards)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NO QUESTING -> DECK BUILDERS?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-deck-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Do you like Deck builders?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Competitive Deck Builders?" "Yes" "No")))

(defrule fantasy-deck-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Do you like Deck builders?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Lord of the Rings fan?" "Yes" "No")))

;; Deck Builders
(defrule fantasy-competitive-deck-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Competitive Deck Builders?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Thunderstone: Advance (Competitive)")))

(defrule fantasy-competitive-deck-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Competitive Deck Builders?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "Rune Age (Cooperative)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NO DECK BUILDERS -> LORD OF THE RINGS FAN?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-lotr-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Lord of the Rings fan?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (wynik "War of the Ring")))

(defrule fantasy-lotr-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Lord of the Rings fan?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "How about castle defense?" "Sounds fun!" "Not for me")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CASTLE DEFENSE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-castle-yes
   ?o <- (odpowiedz "Sounds fun!")
   ?p <- (pytanie "How about castle defense?" "Sounds fun!" "Not for me")
   =>
   (retract ?o ?p)
   (assert (pytanie "Cooperative or Competitive?" "Competitive" "Cooperative")))

(defrule fantasy-castle-no
   ?o <- (odpowiedz "Not for me")
   ?p <- (pytanie "How about castle defense?" "Sounds fun!" "Not for me")
   =>
   (retract ?o ?p)
   (assert (pytanie "Conquest in a fantasy world?" "Yes" "No")))

;; Castle defense cooperative/competitive
(defrule fantasy-castle-comp
   ?o <- (odpowiedz "Competitive")
   ?p <- (pytanie "Cooperative or Competitive?" "Competitive" "Cooperative")
   =>
   (retract ?o ?p)
   (assert (wynik "Dragon Rampage (Competitive)")))

(defrule fantasy-castle-coop
   ?o <- (odpowiedz "Cooperative")
   ?p <- (pytanie "Cooperative or Competitive?" "Competitive" "Cooperative")
   =>
   (retract ?o ?p)
   (assert (wynik "Castle Panic (Cooperative)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONQUEST IN A FANTASY WORLD?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-conquest-yes
   ?o <- (odpowiedz "Yes")
   ?p <- (pytanie "Conquest in a fantasy world?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Epic?" "Yes! It's gotta be big" "No, keep it quick")))

(defrule fantasy-conquest-no
   ?o <- (odpowiedz "No")
   ?p <- (pytanie "Conquest in a fantasy world?" "Yes" "No")
   =>
   (retract ?o ?p)
   (assert (pytanie "Everyday life, eh?" "Running a business" "Relaxing after work" "Annihilating your business rivals")))

;; Epic?
(defrule fantasy-epic-yes
   ?o <- (odpowiedz "Yes! It's gotta be big")
   ?p <- (pytanie "Epic?" "Yes! It's gotta be big" "No, keep it quick")
   =>
   (retract ?o ?p)
   (assert (wynik "Runewars (Yes! It's gotta be big)")))

(defrule fantasy-epic-no
   ?o <- (odpowiedz "No, keep it quick")
   ?p <- (pytanie "Epic?" "Yes! It's gotta be big" "No, keep it quick")
   =>
   (retract ?o ?p)
   (assert (wynik "Small World (No, keep it quick)")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Everyday life options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fantasy-everyday-business
   ?o <- (odpowiedz "Running a business")
   ?p <- (pytanie "Everyday life, eh?" "Running a business" "Relaxing after work" "Annihilating your business rivals")
   =>
   (retract ?o ?p)
   (assert (wynik "Dungeon Petz (Running a business)")))

(defrule fantasy-everyday-relax
   ?o <- (odpowiedz "Relaxing after work")
   ?p <- (pytanie "Everyday life, eh?" "Running a business" "Relaxing after work" "Annihilating your business rivals")
   =>
   (retract ?o ?p)
   (assert (wynik "Red Dragon Inn (Relaxing after work)")))

(defrule fantasy-everyday-annihilate
   ?o <- (odpowiedz "Annihilating your business rivals")
   ?p <- (pytanie "Everyday life, eh?" "Running a business" "Relaxing after work" "Annihilating your business rivals")
   =>
   (retract ?o ?p)
   (assert (wynik "Mage Wars (Annihilating your business rivals)")))
