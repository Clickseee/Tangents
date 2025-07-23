--- @meta

---Updates all display information for all displays for a given screenmode. Returns the key for the resolution option cycle
---@param screenmode string optional arg for one of 'Windowed', 'Fullscreen', or 'Borderless'
---@param display number optional arg to match fullscreen resolution with only the current display
function GET_DISPLAYINFO(screenmode, display) end

function timer_checkpoint(label, type, reset) end

--- Renders loading screen
--- @param _label string
---@param _next string
---@param progress number
function boot_timer(_label, _next, progress) end

--- Removes all properties from a table
--- @generic T
--- @param t `T` Table to empty
--- @return T
function EMPTY(t) end

--- Interpolates 2 value
--- @param per number Percentage from min to max
--- @param max number
--- @param min number
function interp(per, max, min) end

--- Recursively all children in a node
--- @param t table<string, balatro.Node>
function remove_all(t) end

--- Gets distance between 2 vectors (x and y)
--- @param trans1 Position
--- @param trans2 Position
--- @param mid boolean? If true, w and h is also compared
--- @return number
function Vector_Dist(trans1, trans2, mid) end

--- Gets length of a vector
--- @param trans1 Position
--- @return number
function Vector_Len(trans1) end

--- Subtracts both vector
--- @param trans1 Position
--- @param trans2 Position
--- @return number
function Vector_Sub(trans1, trans2) end

--- Gets index from a value in an array
--- @generic T
--- @param t `T`[]
--- @param val T
--- @return number?
function get_index(t, val) end

--- Gets number of elements in a table
--- @param t table
--- @return number
function table_length(t) end

--- Normalize an array to remove nil gaps from the table
--- @generic T
--- @param t table<number, `T`>
--- @return T[]
function remove_nils(t) end

--- Swaps values in table t with key i and key j
--- @param t table
--- @param i any
--- @param j any
function SWAP(t, i, j) end

--- Pseudo-random shuffle list with specified speed.
--- Uses `math.randomseed(seed)` to set randomness
--- @param list table
--- @param seed integer
function pseudoshuffle(list, seed) end

--- Generates random starting seed string with length 8.
--- @return string
function generate_starting_seed() end

--- Gets first legendary joker from given key seed.
--- Currently used for gold stake to get the first legendary joker that is not win at gold stake.
---
--- Uses `pseudorandom_element` and `pseudoseed` with key as `Joker4`.
--- @param _key string? String seed
--- @return string key Joker key
function get_first_legendary(_key) end

--- Gets pseudo-random element from given seed.
--- Uses `math.randomseed(seed)` to set randomness
--- @generic K, V
--- @param _t table<K, V>
--- @param seed? number
--- @return V value
--- @return K key
function pseudorandom_element(_t, seed) end

--- Generates pseudo-random string.
--- Uses `math.randomseed(seed)` to set randomness
--- @param length number
--- @param seed number
--- @return string
function random_string(length, seed) end

--- Generates a pseudo-random number from given string.
--- @param str string
--- @return number 0 - 1
function pseudohash(str) end

--- Generates a pseudo-random next seed value from given key. \
--- This changes the next value from given key, e.g. calling `pseudoseed('a')` will give a different value for the next call `pseudoseed('a')`. \
--- This does not affect for different key, e.g. `pseudoseed('a')` does not affect `pseudoseed('b')`. \
--- This function may be affected by `G.GAME.pseudorandom.seed` and `G.GAME.pseudorandom.hashed_seed`.
--- @param key string Seed key to use. If set to `seed`, this will return `math.random()`.
--- @param predict_seed string? If this is not nil, then it will try to predict the first value for `pseudoseed(key)` with seed set as `predict_seed`. This will not affect the next value for given key.
--- @return number 0 - 1
--- @see balatro.Game.Current.Pseudorandom
function pseudoseed(key, predict_seed) end

--- Generates a pseudo-random number between min and max.
--- Uses `math.randomseed(seed)` to set randomness. \
--- If min or max is not specified, returns float between 0 to 1.
--- Otherwise, returns integer between min (inc) and max (inc)
--- @param seed string | number Seed to use. If string is passed, it will be converted to number through `pseudoseed`.
--- @param min number? Inclusive
--- @param max number? Inclusive
--- @return integer
function pseudorandom(seed, min, max) end

--- Stringifies table to human-readable.
--- @param tbl table
--- @param indent number? Number of space indentation
--- @return string
function tprint(tbl, indent) end

--- Compares both `order`
--- @param e1 {order: number}
--- @param e2 {order: number}
--- @return boolean
function sortingFunction(e1, e2) end

--- Converts hexadecimal string to number
--- @param hex string Hexadecimal string, in form of (rrggbbaa). Can contain only (rrggbb).
--- @return ColorHex
function HEX(hex) end

--- Gets main blind color for given blind
--- @param blind BlindType | string Blind type. Can also be blind key for `G.P_BLINDS`
--- @return ColorHex
function get_blind_main_colour(blind) end

--- Evaluates poker hand to get possible match
--- @param hand balatro.Card[]
--- @return balatro.PokerHandsEvalInfo
function evaluate_poker_hand(hand) end

--- Gets flush hand from given hand.
--- Hand size myst be at most 5, and atleast 5 (or 4 with four fingers)
--- @param hand balatro.Card[]
--- @return balatro.Card[][]. Flush hand
function get_flush(hand) end

--- Gets straight hand from given hand.
--- Hand size myst be at most 5, and atleast 5 (or 4 with four fingers)
--- @param hand balatro.Card[]
--- @return balatro.Card[][]. Straight hand
function get_straight(hand) end

--- Gets same cards ranks from given hand
--- @param num number Number of same card ranks, must be strictly equal
--- @param hand balatro.Card[]
--- @return balatro.Card[][]. Same jokers
function get_X_same(num, hand) end

--- Gets highest nominal from given hand
--- @param hand balatro.Card[]
--- @return [balatro.Card|nil]. Highest hand
function get_highest(hand) end

--- Empties `G.DRAW_HASH`.
function reset_drawhash() end

--- https://github.com/1bardesign/batteries/blob/master/manual_gc.lua
function nuGC(time_budget, memory_ceiling, disable_otherwise) end

--- Inserts object to drawhash.
--- The drawhash is a hash table of all drawn nodes and all nodes that may be invisible but still collide with the cursor
--- @param obj any
function add_to_drawhash(obj) end

--- Mix color between 1 and 2 with specified proportion.
--- @param C1 ColorHex Color 1
--- @param C2 ColorHex Coloe 2
--- @param proportionC1 number Number of proportion in C1 (0 for C2, 1 for C1)
--- @return ColorHex
function mix_colours(C1, C2, proportionC1) end

--- Modifies number of chips.
--- Currently effective when running a `Rich got Richer` challenge (`G.GAME.modifiers.chips_dollar_cap`)
--- @param _chips number
--- @return number
function mod_chips(_chips) end

--- Modifies number of mult.
--- Currently does nothing.
--- @param _mult number
--- @return number
function mod_mult(_mult) end

function play_sound(sound_code, per, vol) end

function modulate_sound(dt) end

--- Counts number of cards with given suit
--- @param area balatro.CardArea
--- @param suit Suit
--- @return number
function count_of_suit(area, suit) end

--- Prepare srawing for moveable
--- @param moveable balatro.Moveable
--- @param scale number
--- @param rotate? number
--- @param offset? Position
function prep_draw(moveable, scale, rotate, offset) end

--- UNDOCUMENTED
function get_chosen_triangle_from_rect(x, y, w, h, vert) end

--- Translates point from A to B
--- @param _T Position
--- @param delta Position
function point_translate(_T, delta) end

--- Rotates point with given angle, clockwise
--- @param _T Position
--- @param angle number
function point_rotate(_T, angle) end

--- @overload fun(colour: ColorHex, percent: number, no_tab?: false | nil): ColorHex
--- @overload fun(colour: ColorHex, percent: number, no_tab: true): number, number, number, number
function lighten(colour, percent, no_tab) end

--- @overload fun(colour: ColorHex, percent: number, no_tab?: false | nil): ColorHex
--- @overload fun(colour: ColorHex, percent: number, no_tab: true): number, number, number, number
function darken(colour, percent, no_tab) end

--- @overload fun(colour: ColorHex, percent: number, no_tab?: false | nil): ColorHex
--- @overload fun(colour: ColorHex, percent: number, no_tab: true): number, number, number, number
function adjust_alpha(colour, new_alpha, no_tab) end

--- Gives alert when no space for card
--- @param card balatro.Card
--- @param area balatro.CardArea
function alert_no_space(card, area) end

--- Finds joker from `G.jokers`
--- @param name string Joker name
--- @param non_debuff boolean? Includes debuffed joker
--- @return balatro.Card[]
function find_joker(name, non_debuff) end

--- Gets required chips for given ante. May be affected by `G.GAME.modifiers.scaling`
--- @param ante number
--- @return number
function get_blind_amount(ante) end

--- Formats score
--- @param num number
--- @return string
function number_format(num) end

--- Gets scaling for score to be displayed
--- @param scale number
--- @param amt number
--- @return number
function score_number_scale(scale, amt) end

--- Copies table.
--- @generic T
--- @param O `T`
--- @return T
function copy_table(O) end

--- Sends score to `HTTP_MANAGER`.\
--- Only effective when `F_HTTP_SCORES`, `SETTINGS.COMP`, and `F_STREAMER_EVENT` evaluates to true.\
--- Also does nothing unless `http_manager.lua` is also implemented, which in normal Balatro distribution it doesn't.
function send_score(_score) end

--- Sends name to `HTTP_MANAGER`.\
--- Only effective when `F_HTTP_SCORES`, `SETTINGS.COMP`, and `F_STREAMER_EVENT` evaluates to true.\
--- Also does nothing unless `http_manager.lua` is also implemented, which in normal Balatro distribution it doesn't.
function send_name() end

--- Sets high score for current profile's high score.
--- Does not work if the game is currently seeded or in challenge.
--- @param score balatro.Profile.KnownHighScore
--- @param amt number
function check_and_set_high_score(score, amt) end

--- Adds joker usage count for current profile from `G.jokers`
function set_joker_usage() end

--- Adds joker win antes for current profile from `G.jokers`
function set_joker_win() end

--- Gets highest sticker for which joker wins at.
--- @param _center balatro.Item.Joker
--- @param index boolean? If true, returns the stake index (1 = White, 2 = Red, etc.), otherwise returns the stake name
--- @return string|nil
--- @overload fun(center: balatro.Item.Joker, index: true): number
function get_joker_win_sticker(_center, index) end

--- Adds joker loss antes for current profile from `G.jokers`
function set_joker_loss() end

--- Adds current decks for current profile
function set_deck_usage() end

--- Adds current winning deck for current profile
function set_deck_win() end

--- UNDOCUMENTED
function set_challenge_unlock() end

--- Gets number of stakes winned in a deck from current profile
--- @param _deck_key? string
--- @return number
function get_deck_win_stake(_deck_key) end

--- Gets sticket key from given deck from current profile
--- @param _center balatro.Center
--- @return string
function get_deck_win_sticker(_center) end

--- Adds current losing deck for current profile
function set_deck_loss() end

--- Adds a card to consumable usage count to current profile
--- @param card balatro.Card
function set_consumeable_usage(card) end

--- Adds a voucher to voucher usage count to current profile
--- @param card balatro.Card
function set_voucher_usage(card) end

--- Adds a poke rhand to hand usage count to current profile
--- @param hand PokerHand
function set_hand_usage(hand) end

--- UDOCUMENTED
function set_profile_progress() end

--- UDOCUMENTED
function set_discover_tallies() end

--- Adds `G.GAME.STOP_USE` by 1 and calls `dec_stop_use(6)`
---
--- @see dec_stop_use
function stop_use() end

--- Reduces `G.GAME.STOP_USE` by 1
--- @param _depth number Delay, possibly in number of event handles
function dec_stop_use(_depth) end

--- Incrementss career stat.
--- Does not work if the game is currently seeded or in challenge.
--- @param stat balatro.Profile.KnownCareerStat
--- @param mod number
function inc_career_stat(stat, mod) end

--- Copies table recursively, excluding objects types
function recursive_table_cull(t) end

--- Sets `G.action` temporarily and calls `save_run()`
---
--- @see save_run
function save_with_action(action) end

--- Culls current run and queue to save.
--- Ignored if `F_NO_SAVING` is true
function save_run() end

--- Removes saved run in current profile
function remove_save() end

--- Gets colours from given key
--- @param _c balatro.misc.LocColor.KnownType
--- @param _default? ColorHex
--- @return ColorHex
function loc_colour(_c, _default) end

--- @alias balatro.misc.LocColor.KnownType string | "red" | "mult" | "blue" | "chips" | "green" | "money" | "gold" | "attention" | "purple" | "white" | "inactive" | "spades" | "hearts" | "clubs" | "diamonds" | "tarot" | "planet" | "spectral" | "edition" | "dark_edition" | "legendary" | "enhanced"

--- Parses localizations
---
--- @see G.localization.misc.v_dictionary_parsed
--- @see G.localization.misc.v_text_parsed
--- @see G.localization.tutorial_parsed
--- @see G.localization.quips_parsed
---
--- This also parses `G.descriptions` entries to make `name_parsed` and `text_parsed`
function init_localization() end

--- Makes effects to jokers (`G.jokers`) as an added playing card
--- @param cards [true] | balatro.Card[] Added playing card
function playing_card_joker_effects(cards) end

--- Converts current save (`unlocked_jokers.jkr`, `discovered_jokers.jkr`, `alerted_jokers.jkr`) from current profile to meta (`meta.jkr`).
--- This creates `meta.jkr`, and deletes the other 3.
function convert_save_to_meta() end

--- @class CardControlArg
--- @field r RankChar
--- @field s RankChar
--- @field e string? Enhancement
--- @field d string? Edition
--- @field g string? Seal

--- Adds card to playing card (`G.playing_card`) from control
--- @param control CardControlArg
function card_from_control(control) end

--- UNDOCUMENTED
--- @return balatro.Loc.ParsedEntry
function loc_parse_string(line) end

--- @alias balatro.LocalizeTypeArg "other" | "descriptions" | "tutorial" | "quips" | "raw_descriptions" | "text" | "variable" | "name_text" | "name" | "unlocks"

--- @class balatro.LocalizeArg
--- @field type balatro.LocalizeTypeArg
--- @field key string
--- @field set? string
--- @field vars? any[]

--- UNDOCUMENTED
--- @param args balatro.LocalizeArg | string
--- @param misc_cat? string
function localize(args, misc_cat) end

--- Gets stake sprite
--- @param _stake? number
--- @param _scale? number
function get_stake_sprite(_stake, _scale) end

--- Gets asset atlas from given card info
--- @param _front balatro.Item.Card
--- @return balatro.AssetAtlas
--- @return Position
function get_front_spriteinfo(_front) end

--- Gets stake color from given stake
--- @param _stake number
--- @return ColorHex
function get_stake_col(_stake) end

--- Gets ndex from given challenge id.
--- Return 0 if not found
--- @param _id string
--- @return number
function get_challenge_int_from_id(_id) end

--- Gets starting parameters for new game
--- @return balatro.Game.Current.StartingParam
function get_starting_params() end

--- Gets challenge rule value from given challenge and id
--- @param _challenge balatro.Challenge
--- @param _type "modifiers" | "custom"
--- @param _id string
function get_challenge_rule(_challenge, _type, _id) end

function PLAY_SOUND(args) end

function STOP_AUDIO() end

function SET_SFX(s, args) end

function MODULATE(args) end

function RESTART_MUSIC(args) end

function AMBIENT(args) end

function RESET_STATES(state) end
