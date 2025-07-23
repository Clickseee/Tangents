--- @meta

--- The base level and container of a graph of 1 or more UIElements. These UIEs are
--- essentially a node based UI implementation. As the root node of the graph, this
--- node is the first called for any movement, updates, or changes to ensure that all child
--- nodes are updated and modified in the correct order.
---
--- The UI_definitions file houses the majority of the definition tables needed for UIBox initialization.
--- @class balatro.UIBox: balatro.Moveable
--- @field parent? balatro.UIBox | balatro.UIElement
--- @field UIRoot? balatro.UIElement
--- @field draw_layers balatro.UIElement[]
--- @field definition balatro.UIElement.Definition
--- @field Mid? balatro.UIElement
--- @field config? balatro.UIBox.Config
local IUIBox = {}

---@param args balatro.UIBox.Arg
--`T` A standard transform in game units describing the inital position and size of the object with x, y, w, h\
--ex - `{x = 1, y = 5, w = 2, h = 2, r = 0}`
--
--`definition` A table containing a valid UIBox definition. These are mostly generated from UI_definitions
--
--`config` A configuration table for the UIBox
--ex - `{ align = 'cm', offset = {x = 1, y = 1}, parent_rect = A, attach_rect = B, can_collide = true }`
function IUIBox:init(args) end

--- Gets an element that matches config.id for given id.
--- @param id? any
--- @param node? balatro.UIElement
--- @return balatro.UIElement
function IUIBox:get_UIE_by_ID(id, node) end

--- Calculates position and size for given element
--- @param node balatro.UIElement
--- @param _T PositionAndSize
--- @param recalculate? boolean If true, forcibly sets the element's transformation instead of calling `Moveable.init` again
--- @param _scale? number
--- @return number, number
function IUIBox:calculate_xywh(node, _T, recalculate, _scale) end

--- Removes nodes that matches config.group for given group.
--- @param node? balatro.UIElement
--- @param group? any
function IUIBox:remove_group(node, group) end

--- Gets nodes that matches config.group for given group.
--- @param node? balatro.UIElement
--- @param group? any
--- @param ingroup? balatro.UIElement[]
--- @return balatro.UIElement[]
function IUIBox:get_group(node, group, ingroup) end

--- Creates an `UIElement` and sets its parent with given parent.1
--- @param node balatro.UIElement.Definition
--- @param parent? balatro.UIElement If not set, then this will be the root of this box
function IUIBox:set_parent_child(node, parent) end

function IUIBox:remove() end

function IUIBox:draw() end

--- @param dt number
function IUIBox:move(dt) end

--- @param offset Position
function IUIBox:drag(offset) end

--- Adds a new child, then recalculate.
--- @param node balatro.UIElement.Config
--- @param parent balatro.UIElement If not set, then this will be the root of this box
function IUIBox:add_child(node, parent) end

--- @param container balatro.Node
function IUIBox:set_container(container) end

--- @param indent? number
--- @return string
function IUIBox:print_topology(indent) end

--- Recalculates the root's position and size.
function IUIBox:recalculate() end

--- @class balatro.UIBox.Arg
--- @field T? balatro.Node.TransformUnit
--- @field definition balatro.UIElement.Definition
--- @field config balatro.UIBox.Config

--- @type balatro.UIBox | fun(args: balatro.UIBox.Arg): balatro.UIBox
UIBox = function() end

--- @class balatro.UIElement: balatro.Moveable
--- @field parent? balatro.UIBox | balatro.UIElement
--- @field UIBox balatro.UIBox
--- @field UIT balatro.UITypeEnum
--- @field config balatro.UIElement.Config
--- @field content_dimensions WidthHeight
--- @field children balatro.Node[] | balatro.UIElement[]
--- @field button_clicked? boolean
--- @field last_clicked? number
--- @field disable_button? boolean
--- @field focus_timer? number
--- @field object_focus_timer? number
--- @field pixellated_rect? balatro.UIElement.PixellatedRect
local IUIElement = {}

--- @param parent? balatro.UIBox
--- @param new_UIBox balatro.UIBox
--- @param new_UIT balatro.UITypeEnum
--- @param config balatro.UIElement.Config
function IUIElement:init(parent, new_UIBox, new_UIT, config) end

--- @param _T PositionAndSize
--- @param recalculate? boolean If true, forcibly sets the element's transformation instead of calling `Moveable.init` again
function IUIElement:set_values(_T, recalculate) end

--- @param indent number
--- @return string
function IUIElement:print_topology(indent) end

function IUIElement:initialize_VT() end

--- @param amount? number
--- @param rot_amt? number
function IUIElement:juice_up(amount, rot_amt) end

--- @return balatro.UIElement?
function IUIElement:can_drag() end

function IUIElement:draw() end

function IUIElement:draw_children(layer) end

function IUIElement:set_wh() end

--- @param x number
--- @param y number
function IUIElement:align(x, y) end

function IUIElement:set_alignments() end

function IUIElement:update_text() end

function IUIElement:update_object() end

function IUIElement:draw_self() end

--- @param _type balatro.UIElement.PixellatedRectType
--- @param _parallax number
--- @param _emboss? number
--- @param _progress? number
function IUIElement:draw_pixellated_rect(_type, _parallax, _emboss, _progress) end

--- @param dt number
function IUIElement:update(dt) end

--- @param cursor_trans Position
--- @return boolean
function IUIElement:collides_with_point(cursor_trans) end

function IUIElement:click() end

--- @return number, number
function IUIElement:put_focused_cursor() end

function IUIElement:remove() end

function IUIElement:hover() end

function IUIElement:stop_hover() end

function IUIElement:release(other) end

--- @type balatro.UIElement | fun(parent, new_UIBox, new_UIT, config): balatro.UIElement
UIElement = IUIElement

--- @class balatro.UIBox.Config: balatro.Moveable.AlignmentArg
--- @field parent? balatro.Moveable
--- @field align balatro.Moveable.AlignmentType? Alias for type
--- @field can_collide  boolean?
--- @field instance_type? balatro.Global.Instances.InstanceType

--- @class balatro.UIElement.Definition
--- @field n balatro.UITypeEnum
--- @field nodes? balatro.UIElement.Definition[]
--- @field config? balatro.UIElement.Config

--- @class balatro.UIElement.Config: balatro.Node.Config
--- UIElement identifier, to be used in `get_UIE_by_ID. \
--- Supported for all types.
--- @field id? any
---
--- Width of the element. If unspecified, defaults to object's width. \
--- **Supported: Box, Object**
--- @field w? number
--- Height of the element. If unspecified, defaults to object's height. \
--- **Supported: Box, Object**
--- @field h? number
--- Maximum width of the element.
--- If the children exceeds the maximum width, it will be scaled down. \
--- **Supported: Anything except Box, Object, Text**
--- @field maxw? number
--- Maximum height of the element.
--- If the children exceeds the maximum height, it will be scaled down. \
--- **Supported: Anything except Box, Object, Text**
--- @field maxh? number
--- Minimum width of the element. \
--- **Supported: Anything except Box, Object, Text**
--- @field minw? number
--- Minimum height of the element. \
--- **Supported: Anything except Box, Object, Text**
--- @field minh? number
--- Element alignment. \
--- Supported for all types.
--- @field align balatro.Moveable.AlignmentType?
--- If true, sets this element as a midpoint for center alignment for UIBox.
--- See Moveable's Mid for more info. \
--- Supported for all types.
--- @field mid? boolean
--- Determines the layer this element should be drawn on.
--- This allows control over stacked elements. \
--- Supported for all types.
--- @field draw_layer? number
--- Do not fill children's row and column. \
--- Supported for all types.
--- @field no_fill? boolean
---
--- Element padding, inner gap between boundary and the element's childrens. \
--- Supported for all types.
--- @field padding? number
--- Element scaling. \
--- Supported for all types.
--- @field scale? number
--- Draws this element only after drawing all the children. \
--- Supported for all types.
--- @field draw_after? boolean
---
--- Creates emboess effect. This will create a solid shadow effetc with darker color from given `colour`. \
--- **Supported: Box, Row, Column, Root**
--- @field emboss? number
--- Background / text color to use. \
--- Supported for all types.
--- @field colour? ColorHex
--- Outline thickness. Must be used altogether with `outline_colour`. \
--- Supported for all types.
--- @field outline? number
--- Outline color. \
--- Supported for all types.
--- @field outline_colour? ColorHex
--- Draws shadow. Can be ignored if user's settings has disabled shadows. \
--- Supported for all types.
--- @field shadow? boolean
--- Shadow color. \
--- Supported for all types.
--- @field shadow_colour? ColorHex
--- Creates a progress bar. \
--- **Supported: Box, Row, Column, Root**
--- @field progress_bar? balatro.UIElement.ProgressBarData
---
--- Reference table to hook the value from.
--- Must be used altogether with `ref_value`.
--- - For `T`, `text` is set.
--- - For `O`, `object` is set.
--- - If `progress_bar` is used, it it used as a percentage.
---
--- Supported for all types.
--- @field ref_table? table
--- Property key to use for reference table.
--- Must be used altogether with `ref_table`.
--- @field ref_value? any
---
--- Determines if corner is rounded. \
--- **Supported: Box, Row, Column, Root**
--- @field r? boolean
--- ???
--- Supported for all types.
--- @field ext_up? number
--- Sets rouneded corner radius scaling.
--- Defaults:
--- - W and H* > 3.5: 0.8
--- - W and H* > 3: 0.6
--- - 0.15
---
--- Supported for all types.
--- @field res? number
---
--- Sets group key for this element. \
--- Grouping allows definining some choice elements that has same group ID. \
--- Grouping also allows removing elements in group. \
--- Supported for all types.
--- @field group? any
--- Determines if this element is a choice element.
--- If `true`, must also include `group`. \
--- Supported for all types.
--- @field choice? boolean
--- True if this element is chosen among same `groups` from element's UIBox.
--- This is set automatically by UIElement when clicked, only when `choice` is true. \
--- Supported for all types.
--- @field chosen? boolean | 'vert'
---
--- Function name to be called everytime `update` is called.
--- This should be a valid key from `G.FUNCS`.
--- Called function will receive single argument `UIElement`, which represents current element. \
--- Supported for all types.
--- @field func? string
--- Allows `func` to be called unconditionally when calculating.
--- `func` usually called during calculation if `button` or `button_UIE` is specified. \
--- Supported for all types.
--- @field insta_func? boolean
---
--- Function name to be called when the element is clicked.
--- This should be a valid key from `G.FUNCS`. \
--- Called function will receive single argument `UIElement`, which represents current element. \
--- Supported for all types.
--- @field button? string
--- Only allows clicking this once, then the button is disabled automatically. \
--- Supported for all types.
--- @field one_press? boolean
--- Another element to be clicked when this element is clicked. \
--- Supported for all types.
--- @field button_UIE? balatro.Node
--- Distance offset to the bottom right when the button is being held. \
--- Supported for all types.
--- @field button_dist? number
--- How much delay in seconds before the button can be clicked. \
--- Supported for all types.
--- @field button_delay? number
--- Time when button delay has started progressing.
--- Setting this value initially requires `button_delay_end` to be also set. \
--- Supported for all types.
--- @field button_delay_start? number
--- When the button should become clickable.
--- Setting this value initially requires `button_delay_start`, otherwise this will be set to `0`. \
--- Supported for all types.
--- @field button_delay_end? number
--- button delay progress (0-1).
--- Setting this value initially requires `button_delay_start`, otherwise this will be set to `0`. \
--- Supported for all types.
--- @field button_delay_progress? number
---
--- Createa a tooltip when hovered. \
--- Supported for all types.
--- @field tooltip? balatro.CreateTooltipParam
--- Createa a tooltip when hovered.
--- Automatically sets popup's Y position at the bottom of the element if at the top hald,
--- or at the top of the element if at the bottom half. \
--- Supported for all types.
--- @field on_demand_tooltip? balatro.CreateTooltipParam
--- Creates a detailed tooltip from given Center when hovered. \
--- Supported for all types.
--- @field detailed_tooltip? balatro.Center
---
--- Contains information on how the element should be focused when navigating via gamepad. \
--- Supported for all types.
--- @field focus_args?  balatro.UIElement.FocusArgData
--- Allows this element to be focused.
--- @field force_focus? boolean
--- Allows collision. Also makes `object` collidable if specified.\
--- Supported for all types.
--- @field can_collide? boolean
--- Allows collision. \
--- Supported for all types.
--- @field collideable? boolean
--- Allows this element to be collided.
--- Supported for all types.
--- @field force_collision? boolean
---
--- Sets text. for this element. \
--- **Supported: Text**
--- @field text? string
--- Font from specified language to use for the drawable text. \
--- **Supported: Text**
--- @field lang? balatro.Language
--- Displays the text vertically, and rotates w and h. \
--- **Supported: Text**
--- @field vert? boolean
--- Drawable Text to be used for rendering texts. \
--- **Supported: Text**
--- @field text_drawable? love.Text
--- Do not recalculate the UIBox after the text is updated.
--- **Supported: Text**
--- @field no_recalc? boolean
---
--- Sets object to render inside the element. \
--- **Supported: Object**
--- @field object? balatro.Moveable
--- Do not set role to given `object`. \
--- **Supported: Object**
--- @field no_role? boolean
--- Role to set on given `object`.
--- Defaults to `{role_type = 'Minor', major = self, xy_bond = 'Strong', wh_bond = 'Weak', scale_bond = 'Weak'}`. \
--- **Supported: Object**
--- @field role? balatro.Moveable.RoleArg
--- Also highlights the object if current element is focused. \
--- **Supported: Object**
--- @field focus_with_object? boolean
---
--- ???
--- @field hover? boolean
--- ???
--- @field refresh_movement? boolean

--- @class balatro.UIElement.PixellatedRect: WidthHeight
--- @field sw number
--- @field sh number
--- @field progress number
--- @field fill balatro.UIElement.PixellatedRectData
--- @field shadow balatro.UIElement.PixellatedRectData
--- @field line balatro.UIElement.PixellatedRectData
--- @field emboss balatro.UIElement.PixellatedRectData
--- @field line_emboss balatro.UIElement.PixellatedRectData

--- @alias balatro.UIElement.PixellatedRectType 'fill' | 'shadow' | 'line' | 'emboss' | 'line_emboss'

--- @class balatro.UIElement.PixellatedRectData
--- @field vertices number[]

--- @class balatro.UIElement.ProgressBarData
--- @field empty_col? ColorHex Fill color for empty
--- @field filled_col? ColorHex Fill color for finished
--- @field ref_table? any
--- @field ref_value? any
--- @field max number Maximum value

--- @class balatro.UIElement.FocusArgData
--- Gamepad button to add to registry.
--- Setting this will call `Controller:add_to_registry`
--- @field button? love.GamepadButton
--- The parent that controls which element (`funnel_to`) should be focused.
--- Used when navigating via gamepad.
--- @field funnel_from? boolean|balatro.UIElement
--- The child element that should be focused when the parent (`funnel_from`) is focused.
--- Used when navigating via gamepad.
--- @field funnel_to? boolean|balatro.UIElement

--- @param node any
--- @return boolean
function is_UI_containter(node) end
