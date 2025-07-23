--- @meta

--- @class balatro.CardArea: balatro.Moveable
--- @field cards balatro.Card[] Cards
--- @field config balatro.CardArea.Config Card area configuration, containing card limit, highlighted limit, sort method, etc.
--- @field highlighted balatro.Card[] Highlighted cards
--- @field shuffle_amt number Undocumented
local ICardArea = {}

--- @param X? number
--- @param Y? number
--- @param W? number
--- @param H? number
--- @param config? balatro.CardArea.ConfigParam
function ICardArea:init(X, Y, W, H, config) end

--- Puts a card in this card area
--- @param card balatro.Card
--- @param location? 'front' If set to `front`, puts the card in the first, otherwise in last. This will be treated as `front` if cardarea type is `deck`
--- @param stay_flipped? boolean Keeps the card flipped
function ICardArea:emplace(card, location, stay_flipped) end

--- Removes a card from this card area
--- @param card? balatro.Card Card to remove. If unspecified, removes last card if `type` is `discard` or `deck`, or removes first otherwise.
--- @param discarded_only? boolean Removes only discarded card from curreny cards
--- @return balatro.Card?
function ICardArea:remove_card(card, discarded_only) end

--- Changes card limit
--- @param delta number
function ICardArea:change_size(delta) end

---Checks if any card in this card area can be highlighted.
---Returns true if `type` is `hand`, `joker`, `consumeable`, or `shop` with `highlighted_limit` > 0
---@return boolean
function ICardArea:can_highlight() end

--- Highlights a card
--- @param card balatro.Card
--- @param silent? boolean
---
--- Highlighted card limit behavior may depend on type:
--- - If `type` is `shop`, only 1 card can be highlighted
--- - If `type` is `joker` and `consumable`, automatically unhighlights card if highlighted card count is too much
--- - Everything else, prevents highlighted if highlighted card count reaches limit
---
--- If this card area is `G.hand`, `parse_highlighted` will be called
function ICardArea:add_to_highlighted(card, silent) end

--- Updates poker hand text from highlighted cards.
function ICardArea:parse_highlighted() end

--- Unhighlights a card
--- @param card balatro.Card
--- @param force? boolean Forcibly unhighlights this card, ignored forced selection
--- If this card area is `G.hand`, `parse_highlighted` will be called
function ICardArea:remove_from_highlighted(card, force) end

--- Unhighlights all card
--- If this card area is `G.hand`, `parse_highlighted` will be called
function ICardArea:unhighlight_all() end

function ICardArea:set_ranks() end

function ICardArea:move(dt) end

function ICardArea:update(dt) end

function ICardArea:draw() end

function ICardArea:align_cards() end

function ICardArea:hard_set_T(X, Y, W, H) end

function ICardArea:hard_set_cards() end

--- Shuffles all cards
--- @param _seed? string Shuffle seed to use, defaults to `shuffle`
function ICardArea:shuffle(_seed) end

--- Sorts all cards
--- @param method? balatro.CardArea.Sort
function ICardArea:sort(method) end

--- Draws a card from other area
--- @param area balatro.CardArea
--- @param stay_flipped? boolean Unused
--- @param discarded_only? boolean
--- @return boolean?
function ICardArea:draw_card_from(area, stay_flipped, discarded_only) end

function ICardArea:click() end

--- Saves this card area and its cards to be stored
function ICardArea:save() end

--- Loads card area info and its cards from saved table
function ICardArea:load(cardAreaTable) end

--- Removes this cardarea from `G.I.CARDAREA`, including its cards and childrens
function ICardArea:remove() end

--- @type balatro.CardArea | fun(X?: number, Y?: number, W?: number, H?: number, config?: balatro.CardArea.ConfigParam): balatro.CardArea
CardArea = ICardArea

--- @class balatro.CardArea.Config
--- @field card_count number Number of cards currently
--- @field card_limit number Limits number of cards
--- @field highlighted_limit number Limits highlighted cards
--- @field lr_padding number Undocumented
--- @field sort balatro.CardArea.Sort Sorting method
--- @field temp_limit number Undocumented
--- @field type balatro.CardArea.Type Card area type. Determines transformation effect for cards

--- @alias balatro.CardArea.Sort "desc" | "asc" | "suit desc" | "suit asc" | "order"
--- @alias balatro.CardArea.Type
--- | "deck" Stacks all cards to one, flipped
--- | "discard" Spreads all cards, flipped
--- | "hand" Playing cards, slightly arced to up
--- | "joker" Joker cards
--- | "consumeable" Consumable cards, wavy
--- | "shop" Shop cards, rotates less aggresively
--- | "play" Same as "shop"
--- | "title_2" Same as "joker"

--- @class balatro.CardArea.Save
--- @field config balatro.CardArea.Config
--- @field cards balatro.Card.Save[]

--- @class balatro.CardArea.ConfigParam
--- Highlighted card limit, defaults to 1
--- @field highlight_limit? number
--- Card limit, defaults to 52
--- @field card_limit? number
--- Area type, defaults to `desk`
--- @field type? balatro.CardArea.Type
--- Sorting method, defaults to `desc`
--- @field sort? balatro.CardArea.Sort
--- Defaults to 0.1
--- @field lr_padding? number