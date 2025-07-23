--- @meta

--- Node represent any game object that needs to have some transform available in the game itself. \
--- Everything that you see in the game is a Node, and some invisible things like the G.ROOM are also represented here.
--- @class balatro.Node: balatro.Object
---
--- Store all argument and return tables here for reuse, because Lua likes to generate garbage
--- @field ARGS any
--- @field RETS any
--- Config table used for any metadata about this node
--- @field config balatro.Node.Config | table
--- For transform init, accept params in the form x|1, y|2, w|3, h|4, r|5
--- @field T balatro.Node.TransformUnit
--- Transform to use for collision detection
--- @field CT balatro.Node.TransformUnit
--- used to determine things like drag offset and 3d shader effectsformUnit
--- @field click_offset Position
--- used to determine things like drag offset and 3d shader effects
--- @field hover_offset Position
--- To keep track of all nodes created on pause. If true, this node moves normally even when the G.TIMERS.TOTAL doesn't increment
--- @field created_on_pause boolean
--- ID tracker, every Node has a unique IDn_pause boolean
--- @field ID number
--- Frame tracker to aid in not doing too many extra calculations
--- @field FRAME balatro.Node.Frame
--- The states for this Node and all derived nodes.
--- This is how we control the visibility and interactibility of any object.
--- All nodes do not collide by default.
--- This reduces the size of n for the O(n^2) collision detection
--- @field states balatro.Node.State
--- If we provide a container, all nodes within that container are translated with that container as the reference frame.\
--- For example, if G.ROOM is set at x = 5 and y = 5, and we create a new game object at 0, 0, it will actually be drawn at 5, 5.\
--- This allows us to control things like screen shake, room positioning, rotation, padding, etc. without needing to modify\
--- every game object that we need to draw
--- @field container balatro.Node
--- The list of children give Node a treelike structure.
--- This can be used for things like drawing, deterministice movement and parallax calculations
--- when child nodes rely on updated information from parents,
--- and inherited attributes like button click functions.
--- @field children table<string, balatro.Node>
---
--- Set by `Moveable`. For `Node`, this is used for debugging.
--- @field CALCING? boolean
---
--- Text value to show when G.DEBUG is true. Used for debugging.
--- @field DEBUG_VALUE? string
---
--- @field REMOVED? boolean
local INode = {}

--- @param args {T: balatro.Node.TransformInit, container: balatro.Node}
--- - `T` The transform ititializer, with keys of x|1, y|2, w|3, h|4, r|5\
--- - `container` optional container for this Node, defaults to G.ROOM
function INode:init(args) end

--- Draw a bounding rectangle representing the transform of this node. Used in debugging.
function INode:draw_boundingrect() end

--- Draws self, then adds self the the draw hash, then draws all children
function INode:draw() end

--- Determines if this node collides with some point. Applies any container translations and rotations, then applies translations and rotations specific to this node. \
--- This means the collision detection effectively determines if some point intersects this node regargless of rotation.
--- @param point Position The coordinates of the cursor transformed into game units
--- @return boolean
function INode:collides_with_point(point) end

--- Sets the offset of passed point in terms of this nodes T.x and T.y
--- @param point Position The coordinates of the cursor transformed into game units
--- @param type string The type of offset to set for this Node, either 'Click' or 'Hover'
function INode:set_offset(point, type) end

--- If the current container is being 'Dragged', usually by a cursor,
--- determine if any drag popups need to be generated and do so
function INode:drag(offset) end

--- Determines if this Node can be dragged. This is a simple function but more complex objects may redefine this to return a parent\
--- if the parent needs to drag other children with it
--- @return balatro.Node?
function INode:can_drag() end

--- Called by the CONTROLLER when this node is no longer being dragged, removes any d_popups
function INode:stop_drag() end

--- If the current container is being 'Hovered', usually by a cursor,
--- determine if any hover popups need to be generated and do so
function INode:hover() end

--- Called by the CONTROLLER when this node is no longer being hovered, removes any h_popups
function INode:stop_hover() end

--- Called by the CONTROLLER to determine the position the cursor should be set to for this node
--- @return number, number
function INode:put_focused_cursor() end

--- Sets the container of this node and all child nodes to be a new container node
---@param container balatro.Node The new node that will behave as this nodes container
function INode:set_container(container) end

--- Translation function used before any draw calls,
--- translates this node according to the transform of the container node
function INode:translate_container() end

--- When this Node needs to be deleted, removes self from any tables it may have been added to to destroy any weak references.
--- Also calls the remove method of all children to have them do the same
function INode:remove() end

--- returns the squared(fast) distance in game units from the center of this node to the center of another node
--- @param other_node balatro.Node
--- @return number
function INode:fast_mid_dist(other_node) end

--- Prototype for a click release function, when the cursor is released on this node
--- @param dragged boolean
function INode:release(dragged) end
--- Prototype for a click function
function INode:click() end
--- Prototype animation function for any frame manipulation needed
function INode:animate() end
--- Prototype update function for any object specific logic that needs to occur every frame
--- @param dt number
function INode:update(dt) end

--- @type balatro.Node | fun(args: {T: balatro.Node.TransformInit, container: balatro.Node}): balatro.Node
Node = function() end

--- @class balatro.Node.TransformUnit: PositionAndSize
--- @field r number
--- @field scale number

--- @class balatro.Node.TransformInit: PositionAndSize
--- @field r number

--- @class balatro.Node.State
--- @field visible boolean
--- @field collide balatro.Node.AbilityState
--- @field focus balatro.Node.AbilityState
--- @field hover balatro.Node.AbilityState
--- @field click balatro.Node.AbilityState
--- @field drag balatro.Node.AbilityState
--- @field release_on balatro.Node.AbilityState

--- @class balatro.Node.AbilityState
--- @field is boolean
--- @field can boolean

--- @class balatro.Node.Config
--- @field d_popup? balatro.UIElement.Config
--- @field d_popup_config? balatro.UIBox.Config
--- @field h_popup? balatro.UIElement.Config
--- @field h_popup_config? balatro.UIBox.Config

--- @class balatro.Node.Frame
--- @field DRAW number
--- @field MOVE number
--- @field MAJOR? balatro.Node.Frame.Major
--- @field OLD_MAJOR? balatro.Node.Frame.Major

--- @class balatro.Node.Frame.Major
--- @field major balatro.Moveable
--- @field offset Position


