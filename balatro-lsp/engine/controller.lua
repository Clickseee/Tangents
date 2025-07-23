--- @meta

--- The input controller, which handles mouse, touch, and keyboard inputs.
--- @class balatro.Controller: balatro.Object
--- The node that was clicked this frame
--- @field clicked balatro.Controller.Target
--- The node that is being focused on this frame, only applies when using controller
--- @field focused balatro.Controller.Target
--- The node being dragged this frame
--- @field dragging balatro.Controller.Target
--- The node being hovered this frame
--- @field hovering balatro.Controller.Target
--- The node that the cursor 'Released' on, like letting go of LMB
--- @field released_on balatro.Controller.Target
---
--- A list of all node that the cursor currently collides with
--- @field collision_list balatro.Node[]
--- @field nodes_at_cursor? balatro.Node[]
---
--- @field cursor_down balatro.Controller.TargetWithPos
--- @field cursor_up balatro.Controller.TargetWithPos
--- @field cursor_hover balatro.Controller.TargetWithPos
--- @field collider balatro.Node? The node that collides with the cursor this frame
--- @field cursor_position Position Not in game units
---
--- @field pressed_keys table<love.KeyConstant, boolean>
--- @field held_keys table<love.KeyConstant, boolean>
--- @field held_key_times table<love.KeyConstant, number>
--- @field released_keys table<love.KeyConstant, boolean>
---
--- @field pressed_buttons table<number, boolean>
--- @field held_buttons table<number, boolean>
--- @field held_button_times table<number, number>
--- @field released_buttons table<number, boolean>
---
--- For all controller interrupts
--- @field interrupt balatro.Controller.Interrupt
--- For all controller locks. Key is mostly TagID
--- @field locks table<string, boolean>
--- @field locked? boolean
---
--- Buttons pressed and released during axis updates
--- @field axis_buttons balatro.Controller.AxisButtonList
--- The speed that the controller thumbstick moves the cursor
--- @field axis_cursor_speed number
--- A registry of buttons, each a valid button input name corresponding to a node (likely a button). This is modified with the registry functions
--- @field button_registry table<string, balatro.Controller.ButtonRegistry>
---
--- A node representing where the cursor should 'snap' to.
--- When this is set, then next frame should have the cursor to that position or on that node.
--- @field snap_cursor_to? balatro.Controller.Snap
---
--- A stack of cursor positions, this stack changes depending on the depth of menus on screen so the game can remember where you last had your cursor
--- This needs to keep track of both positions and nodes if possible, as well as the depth
--- @field cursor_context balatro.Controller.CursorContext
--- Undocumented
--- @field cardarea_context table<string, balatro.CardArea>
---
--- Human Interface device flags,
--- these are set per frame to ensure that correct controller updates are taking place
--- @field HID balatro.Controller.HID
---
--- @field GAMEPAD balatro.Controller.Gamepad
--- @field GAMEPAD_CONSOLE balatro.Controller.GamepadType | ""
---
--- @field is_cursor_down boolean
---
--- @field overlay_timer? number
--- @field frame_buttonpress? boolean
--- @field repress_timer? number
--- @field text_input_hook? balatro.UIElement
--- @field no_holdcap? boolean
--- @field capslock? boolean
--- @field L_cursor_queue? Position
--- @field screen_keyboard? balatro.UIBox
local IController = {}

function IController:init() end

--- Sets the gamepad to be the updated gamepad, searches for the console type and sets the art button pips accordingly
--- Some code here is from github.com/idbrii/love-gamepadguesser (MIT License)
--- @param _gamepad love.Joystick
function IController:set_gamepad(_gamepad) end

--Some code here is from github.com/idbrii/love-gamepadguesser (MIT License)
--- @param _gamepad string
--- @return string
function IController:get_console_from_gamepad(_gamepad) end

--- The universal controller for what type of HID Device the player is using to interact with the game.
--- The Game should be able to handle switching to any viable HID at any time
--- @param HID_type balatro.Controller.HIDType
---- @param button number
function IController:set_HID_flags(HID_type, button) end

--- Sets the current position of the cursor
function IController:set_cursor_position() end

--- Called every game logic update frame
function IController:update(dt) end

--- Brute force remove all registries that no longer have valid nodes
function IController:cull_registry() end

--- Adds a node to the controller registry. Supply the button that will be pressed in order to click this node
---@param node balatro.Node The node that will be clicked when the registry is pressed
---@param registry love.GamepadButton The button to register, must be a valid gamepad input
function IController:add_to_registry(node, registry) end

--- Process any click function of any nodes that have been clicked in the button registry
function IController:process_registry() end


--- Add or remove layers from the context for the cursor.
--- This allows the cursor to 'snap' back to the previous layer when the current layer is removed
--- in such cases where a menu on screen is removed or nested menus are being navigated
--- @param delta number The direction to modify the cursor context, 1 to add a layer, -1 to remove a layer, -1000 to remove all layers except for the base
function IController:mod_cursor_context_layer(delta) end

--- Snap the cursor to a particular node or transform
--- @param args { node: balatro.Node?, T: balatro.Node.TransformUnit? }
function IController:snap_to(args) end

--- saves the focus context to be loaded in the future, for example if the shop is rerolled while a card is highlighted
--- @param _cardarea balatro.CardArea
function IController:save_cardarea_focus(_cardarea) end

--- recalls the focus context for a particular cardarea
--- @param _cardarea balatro.CardArea
function IController:recall_cardarea_focus(_cardarea) end

--- Updated the location of the cursor, either with a specific T or if there is a Node target
--- @param hard_set_T? Position
function IController:update_cursor(hard_set_T) end

--- Helper function to set the button presses/releases for the values determined in update_axis()
function IController:handle_axis_buttons() end

--- Handles all axis input for left stick, right stick and triggers. Treats them as buttons or cursors depending on context
--- @param dt number
function IController:update_axis(dt) end

--- @param dt number
--- @param button love.GamepadButton
function IController:button_press_update(button, dt) end

--- @param dt number
--- @param button love.GamepadButton
function IController:button_hold_update(button, dt) end

--- @param dt number
--- @param button love.GamepadButton
function IController:button_release_update(button, dt) end

--- @param button love.GamepadButton
function IController:button_press(button) end

--- @param button love.GamepadButton
function IController:button_release(button) end

--- @param key love.KeyConstant
---- @param dt number
function IController:key_press_update(key, dt) end

--- @param key love.KeyConstant
--- @param dt number
function IController:key_hold_update(key, dt) end

--- @param key love.KeyConstant
---- @param dt number
function IController:key_release_update(key, dt) end

--- @param key love.KeyConstant
function IController:key_press(key) end

--- @param key love.KeyConstant
function IController:key_release(key) end

function IController:get_cursor_collision(cursor_trans) end

function IController:set_cursor_hover() end

--- @param x number
--- @param y number
function IController:queue_L_cursor_press(x, y) end

---- @param x number
---- @param y number
function IController:queue_R_cursor_press(x, y) end

--- @param x number
--- @param y number
function IController:L_cursor_press(x, y) end

--- @param x? number
--- @param y? number
function IController:L_cursor_release(x, y) end

--- @param node balatro.Node
--- @return boolean
function IController:is_node_focusable(node) end

--- @param dir 'R' | 'L' | 'D' | 'U'
function IController:update_focus(dir) end

--- @param button love.GamepadButton
--- @param input_type 'press' | 'hold'
--- @param dt number
--- @return boolean
function IController:capture_focused_input(button, input_type, dt) end

--- @param dir 'R' | 'L' | 'D' | 'U'
function IController:navigate_focus(dir) end


--- @type balatro.Controller | fun(): balatro.Controller
Controller = function () end

--- @class balatro.Controller.Target
--- @field handled? boolean
--- @field target? balatro.Node
--- @field handles? boolean
--- @field prev_target? balatro.Node

--- @class balatro.Controller.TargetWithPos: balatro.Controller.Target
--- @field T Position
--- @field time number

--- @class balatro.Controller.Interrupt
--- @field focus? boolean
--- @field stack? boolean

--- @class balatro.Controller.AxisButtonList
--- @field l_stick balatro.Controller.AxisButton
--- @field r_stick balatro.Controller.AxisButton
--- @field l_trig balatro.Controller.AxisButton
--- @field r_trig balatro.Controller.AxisButton

--- @class balatro.Controller.AxisButton
--- @field current balatro.Controller.AxisButtonKey
--- @field previous balatro.Controller.AxisButtonKey

--- @class balatro.Controller.ButtonRegistry
--- @field click? boolean
--- @field node balatro.Node
--- @field menu boolean

--- @class balatro.Controller.CursorContext
--- @field layer number
--- @field stack balatro.Controller.CursorStack[]

--- @class balatro.Controller.CursorStack
--- @field node balatro.Node
--- @field cursor_pos Position
--- @field interrupt boolean

--- @class balatro.Controller.HID
--- @field last_type balatro.Controller.HIDType | ""
--- @field dpad boolean
--- @field pointer boolean
--- @field touch boolean
--- @field controller boolean
--- @field mouse boolean
--- @field axis_cursor boolean

--- @class balatro.Controller.Gamepad
--- @field object? love.Joystick
--- @field mapping? string
--- @field name? string

--- @class balatro.Controller.Snap
--- @field node? balatro.Node
--- @field T? balatro.Node.TransformUnit
--- @field type 'node' | 'transform'

--- @alias balatro.Controller.HIDType "mouse" | "button" | "touch" | "axis"
--- @alias balatro.Controller.GamepadType "Xbox" | "Playstation" | "Nintendo"
--- @alias balatro.Controller.AxisButtonKey "dpright" | "dpleft" | "dpdown" | "dpup" | "triggerleft" | "triggerright" | string