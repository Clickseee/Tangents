--- @meta

--- Moveable represents any game object that has the ability to move about the gamespace.\
--- All Moveables have a T (transform) that describes their desired transform in game units,\
--- as well as a VT (Visible Transform) that eases to T over time. This allows for simplified movement\
--- where we only need to set T.x, T.y, etc. to their final position and the engine will ensure the Moveable\
--- VT eases to that final location, regargless of any events or timing.
--- @class balatro.Moveable: balatro.Node
---
--- The Visible transform is initally set to the same values as the transform T.
--- Note that the VT has an extra 'scale' factor, this is used to manipulate the center-adjusted
--- scale of any objects that need to be drawn larger or smaller
--- @field VT balatro.Node.TransformUnit
--- To determine location of VT, we need to keep track of the velocity of VT as it approaches T for the next frame
--- @field velocity balatro.Moveable.Velocity
--- For more robust drawing, attaching, movement and fewer redundant movement calculations, Moveables each have a 'role'
--- that describes a heirarchy of move() calls. Any Moveables with 'Major' role type behave normally, essentially recalculating their
--- VT every frame to ensure smooth movement. Moveables can be set to 'Minor' role and attached to some 'Major' moveable
--- to weld the Minor moveable to the Major moveable. This makes the dependent moveable set their T and VT to be equal to
--- the corresponding 'Major' T and VT, plus some defined offset.
--- For finer control over what parts of T and VT are inherited, xy_bond, wh_bond, and r_bond can be set to one of
--- 'Strong' or 'Weak'. Strong simply copies the values, Weak allows the 'Minor' moveable to calculate their own.
--- @field role balatro.Moveable.Role
--- Alignment parameters to use when aligning to Major role.
--- @field alignment balatro.Moveable.Alignment
--- The pinch table is used to modify the VT.w and VT.h compared to T.w and T.h. If either x or y pinch is
--- Set to true, the VT width and or height will ease to 0. If pinch is false, they ease to T.w or T.h
--- @field pinch { x: boolean, y: boolean }
--- Keep track of the last time this Moveable was moved via :move(dt). When it is successfully moved, set to equal
--- the current G.TIMERS.REAL, and if it is called again this frame, doesn't recalculate move(dt)
--- @field last_moved number
--- Keep track of the last time this Moveable was moved via :move(dt). When it is successfully moved, set to equal
--- the current G.TIMERS.REAL, and if it is called again this frame, doesn't recalculate move(dt)
--- @field last_aligned number
--- Creates zoom effect when the Moveable is hoered (+0.05) / dragged (+0.1)
--- @field zoom boolean?
--- Current use is not found across Balatro code
--- @field static_rotation boolean
---
--- @field offset Position
--- Midpoint for center / middle alignment.
--- If this Moveable's role type is Minor, then setting this to another Moveable allows that Moveable to be used as a center point for alignment.
--- @field Mid balatro.Moveable
--- Shadow effect
--- @field shadow_parrallax Position
--- Element offset
--- @field layered_parallax Position
--- Shadow height. Current effect is unknown
--- @field shadow_height number
--- Juice up effect, created from `:juice_up()`
--- @field juice? balatro.Moveable.Juice
---
--- True if current Moveable is currently moving with its major.
--- This is set when `move()` is called, when current role is `Minor`,
--- and `xy_bond` or `r_bond` is `Weak`, or not `STATIONARY`, or `NEW_ALIGNMENT`, or `juice`.
--- Current use purpose is used by `Node` for debugging purpose.
--- @field CALCING? boolean
---
--- True if current Moveable is not moving
--- @field STATIONARY? boolean
---
--- @field NEW_ALIGNMENT? boolean
local IMoveable = {}

--- @param X? number
--- @param Y? number
--- @param W? number
--- @param H? number
--- @overload fun(self: self, args: {T: balatro.Node.TransformInit, container: balatro.Node})
function IMoveable:init(X,Y,W,H) end

function IMoveable:draw() end

---Sets the alignment of moveable using roles
---@param args balatro.Moveable.AlignmentArg?
--- - `major` The moveable this moveable will attach to
--- - `bond` The bond type, either 'Strong' or 'Weak'. Strong instantly adjusts VT, Weak manually calculates VT changes
--- - `offset` {x , y} offset from the alignment
--- - `type` the alignment type.
function IMoveable:set_alignment(args) end

--- Aligns this role offset to this major
function IMoveable:align_to_major() end

--- Sets current transformation to given X, Y, W, and H.
--- This also sets visual transformation.
--- @param X number
--- @param Y number
--- @param W number
--- @param H number
function IMoveable:hard_set_T(X, Y, W, H) end

--- Sets current visual transformation to current transformation
function IMoveable:hard_set_VT() end

--- Handles dragging effect.
--- Called by Controller each frame when the current Moveable is currently dragged.
--- @param offset Position
function IMoveable:drag(offset) end

--- Creates a pulse (juice up) effect.
--- @param amount? number Scale amount, defaults to `
--- @param rot_amt? number Rotation amount, defaults to -0.6 ot +0.6
function IMoveable:juice_up(amount, rot_amt) end

--- Handles juice up effect.
--- Automatically called by `move` or `move_with_major`.
function IMoveable:move_juice() end

--- Handles moving this node.
--- @param dt number
function IMoveable:move(dt) end

--- Clamps left and right.
function IMoveable:lr_clamp() end

--- Copies transformation effect from major.
--- @param major_tab balatro.Moveable
function IMoveable:glue_to_major(major_tab) end

--- Moves current Moveable with current Major, only when current role is Minor
--- @param dt number
function IMoveable:move_with_major(dt) end

--- @param dt number
function IMoveable:move_xy(dt) end

---- @param dt number
function IMoveable:move_scale(dt) end

--- @param dt number
function IMoveable:move_wh(dt) end

--- @param dt number
--- @param vel Position
function IMoveable:move_r(dt, vel) end

function IMoveable:calculate_parrallax() end

--- @param args balatro.Moveable.RoleArg
function IMoveable:set_role(args) end

--- @return balatro.Node.Frame.Major
function IMoveable:get_major() end

function IMoveable:remove() end

--- @type balatro.Moveable | fun(X?: number, Y?: number, W?: number, H?: number): balatro.Moveable | fun(args: {T: balatro.Node.TransformInit, container: balatro.Node}): balatro.Moveable
Moveable = function() end

--- @class balatro.Moveable.Velocity: Position
--- @field r number
--- @field scale number
--- @field mag number

--- @class balatro.Moveable.Role
--- @field role_type 'Major' | 'Minor' Major dictates movement, Minor is welded to some major
--- @field offset Position Offset from Minor to Major
--- @field major? balatro.Moveable
--- @field draw_major? balatro.Moveable
--- @field xy_bond 'Strong' | 'Weak'
--- @field wh_bond 'Strong' | 'Weak'
--- @field r_bond 'Strong' | 'Weak'
--- @field scale_bond 'Strong' | 'Weak'

--- @class balatro.Moveable.Alignment
--- @field type balatro.Moveable.AlignmentType
--- @field offset Position
--- @field prev_type balatro.Moveable.AlignmentType
--- @field prev_offset Position
--- @field lr_clamp? boolean
--- @field type_list? table<'a' | 'm' | 'c' | 'b' | 't' | 'l' | 'r' | 'i'>

--- @class balatro.Moveable.AlignmentArg
--- @field major? balatro.Moveable
--- @field offset? Position
--- @field bond? 'Weak' | 'Strong'
--- @field type? balatro.Moveable.AlignmentType
--- @field xy_bond? balatro.Moveable.AlignmentType
--- @field wh_bond? balatro.Moveable.AlignmentType
--- @field r_bond? balatro.Moveable.AlignmentType
--- @field scale_bond? balatro.Moveable.AlignmentType
--- @field lr_clamp? boolean

--- @class balatro.Moveable.RoleArg
--- @field role_type 'Major' | 'Minor'? Major dictates movement, Minor is welded to some major
--- @field offset Position? Offset from Minor to Major
--- @field major? balatro.Moveable
--- @field draw_major? balatro.Moveable
--- @field xy_bond? 'Strong' | 'Weak'
--- @field wh_bond? 'Strong' | 'Weak'
--- @field r_bond? 'Strong' | 'Weak'
--- @field scale_bond? 'Strong' | 'Weak'

--- @class balatro.Moveable.Juice
--- @field handled_elsewhere? boolean
--- @field scale number
--- @field scale_amt number
--- @field r number
--- @field r_amt number
--- @field start_time number
--- @field end_time number

--- - Vertical options:
---   - `c`- center,
---   - `t`- top,
---   - `b`- bottom.
--- - Horizontal options:
---   - `l` - left,
---   - `m` - middle,
---   - `r` - right.
---   - `i` for inner
--- - Exactly "a": Do not align
--- @alias balatro.Moveable.AlignmentType "a" | "m" | "c" | "b" | "t" | "l" | "r" | "i" | string

-- More info on Moveable's Mid, because this is too big to fit in LSP
-- e.g. #1=Major, #2=Minor (align = cm), #3=Minor (align = br)
-- ```
-- #1
-- +---------+
-- | #2      |
-- | +-----+ |
-- | |     | |
-- | |  #3 | |
-- | |  +-+| |
-- | |  | || |
-- | |  +-+| |
-- | +-----+ |
-- |         |
-- +---------+
-- ```
-- When #2's mid is set to #3, then it should look like:
-- ```
-- #1
-- +---------+
-- |+-----+  |
-- ||     |  |
-- ||  #3 |  |
-- ||  +-+|  |
-- ||  | ||  |
-- ||  +-+|  |
-- |+-----+  |
-- |#2       |
-- |         |
-- +---------+
-- ```
-- where #3 is used as a center point for #2.