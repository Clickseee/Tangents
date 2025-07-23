--- @meta

--- @class balatro.Blind: balatro.Moveable
--- @field chips number Required chips
--- @field tilt_var {mx: number, my: number, amt: number} Undocumented
--- @field ambient_tilt number Undocumented
--- @field colour ColorHex Blind color
--- @field dark_colour ColorHex Blind dark color
--- @field config balatro.Blind.Config Blind configuration
--- @field children balatro.Blind.Children
---
--- @field loc_name? string
--- @field loc_debuff_text? string
--- @field loc_debuff_lines string[]
---
--- @field chip_text? string Required chips in text
--- @field name? string Blind name
--- @field dollars? number Blind reward
--- @field sound_pings? number Number of sound to be played when the boss is defeated. This is usually set to number of dollars. Maximum is 7
--- @field debuff? balatro.Blind.Debuff Debuff info
--- @field pos? Position Undocumented
--- @field mult? number Required chips multiplier
--- @field disabled? boolean True if the blind is disabled
--- @field discards_sub number? Only for The Water, number of discards taken
--- @field hands_sub number? Only for The Needle, number of hands taken
--- @field boss? boolean True if the blind is a boss type
--- @field blind_set? boolean True if blind has been set
--- @field triggered? boolean Undocumented
--- @field prepped boolean? Undocumented
--- @field hovering? boolean Undocumented
--- @field hover_tilt? number Undocumented
--- @field hands table<PokerHand, boolean>? Only for The Eye
--- @field only_hand PokerHand? Only for The Mouth
--- @field block_play? boolean Blocks the play button
--- @field dissolve? number Dissolve progress (0-1)
--- @field dissolve_colours ColorHex[] Dissolve colors
local IBlind = {}

--- @param color? ColorHex
function IBlind:change_colour(color) end

--- Sets locatization texts for `loc_name`, `loc_debuff_text`, `loc_debuff_lines
function IBlind:set_text() end

--- @param blind? balatro.Item.Blind
--- @param reset? boolean If true, do not set new blind; resets current blind instead
--- @param silent? boolean Do not play sound
function IBlind:set_blind(blind, reset, silent) end

--- Alerts blind's debuff
function IBlind:alert_debuff(first) end

--- @return string
function IBlind:get_loc_debuff_text() end

--- Creates defeat effect and removes blind info
--- @param silent? boolean
function IBlind:defeat(silent) end

--- Gets blind type
--- @return BlindType
function IBlind:get_type() end

function IBlind:disable() end

function IBlind:hover() end

function IBlind:stop_hover() end

function IBlind:draw() end

--- Triggers effect when scoring started
--- @return boolean|nil hasEffect True if the blind caused some effect
function IBlind:press_play() end

--- Modifies played hand
--- @param cards balatro.Card[]
--- @param poker_hands balatro.PokerHandsEvalInfo
--- @param text string
--- @param mult number
--- @param hand_chips number
function IBlind:modify_hand(cards, poker_hands, text, mult, hand_chips) end

--- Checks if played hand is debuffed (not allowed).
--- This also triggers some effects, e.g. The Arm level down played poker hand.
--- @param cards balatro.Card[]
--- @param hand balatro.PokerHandsEvalInfo
--- @param handname PokerHand
--- @param check? boolean Only check, do not apply effects
--- @return boolean|nil
function IBlind:debuff_hand(cards, hand, handname, check) end

--- Triggers effect when a card is drawn to hand
function IBlind:drawn_to_hand() end

--- Checks whether a card should be stay flipped
--- @param area balatro.CardArea This should be `G.hand`, otherwise nil is always returned
--- @param card balatro.Card
--- @return boolean|nil
function IBlind:stay_flipped(area, card) end

--- Sets debuff for a card
--- @param card balatro.Card
function IBlind:debuff_card(card) end

function IBlind:move(dt) end

--- Changes dimension for this blind
--- @param w? number
--- @param h? number
function IBlind:change_dim(w, h) end

function IBlind:align() end

--- Saves this blind to be stored
--- @return balatro.Blind.Save
function IBlind:save() end

--- Loads saved table
--- @param blindTable balatro.Blind.Save
function IBlind:load(blindTable) end

--- @type balatro.Blind | fun(X?: number, Y?: number, W?: number, H?: number): balatro.Blind
Blind = function() end

--- @class balatro.Blind.Children: { [string]: balatro.Node }
--- @field animatedSprite balatro.AnimatedSprite
--- @field particles? balatro.Particles

--- @class balatro.Blind.Debuff
--- @field hand? PokerHand
--- @field h_size_ge? number
--- @field h_size_le? number
--- @field suit? Suit
--- @field is_face? 'face'
--- @field value? Rank
--- @field nominal? number

--- @class balatro.Blind.Config: table
--- @field blind? balatro.Item.Blind

--- @class balatro.Blind.Save
--- @field name string
--- @field dollars number
--- @field debuff balatro.Blind.Debuff
--- @field pos Position
--- @field mult number
--- @field disabled boolean
--- @field discards_sub? number
--- @field hands_sub? number
--- @field boss boolean
--- @field config_blind string
--- @field chips number
--- @field chip_text string
--- @field hands? table<PokerHand, boolean>
--- @field only_hand? PokerHand
--- @field triggered? boolean