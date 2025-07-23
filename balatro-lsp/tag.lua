--- @meta

--- @class balatro.Tag: balatro.Object
--- @field key string The tag key, based in `G.P_TAGS`
--- @field config table The config table from `G.P_TAGS[tag].config`. This is copied.
--- @field proto balatro.Item.Tag The prototype tag `G.P_TAGS[tag]`
--- @field pos Position Undocumented
--- @field name string Tag name
--- @field tally number Undocumented
--- @field triggered boolean True if the tag is already applied to current run (`apply_to_run`)
--- @field ID number Unique ID from `G.tagid`, incremented
--- @field ability table Contains additional information about the tag. For Orbital tag, this contains the `orbital_hand` for poker hand to level up
--- @field HUD_tag? balatro.UIBox
local ITag = {}

--- @param _tag string
--- @param for_collection? boolean
--- @param _blind_type? boolean
function ITag:init(_tag, for_collection, _blind_type) end

--- Creates remove tag effect and removes this
function ITag:nope() end

--- Creates applied tag effect and removes this
--- @param message string
--- @param _colour? ColorHex
--- @param func fun(): boolean?
function ITag:yep(message, _colour, func) end

--- Sets `self.ability` data
function ITag:set_ability() end

--- Applies this tag to current run
--- @param _context balatro.Tag.ApplyContext
function ITag:apply_to_run(_context) end

--- Saves this tag to be stored
--- @return balatro.Tag.Save
function ITag:save() end

--- Loads tag info from saved table
function ITag:load(tag_savetable) end

--- @param _scale? number
--- @param _rot? number
function ITag:juice_up(_scale, _rot) end

function ITag:generate_UI(_size) end

--- @param tag_sprite? balatro.Sprite
function ITag:get_uibox_table(tag_sprite) end

--- Removes the tag from `G.GAME.tags`
function ITag:remove_from_game() end

--- Removes this tag from current game and tags UI
function ITag:remove() end

--- @type balatro.Tag | fun(tag: string, forCollection?: boolean, blindType?: boolean): balatro.Tag
Tag = ITag

--- @class balatro.Tag.ApplyContext
--- - `eval` useed when cashing out
--- - `immediate` immediately uses the tag
--- - `new_blind_choice` used when selecting a new blind choice
--- - `tag_add` useed when a tag is added, includes `tag`
--- - `round_start_bonus` used when a new round starts
--- - `shop_start` used when entering a shop
--- - `voucher_add` used to add a new voucher when entering a shop
--- - `store_joker_create` used to add a card when entering a shop
--- - `store_joker_modify` used to modify a card in the shop, includes `card`
--- - `shop_final_pass` finalization for the shop
--- @field type 'eval'
--- @field tag? balatro.Tag
--- @field card? balatro.Card
local x = {}

--- @class balatro.Tag.Save
--- @field key string
--- @field tally number
--- @field ability table