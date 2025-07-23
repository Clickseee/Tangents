--- @meta

--- Repositions and rescales UI elements.
--- Used while entering main menu, or entering a run
function set_screen_positions() end

--- Sets number of chips in the run, with easing.
--- Used while cashing out.
--- @param mod number Number of chips
function ease_chips(mod) end

--- Sets number of dollars in the run, with easing.
--- Used if the dollar count has changed (e.g. cashing out, buying item, etc.)
--- @param mod number Dollar changes
function ease_dollars(mod, instant) end

--- Sets number of discards in a round, with easing.
--- Used on discard.
--- @param mod number Discard changes. 1 to add discard. -1 to reduce discard.
--- @param instant boolean? If true, instantly adds discard
--- @param silent boolean? If true, does not play sound
function ease_discard(mod, instant, silent) end

--- Sets number of hands remaining in a round, with easing.
--- Used on play hand.
--- @param mod number Hand changes. 1 to add hand. -1 to reduce hand.
--- @param instant boolean? If true, instantly adds hand
function ease_hands_played(mod, instant) end

--- Sets number of ante in the run, with easing.
--- Used when a boss is defeated, or when Hieroglyph or Petroglyph voucher is used.
--- @param mod number Ante changes. 1 to add ante, -1 to reduce ante.
function ease_ante(mod) end

--- Sets number of round in the run, with easing.
--- Used after any blind is defeated.
--- @param mod number Round changes. 1 to add round, -1 to reduce round.
function ease_round(mod) end

---Eases value in a table.
---@param ref_table table
---@param ref_value any
---@param mod number Changes in the value
---@param floored boolean? If true, Floors the value
---@param timer_type balatro.TimerType? Timer type to use. Defaults to `TOTAL` if unpaused, `REAL` if paused
---@param not_blockable boolean? Allows blocking the easing. By default, the event is blockable
---@param delay number? Delay before the value starts to ease, defaults to 0.3
---@param ease_type balatro.Event.EaseType? Easing type to use, defaults to 'lerp'
function ease_value(ref_table, ref_value, mod, floored, timer_type, not_blockable, delay, ease_type) end

--- @class EaseBgColArgs
--- @field new_colour? ColorHexRgb
--- @field special_colour? ColorHexRgb
--- @field tertiary_colour? ColorHexRgb
--- @field contrast? number

--- Eases background color.
--- @param args EaseBgColArgs
function ease_background_colour(args) end

--- Eases color. Old color is modified.
--- @param old_colour ColorHex
--- @param new_colour ColorHex
--- @param delay? number
function ease_colour(old_colour, new_colour, delay) end

--- Sets background type, depending on the stage
--- @param state balatro.Game.StateEnum
--- @param blind_override? string
function ease_background_colour_blind(state, blind_override) end

--- Adds an event with specified delay.
--- This does not block the current thread, but rather the event queue.
--- @param time number? Delay time, defaults to 1
--- @param queue balatro.EventManager.QueueType? Queue type
function delay(time, queue) end

--- Adds a joker to a playing card.
--- @param joker string Card key, must be a key valid from `balatro.ItemCenters`. If a card is type of consumable, it will be inserted into consumable slot instead
--- @param edition SpecialEdition? Joker edition
--- @param silent boolean? Silently adds joker
--- @param eternal boolean? Sets the joker type to eternal (can't be sold)
--- @see balatro.ItemCenters
--- @return balatro.Card
function add_joker(joker, edition, silent, eternal) end

--- Draws a card to a card area
---@param from balatro.CardArea
---@param to balatro.CardArea
---@param percent number? Volume pitch
---@param dir 'up' | 'down'? Card direction. Currently only affects pitch percentage.
---@param sort boolean? Sorts the card area
---@param card balatro.Card? Card to draw
---@param delay number?
---@param mute boolean? Mutes the card being added
---@param stay_flipped boolean?
---@param vol number? Sound volume
---@param discarded_only boolean?
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only) end

--- Highlights a card, while also plays sound
--- @param card balatro.Card
--- @param percent number? Volume pitch
--- @param dir 'up' | 'down'? Card direction. Currently only affects pitch percentage
function highlight_card(card, percent, dir) end

--- Sets status text display in a run.
--- Used when a card is not allowed to play during boss blind
--- @param text string Status text
--- @param silent boolean? If true, don't play sound
--- @param delay? number
function play_area_status_text(text, silent, delay) end

--- Level up poker hand with animation
--- @param card? balatro.Moveable|balatro.Tag Planet card to cause juice up effect
--- @param hand PokerHand Poker hand to level up
--- @param instant boolean? Instantly levels up poker hand
--- @param amount number? How much level up, defaults to 1
function level_up_hand(card, hand, instant, amount) end

--- @class balatro.UpdateHandConfigArg
--- @field delay? number
--- @field immediate? boolean
--- @field nopulse? boolean
--- @field sound? string
--- @field pitch? number
--- @field volume? number
--- @field modded? boolean

--- @class balatroUpdateHandValsArg
--- @field chips? number | string
--- @field mult? number | string
--- @field handname? string
--- @field chip_total? number
--- @field level? number | string

--- Updates poker hand text (poker hand name, chips, mults, total chips, hand level)
--- @param config balatro.UpdateHandConfigArg
--- @param vals balatroUpdateHandValsArg
function update_hand_text(config, vals) end

--- @class balatro.EvalCardContext
--- @field cardarea balatro.CardArea
--- @field full_hand balatro.Card[]
--- @field poker_hands balatro.PokerHandsEvalInfo
--- @field scoring_hand balatro.Card[]
--- @field scoring_name PokerHand
--- Calculates seal effects.
--- `cardarea` is `G.hand` or `G.play`.
--- @field repetition_only? boolean
--- Calculates edition effect. `jokers` will be `balatro.Card.CalcEditionRet`.
--- `cardarea` is `G.jokers`
--- @field edition? boolean
--- @field card_effects? table
local a = {
    --- @deprecated Redundant
    --- @type PokerHand
    poker_hand = nil
}

--- @class balatro.EvalCardContext.Return
--- @field seals? balatro.Card.CalcSealRet Only when `repetition_only` is true and given card has red seal
--- @field chips? number
--- @field mult? number
--- @field x_mult? number
--- @field p_dollars? number
--- @field h_mult? number
--- @field h_x_mult? number
--- @field h_dollars? number
--- @field jokers? balatro.Card.CalcJokerRet | balatro.Card.CalcEditionRet
--- @field edition? balatro.Card.CalcEditionRet

--- Evaluates a card
--- @param card balatro.Card
--- @param context balatro.EvalCardContext | balatro.Card.CalculateJokerContext
--- @return balatro.EvalCardContext.Return
function eval_card(card, context) end

--- Sets alerts, used for newly unlocked jokers, tarots, etc.
function set_alerts() end

--- Displays main menu UI
function set_main_menu_UI() end

--- @alias balatro.CardEvalStatysType "debuff" | "chips" | "mult" | "x_mult" | "h_mult" | "h_x_mult" | "dollars" | "swap" | "extra" | "jokers"

--- @class balatro.CardEvalStatusExtra
--- @field colour? ColorHex
--- @field focus? balatro.Card
--- @field instant? boolean
--- @field no_juice? boolean
--- @field playing_cards_created? balatro.Card[]

--- @class balatro.CardEvalStatusExtra.Extra
--- @field edition? any
--- @field chip_mod? number
--- @field mult_mod? number
--- @field Xmult_mod? number
--- @field swap? boolean
--- @field delay? number
--- @field message? string

--- Creates card eval effect,
--- used during card evaluation to create scoring effects (+chips, +mult, x mult, etc.)
--- @param card balatro.Card
--- @param eval_type balatro.CardEvalStatysType
--- @param amt? number
--- @param percent? number Pitch increase
--- @param dir? 'down' Negates percent parameter to `1-percent`
--- @param extra? balatro.CardEvalStatusExtra | balatro.CardEvalStatusExtra.Extra
function card_eval_status_text(card, eval_type, amt, percent, dir, extra) end

--- @class balatro.AddRoundEvalRowParams
--- - `blind1` sets the main reward from given blind
--- - `bottom` creates cash out button
--- @field name "blind1" | "bottom" | string
--- True if saved by Mr. Bones. Should only be used when `name` is `blind1`
--- @field saved? boolean
--- @field dollars? number
--- @field disp? number
--- @field bonus? boolean
--- @field pitch? number
--- @field card? balatro.Card

--- Adds round evaluation row,
--- used to add money sources from cashing out
--- @param config balatro.AddRoundEvalRowParams
function add_round_eval_row(config) end

--- Changes how much cards is available at the shop
--- @param mod number Number of adds to add / delete
function change_shop_size(mod) end

--- Adds juice up card effect.
--- Can be seen when DNA, Loyalty Card Joker, etc. is active.
--- This makes the card pulses.
--- @param card balatro.Card
function juice_card(card) end

function update_canvas_juice(dt) end

--- Juices the card until the function returns false.
--- Can be seen when DNA, Loyalty Card Joker, etc. is active.
--- The function must return false to stop the juice effect.
--- @param card balatro.Card
--- @param eval_func fun(): boolean
--- @param first? boolean
--- @param delay? number
function juice_card_until(card, eval_func, first, delay) end

--- @alias CheckUnlockType 'win_challenge' | 'career_stat' | 'ante_up' | 'win' | 'win_stake' | 'money' | 'hand' | 'shatter' | 'run_redeem' | 'upgrade_hand' | 'chip_score' | 'modify_deck' | 'spawn_legendary' | 'discover_amount' | 'career_stat' | 'hand' | 'min_hand_size' | 'interest_streak' | 'run_card_replays' | 'play_all_hearts' | 'run_redeem' | 'have_edition' | 'double_gold' | 'continue_game' | 'blank_redeems' | 'modify_deck' | 'discover_amount' | 'win_deck' | 'win_stake' | 'discover_planets' | 'blind_discoveries' | 'modify_jokers' | 'money' | 'round_win' | 'ante_up' | 'hand_contents' | 'discard_custom' | 'win_no_hand' | 'win_custom' | 'win' | 'chip_score'
--- @class CheckUnlockArgs
--- @field type CheckUnlockType
--- @field statname? 'c_cards_played' | 'c_cards_discarded' Used for type `career_stat`
--- @field ante? number Required for type `ante_up`
--- @field handname? PokerHand used for type `hand`
--- @field scoring_hand? table used for type `hand`
--- @field disp_text? string Used for type `hand`, checks for Royal Flush
--- @field shattered? table Required for  type `shatter`
--- @field level? number Required for  type `upgrade_hand`
--- @field chips? number Required for  type `chip_score`
--- @field amount? number Used for  type `discover_amount`
--- @field tarot_count? number Used for  type `discover_amount`
--- @field planet_count? number Used for  type `discover_amount`
--- @field cards? balatro.Card[] Required for type `hand_contents`, `discard_custom`

--- Checks for achievements to unlock.
--- Immediately tries to unlock the achievement if still locked.
--- Does not work if the game is currently seeded or in challenge.
--- @param args CheckUnlockArgs
--- @see unlock_achievement
--- @see unlock_card
function check_for_unlock(args) end

--- Unlocks a card. Does not work if the game is currently seeded or in challenge.
--- @param card balatro.Item.Card
function unlock_card(card) end

--- Initializes `G.ACHIEVEMENTS`
--- @see balatro.Game.AchievementList
function fetch_achievements() end

--- Unlocks an achievement. Does not work if unlock all is used on the profile
--- @param achievement_name string Achievement name. Must be a key valid from `balatro.Settings.AchievementEarned`
--- @see balatro.Settings.AchievementEarned
function unlock_achievement(achievement_name) end

--- Notifies player for an achievement
--- @param _achievement string Achievement key, must be a key valid from `balatro.ItemCenters` or `balatro.Settings.AchievementEarned`
--- @param _type 'Joker' | 'Voucher' | 'Back' | 'achievement' | string Unlock type
--- @see balatro.ItemCenters
--- @see balatro.Settings.AchievementEarned
function notify_alert(_achievement, _type) end

--- Increases Steam statistics. Currently only used in demo play.
--- @param stat_name string
function inc_steam_stat(stat_name) end

--- Notifies player for newly unlocked cards
function unlock_notify() end

--- Creates overlay for newly unlocked card
--- @param key string Card key, must be a key valid from `balatro.ItemCenters`
function create_unlock_overlay(key) end

--- Makes a card discovered, used when the undiscovered card is bought in the shop. Does not work if the game is currently seeded or in challenge.
--- @param card? balatro.Item.Card
function discover_card(card) end

--- Gets data possible from `balatro.ItemCenters` from given name
--- @param _name string Name
--- @return table
--- @see balatro.ItemCenters
function get_deck_from_name(_name) end

--- Gets next voucher
--- @param _from_tag boolean? If true, pool key used will be `Voucher_fromtag` instead of the ones returned from `get_current_pool`
--- @return balatro.Item.Voucher
function get_next_voucher_key(_from_tag) end

--- Gets next tag. If `G.FORCE_TAG` exists, it will be returned instead.
--- @param append string? Seed to append
--- @return string
function get_next_tag_key(append) end

--- Creates a playing card
--- @param card_init { front: balatro.Item.Card?, center: balatro.Item.EnhancedCard | balatro.Item.Default? }? -
--- `front` is the playing card to add, e.g. 9 of Spades, King of Hearts, etc. Can be obtained from `G.P_CARDS`\
--- `center` is the enhancement effect, e.g. glass, stone, etc. Can also be c_base for no effect. `G.P_CENTERS.m_*` or `G.P_CENTER_POOLS.Enhanced`
--- @param area balatro.CardArea The card area where the card will be added
--- @param skip_materialize? boolean
--- @param silent? boolean
--- @param colours? ColorHex
--- @return balatro.Card
--- @see balatro.ItemList.Centers.EnhancedCard
function create_playing_card(card_init, area, skip_materialize, silent, colours) end

--- Gets next random booster pack.
--- The first booster pack will always be a buffoon pack, if not banned.
--- @param _key string Seed key to use for `pseudoseed`, defaults to `pack_generic`. Ante count is appended.
--- @param _type balatro.Item.BoosterKind? Booster pack type.
--- @return balatro.Item.Booster
function get_pack(_key, _type) end

--- gets current possible keys for given type.
--- @param _type balatro.CenterPoolsType | string Pool type, must be a valid key from `G.P_CENTER_POOLS`
--- @param _rarity number? Joker rarity. 0.95 < rarity: Rare; 0.7 < rarity <= 0.95: Uncommon; rarity <= 0.7: Common
--- @param _legendary boolean? Pools legendary joker. Rarity is forcibly set to legendary.
--- @param _append string? Seed to append to `pseudorandom` function.
--- @return string[] keys Pool keys, may contain `UNAVAILABLE`
--- @return string poolKey Pool key
---
--- Type info:
--- - `Enhanced`: Returns all keys from enhanced
--- - `Tag`: Some tag is excluded until related item is discovered and an ante is reached, e.g.
---     Rare tag requires Blueprint joker discovered,
---     Negative tag available at ante 2 or higher
--- - `Voucher`: Locked, currently available, used vouchers are not included
--- - `Planet`: Unplayed hidden poker hands are not included (Flush house, Flush five, Five of a Kind)
--- - `Spectral`: Block Hole and The Soul is always excluded
--- - Anything else (also applies to planet):
---     - Does not include if repeated occurence unless Showman joker is present
---     - Does not include if locked unless legendary is forcibly set
---     - Does not include if gated behind an enhanced card and playing card does not include that card
---     - Some items require pool flags to be set, e.g. Gros Michel/Cavendish (Banana)
---
--- Default pool if pool size is 0:
--- - `Tarot`: Strength (Increases rank of up to 2 cards by 1)
--- - `Planet`: Pluto (+High card)
--- - `Spectral`: Incantation (destroy 1 random, add 4 random numbered card)
--- - `Joker`: Joker (+4 mult)
--- - `Voucher`: Blank
--- - `Tag`: Handy ($1 / hand played)
function get_current_pool(_type, _rarity, _legendary, _append) end

--- Gets next edition.
--- @param key string? Seed key to use, defaults to `edition_generic`
--- @param mod number? Chance to get the edition. Unused if `guaranteed` is true. Defaults to 1
--- @param no_neg boolean? Prevents rolling a negative
--- @param guaranteed boolean? Guarantees an edition is rolled
--- @return table
---
--- Probabilities (1 to 4):
--- 1. Negative: `R < 0.3% * mod` (7.5% on guarantee)
--- 2. Polychrome: `R < 0.6 * M` (7.5% on guarantee)
--- 3. Holo: `R < 2% * M` (35% on guarantee)
--- 4. Foil: `R < 4% * M` (50% on guarantee)
---
--- `R` is random. `M` is `G.GAME.edition_rate * mod`. \
--- `G.GAME.edition_rate` can be increassed ingame by using Home and Glow Up voucher.
function poll_edition(key, mod, no_neg, guaranteed) end

--- Creates a playing card.
--- @param _type balatro.CenterPoolsType Card type
--- @param area balatro.CardArea? Card area where the card will be added to. Defaults to `G.jokers`
--- @param legendary boolean? If true, sets joker to legendary
--- @param _rarity number? Joker rarity 0.95 < rarity: Rare; 0.7 < rarity <= 0.95: Uncommon; rarity <= 0.7: Common
--- @param skip_materialize? boolean
--- @param soulable boolean? If `true`, Spectral card `The Soul` for type Tarot/Spectral/Tarot_Planet and `Black Hole` for type Planet/Spectral may appear. ``forced_key` must not be set
--- @param forced_key string? Card key, must be a key valid from `balatro.ItemCenters`
--- @param key_append string? Seed to append on `get_current_pool`
--- @return balatro.Card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append) end

--- Copies card
--- @param other balatro.Card Card to copy
--- @param new_card balatro.Card? Target card
--- @param card_scale? number
--- @param playing_card? number
--- @param strip_edition boolean? Removes edition from the card
--- @return balatro.Card
function copy_card(other, new_card, card_scale, playing_card, strip_edition) end

--- UNDOCUMENTED
function tutorial_info(args) end

--- Calculates next reroll cost.
--- This increases `G.GAME.current_round.reroll_cost` by `G.GAME.current_round.reroll_cost_increase`.
--- If increment is not skipped, `G.GAME.current_round.reroll_cost_increase` increments by 1.\
--- If `G.GAME.current_round.free_rerolls` is greater than 0, then the cost is set to 0. without incrementing reroll cost.
function calculate_reroll_cost(skip_increment) end

--- Resets The Idol joker.
--- The Idol joker configuration is located at `G.GAME.current_round.idol_card`.
--- Calling this function will select random card in the deck (excluding Stone Card). If no card is valid, Ace of Spades is used.
---
--- `Each played [rank] of [suit] gives X2 Mult when scored. Card changes every round`
function reset_idol_card() end

--- Resets Main-In Rebate joker.
--- Main In-Rebate joker configuration is located at `G.GAME.current_round.mail_card`.
--- Calling this function will select random card suit in the deck (excluding Stone Card). If no card is valid, Ace is used.
---
---`Earn $5 for each discarded [rank], rank changes every round`
function reset_mail_rank() end

--- Resets Ancient joker.
--- Ancient joker configuration is located at `G.GAME.current_round.ancient_card`.
--- Calling this function will select random suit (excluding current ancient joker suit).
---
--- `Each played card with [suit] gives X1.5 Mult when scored, suit changes at end of round`
function reset_ancient_card() end

--- Resets Castle joker.
--- Castle joker configuration is located at `G.GAME.current_round.castle_card`.
--- Calling this function will select random card in the deck (excluding Stone Card). If no card is valid, Ace of Spades is used.
---
--- `This Joker gains +3 Chips per discarded [suit] card, suit changes every round (Currently +0 Chips)`
function reset_castle_card() end

--- Resets blinds states `G.GAME.round_resets.blind_states`.
--- Used when a boss is defeated. or when a new run is started.
function reset_blinds() end

--- Gets new boss.
--- - If prescribed bosses existss in the ante, that boss is used.
--- - If `FORCE_BOSS` exists, that boss is used.
--- - Showdown bosses can only appear every winning antes after ante 1.
--- - All bosses will have equal chance of occuring
--- @return balatro.Item.Blind
function get_new_boss() end

--- Gets type color for card UI.
--- @param _c balatro.Center Card center
function get_type_colour(_c, card) end

--- Creates an interface when the card is hovered over
--- @param _c balatro.Center Card center
--- @param full_UI_table? table
--- @param specific_vars? unknown
--- @param card_type? 'Locked' | 'Undiscovered' | 'Default' | 'Enhanced' | 'Booster'
--- @param badges? CardBadges[]
--- @param hide_desc boolean? Replaces card description with undiscovered
--- @param main_start? unknown
--- @param main_end? unknown
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end) end

--- @alias CardBadges 'foil' | 'holographic'  | 'polychrome'  | 'negative'  | 'negative_consumable'  | 'gold_seal'  | 'blue_seal'  | 'red_seal'  | 'purple_seal'  | 'eternal'  | 'perishable'  | 'rental'  | 'pinned_left'