# YGOPro KJ

<p align="center">
	<img src="https://user-images.githubusercontent.com/18324297/82112901-d16dca80-9751-11ea-8004-cbe07d165384.png">
</p>

## How to play
1. Start `ygopro_vs_links.exe`.
2. Click on `Deck Management` to build your deck. Remember to add 1 _Kaijudo Rules_!<br>
3. At the start of the game, take 5 cards from the top of your deck without [looking](https://duelmasters.fandom.com/wiki/Look) at them and put them in a row in front of you face down. These face down cards are your [shields](https://kaijudo.wikia.com/wiki/Shield). (You can only have a maximum of 5 shields in YGOPro.) Then [draw](https://kaijudo.fandom.com/wiki/Draw) 5 cards. There is no limit to the number of cards you can have in your hand.
4. During your Beginning Phase, [untap](https://kaijudo.fandom.com/wiki/Tap_(Untap)) all your [tapped](https://kaijudo.fandom.com/wiki/Tap_(Untap)) creatures in the [battle zone](https://kaijudo.fandom.com/wiki/Battle_Zone) and tapped cards in your [mana zone](https://kaijudo.fandom.com/wiki/Mana_Zone). Then draw 1 card. The person who plays first skips drawing a card on their first turn.
5. During your Mana Phase, you can put a card from your hand into your mana zone. There is no limit to the number of cards you can have in your mana zone.
6. During your Main Phase, you can [play](https://duelmasters.fandom.com/wiki/Play) as many [creatures](https://kaijudo.fandom.com/wiki/Creature) and [spells](https://kaijudo.fandom.com/wiki/Shield) as your mana zone can afford. You can play any card in any order. (You can only have a maximum of 6 creatures in YGOPro.)
7. During your Attack Phase, you can [attack](https://kaijudo.fandom.com/wiki/Attack) with your creatures in the battle zone by tapping them and declaring what you want to attack. You cannot attack with creatures you just put into the battle zone this turn because they have [summoning sickness](https://kaijudo.fandom.com/wiki/Summon). There is no limit to the number of times a creature can attack each turn as long as it is untapped and you can tap it.
8. During your End Phase, resolve any [abilities](https://kaijudo.fandom.com/wiki/Card_Abilities) that trigger "at the end of your turn". Then your turn ends.

**Important:**
1. Online play is not supported.
2. At least 1 player must have _Kaijudo Rules_ in their deck, otherwise the mod will not function properly.
3. YGOPro does not allow you to look at a tapped card in your opponent's mana zone that was put there from a [Private Zone](https://duelmasters.fandom.com/wiki/Private_Zone). You will be able to look at it when it untaps, or is put into a [Public Zone](https://duelmasters.fandom.com/wiki/Public_Zone).

## How to win
1. Attack your opponent with a creature that is not [blocked](https://kaijudo.fandom.com/wiki/Block) or removed when they have no shields left.
2. When your opponent has no cards left in their deck or they would draw their last card.
3. [Some cards](https://kaijudo.fandom.com/wiki/The_Mystic_of_Light) will enable you to win the game via their effects.

## Extra information
<details>
<summary>OT (OCG/TCG)</summary>

- `0x1	OCG` = **N/A**
- `0x2	TCG` = Official card
- `0x3	OCG+TCG` = **N/A**
- `0x4	Anime/Custom` = Unofficial card
</details>
<details>
<summary>Card Type</summary>

- `0x21	Monster+Effect` = Creature
- `0x1021	Monster+Effect+Tuner` = Creature that has [no abilities](https://duelmasters.wikia.com/wiki/Vanilla)
- `0x2000021	Monster+Effect+Special Summon` = [Evolution Creature](https://kaijudo.fandom.com/wiki/Evolution_Creature)
	- `Attribute` = [Civilization](https://kaijudo.fandom.com/wiki/Civilization)
	- `Level` = [Mana Cost](https://kaijudo.fandom.com/wiki/Level)
	- `ATK` = `DEF` = [Power](https://kaijudo.fandom.com/wiki/Power)
- `0x3	Monster+Spell` = Spell
	- `Attribute` = Civilization
	- `Level` = Mana Cost
- `0x800	Gemini` = [Multi-civilization](https://kaijudo.fandom.com/wiki/Multi-civilization) card
</details>
<details>
<summary>Attribute</summary>

- `0x1	EARTH` = [Light Civilization](https://kaijudo.fandom.com/wiki/Light_Civilization)
- `0x2	WATER` = [Water Civilization](https://kaijudo.fandom.com/wiki/Water_Civilization)
- `0x4	FIRE` = [Darkness Civilization](https://kaijudo.fandom.com/wiki/Darkness_Civilization)
- `0x8	WIND` = [Fire Civilization](https://kaijudo.fandom.com/wiki/Fire_Civilization)
- `0x10	LIGHT` = [Nature Civilization](https://kaijudo.fandom.com/wiki/Nature_Civilization)
</details>
<details>
<summary>Setcode</summary>

- Refer to `!setname` in `strings.conf`.
</details>
<details>
<summary>Location</summary>

- `0x4	Monster Zone` = Battle Zone
- `0x8	Spell & Trap Zone` = Shield Zone
- `0x10	Graveyard` = Mana Zone (untapped cards)
- `0x20	Banished` = Mana Zone (tapped cards) (text color = blue)
- `0x20	Banished` = [Discard Pile](https://kaijudo.fandom.com/wiki/Discard_Pile) (text color = black)
</details>
<details>
<summary>Phase</summary>

1. `EVENT_PREDRAW` = Beginning Phase = Untap all your tapped cards.
2. `PHASE_DRAW` = Beginning Phase = Draw 1 card from your deck.
3. `PHASE_STANDBY` = Mana Phase = You may put a card from your hand into your mana zone.
4. `PHASE_MAIN1` = Main Phase = You may summon creatures or cast spells by paying the appropriate costs.
5. `PHASE_BATTLE` = Attack Phase = You may attack with creatures.
6. `PHASE_MAIN2` = **N/A**
7. `PHASE_END` = End Phase = "At the end of your turn" or "at the end of each turn" abilities happen now, then the turn ends.
</details>
<details>
<summary>Category</summary>

- `0x1	Destroy Spell/Trap` = Decrease the number of cards in the opponent's shield zone; "Breaker"
- `0x2	Destroy Monster` = Banish a creature
- `0x4	Banish Card` = Put a card into the discard pile; discard a card from a player's hand
- `0x8	Send to Graveyard` = Put a card into the mana zone
- `0x10	Return to Hand` = Return a card from the battle zone, shield zone, mana zone or discard pile to a player's hand
- `0x20	Return to Deck` = Put a card into a player's deck
- `0x40	Destroy Hand` = Decrease the opponent's hand size
- `0x80	Destroy Deck` = Decrease the opponent's deck size
- `0x100	Increase Draw` = Draw a card from the deck
- `0x200	Search Deck` = Look at a player's deck
- `0x400	GY to Hand/Field` = ～Reserved～
- `0x800	Change Battle Position` = Untap or tap a card
- `0x1000	Get Control` = Increase or decrease the cost required for playing a card; change a card's mana cost (level)
- `0x2000	Increase/Decrease ATK/DEF` = Increase or decrease a creature's power
- `0x4000	Piercing` = No summoning sickness
- `0x8000	Attack Multiple Times` = Can attack untapped creatures
- `0x10000	Limit Attack` = Prevent a creature from attacking; change a creature's attack target
- `0x20000	Direct Attack` = Attacks each turn if able; force a creature to battle another creature
- `0x40000	Special Summon` = Creature with "Shield blast"; put a card into the battle zone
- `0x80000	Token` = ～Reserved～
- `0x100000	Type-related` = Lists "creature type" or a particular race (creature type) in the card's text
- `0x200000	Attribute-related` = Lists "civilization" or a particular civilization in the card's text
- `0x400000	Reduce LP` = Decrease the number of cards in the opponent's mana zone
- `0x800000	Increase LP` = Increase the number of cards in the shield zone
- `0x1000000	Cannot Be Destroyed` = Prevent a card from being banished
- `0x2000000	Cannot Be Targeted` = Prevent a creature from being blocked or targeted with an ability
- `0x4000000	Counter` = Prevent the opponent from casting spells
- `0x8000000	Gamble` = ～Reserved～
- `0x10000000	Fusion` = ～Reserved～
- `0x20000000	Synchro` = ～Reserved～
- `0x40000000	Xyz` = Evolution creature; lists "evolution" in the card's text
- `0x80000000	Negate Effect` = ～Reserved～
- [Category list](https://duelmasters.fandom.com/wiki/Category:Advanced_Gameplay)
</details>
<details>
<summary>Card Search</summary>

You can search for the following specific card information in YGOPro:
- Card Ability: Use the `No Ability` tab for creatures that have no abilities
- Card Type: Use the `Type` tab
- Civilization: Use the `Civ` tab
- Evolution Creature: Use the `Evolution` tab
- Mana Cost (Level): Use the `Cost` tab
- Multicolored (Multi-civilization): Use the `Multicolor` tab
- Power: Use the `Power` tab
- Race (Creature Type): **N/A**
- Region-exclusive cards: Use the `Limit` tab
- You can also search for cards whose abilities have been modified for YGOPro by typing `YGOPro`.
</details>
<details>
<summary>Differences Between Kaijudo and Duel Masters</summary>

[**TCG vs. OCG**](https://kaijudo.wikia.com/wiki/Trading_Card_Game)
- Kaijudo is TCG-only.
	- `Cards from the Duel Masters TCG are not compatible.`
- Duel Masters is TCG & OCG. OCG-only for later sets.
	- `Cards from the Kaijudo TCG are not compatible.`

[**Deck**](https://kaijudo.wikia.com/wiki/Deck)
- Kaijudo: `A deck must contain a minimum of 40 cards, and may contain a maximum of 3 copies of any 1 card.`
- Duel Masters: `A deck in the OCG is limited to exactly 40 cards, and can contain up to 4 copies of any card.`

[**Mana**](https://kaijudo.wikia.com/wiki/Mana)
- Kaijudo: `You must have at least 1 of a card's civilization in your mana zone to use it.`
	- `However, it does not need to be tapped to pay for that card.`
- Duel Masters: `You must tap cards in your mana zone until the amount reaches the mana cost number on the card.`
	- `However, the mana tapped must include at least 1 mana from the same civilization as the card you are about to use.`

**Terminology**
- Kaijudo: `Banish`; Duel Masters: `Destroy`
- Kaijudo: `Target`; Duel Masters: `Choose`
- Kaijudo: `Discard Pile`; Duel Masters: `Graveyard`
- Kaijudo: `Level`; Duel Masters: `Mana Cost`
- Kaijudo: `Multi-civilization`; Duel Masters: `Multicolored`
- Kaijudo: `Shield Blast`; Duel Masters: `Shield Trigger`
</details>
