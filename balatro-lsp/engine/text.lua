--- @meta

--- @class balatro.DynaText: balatro.Moveable
--- @field config balatro.DynaText.Config
---
--- If true, draws shadow
--- @field shadow? boolean
--- Text scaling
--- @field scale number
--- Bump rate
--- @field bump_rate number
--- Bump amount
--- @field bump_amount number
--- Font
--- @field font balatro.Font
--- Currently focused string
--- @field string string
--- Text offset, in pixels
--- @field text_offset Position
--- Letter colors
--- @field colours ColorHex[]
--- Created time
--- @field created_time number
--- Do not play sound when cycling
--- @field silent boolean
---
--- @field strings balatro.DynaText.String[]
--- @field focused_string number
--- @field pop_delay number
--- @field pop_in_rate number
--- @field start_pop_in? number
--- @field reset_pop_in? boolean
--- @field pop_out_time? number
--- @field pop_cycle? boolean
local IDynaText = {}

--- @param config balatro.DynaText.ConfigAsOptions
function IDynaText:init(config) end

function IDynaText:update(dt) end

--- @param first_pass? boolean
function IDynaText:update_text(first_pass) end

--- @param pop_out_timer number
function IDynaText:pop_out(pop_out_timer) end

--- @param pop_in_timer number
function IDynaText:pop_in(pop_in_timer) end

function IDynaText:align_letters() end

--- @param amt? number Defaults to 0.7
function IDynaText:set_quiver(amt) end

--- @param amt? number Defaults to 0.2
function IDynaText:pulse(amt) end

function IDynaText:draw() end

--- @type balatro.DynaText | fun(config: balatro.DynaText.Config?): balatro.DynaText
DynaText = function() end

--- @class balatro.DynaText.String
--- @field string string
--- @field letters balatro.DynaText.String.Letter[]
--- @field W number
--- @field W_offset number
--- @field H number
--- @field H_offset number

--- @class balatro.DynaText.String.Letter
--- @field letter love.Text
--- @field char string
--- @field scale number
--- @field offset Position
--- @field dims Position
--- @field pop_in number
--- @field prefix unknown
--- @field suffix unknown

--- @class balatro.DynaText.Config
--- @field W? number
--- @field H? number
--- @field X? number
--- @field Y? number
--- @field x_offset? number X offset, in pixels
--- @field y_offset? number Y offset, in pixels
--- @field maxw? number Maximum width, in tile scale
---
--- @field string string[] String texts. If array size is more than one, this will cycle through them all.
--- @field font? balatro.Font Font to use
--- @field colours? ColorHex[] Letter colors. First letter color will be at index 2.
--- @field text_rot? number Text rotation amount, in 2rad
--- @field spacing? number Text spacing, gap between letters.
--- @field rotate? boolean Rotates the letters
---
--- @field shadow? boolean If true, displays shadow, defaults to false
--- @field shadow_colour? ColorHex Shadow color.
--- @field scale? number Text scaling, defaults to 1
---
--- @field random_element? boolean Randomly selects a string from array of `string` when cycling
--- @field pop_delay? number Delay before cycling to next text, defaults to 1.5
--- @field pop_in_rate? number Text pop in rate, in `second^-1`
--- @field min_cycle_time? number Minimum cycle time (pop out + pop in). In seconds. Does not guarantee that cycle time will be exact.
--- @field silent? boolean If true, don't play sound when cycling text.
--- @field pitch_shift? number Pitch shift when popping in text
---
--- @field bump? boolean Creates text bumping effect
--- @field bump_rate? number Text bumping rate, in letters / seconds, defaults to 2.666. Only effective when `bump` is `true`
--- @field bump_amount? number How much bumping effect. Defaults to 1 Only effective when `bump` is `true`
---
--- @field float? boolean If true, creates stable wavy effect
--- @field quiver? { speed: number, amount: number } Creates shaking / quivering effect, used when scoring already reaches minimum in a single play.
---
--- @field pulse? balatro.Dynatext.Config.Pulse This should be set by `pulse`
---
--- Pop in delay. Ignored if defined in initial value. Set by `pop_in`.
--- @field pop_in? number
--- Pop out delay. Ignored if defined in initial value. Set by `pop_in`.
--- @field pop_out? number
--- ???
--- @field reset_pop_in? boolean

--- @class balatro.DynaText.Init: balatro.DynaText.Config
--- @field string string | string[] String texts. If array size is more than one, this will cycle through them all.

--- @class balatro.Dynatext.Config.Pulse
--- @field speed number
--- @field width number
--- @field start number
--- @field amount number
--- @field silent? boolean

--- @class balatro.DynaText.ConfigAsOptions: balatro.DynaText.Config
--- @field string? string[] | string