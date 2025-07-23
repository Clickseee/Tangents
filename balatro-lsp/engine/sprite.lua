--- @meta

--- @class balatro.Sprite: balatro.Moveable
--- Sprite atlas
--- @field atlas balatro.AssetAtlas
--- Sprite scaling.
--- Defaults to px and py from given atlas
--- @field scale Position
--- Scaling factor for the sprite.
--- The larger, the smaller the sprite becomes.
--- @field scale_mag number
--- Sprite position, in atlas dimension unit.
--- If atlas dimension is (10 x 15) and pos is (1,2) then the QUad position will be (10, 30)
--- @field sprite_pos balatro.Sprite.SpritePos
--- Used for comparison when drawing if the position differs from `sprite_pos`.
--- @field sprite_pos_copy Position
--- Sprite quad
--- @field sprite love.Quad
--- Image dimensions, from atlas' image dimensions
--- @field image_dims [number, number]
--- Shader draw steps for this sprite
--- @field draw_steps balatro.Sprite.DrawStepDefined[]
--- @field video? love.Video
--- @field video_dims? WidthHeight
local ISprite = {}

--- @param X number
--- @param Y number
--- @param W number
--- @param H number
--- @param new_sprite_atlas balatro.AssetAtlas
--- @param sprite_pos balatro.Sprite.SpritePos
function ISprite:init(X, Y, W, H, new_sprite_atlas, sprite_pos) end

function ISprite:reset() end

--- Sets sprite position.
---
--- Note that X and Y is in atlas dimension unit,
--- See the `sprite_pos` property for more info.
--- @param sprite_pos? balatro.Sprite.SpritePos
function ISprite:set_sprite_pos(sprite_pos) end

--- Gets pixel position
--- @return [number, number, number, number] dim X, Y, W, H
function ISprite:get_pos_pixel() end

--- Gets texture dimensions
--- @return [number, number] dim
function ISprite:get_image_dims() end

--- Creates shader draw steps for this sprite
--- @param draw_step_definitions balatro.Sprite.DrawStep[]
function ISprite:define_draw_steps(draw_step_definitions) end

--- Draws the sprite using specified shader
--- @param _shader string Shader key. This should be a valid key from `G.SHADERS`. Defaults to `dissolve`
--- @param _shadow_height? number
--- @param _send? any What to send to the shader. If `custom_shader` is `true`, this should be an array.
--- @param _no_tilt? boolean
--- @param other_obj? balatro.Sprite Other sprite to draw on this sprite
--- @param ms? number Only used when `other_obj` is specified. Scaling for other sprite.
--- @param mr? number Only used when `other_obj` is specified. Rotation for other sprite.
--- @param mx? number Only used when `other_obj` is specified. X offset for other sprite.
--- @param my? number Only used when `other_obj` is specified. Y offset for other sprite.
--- @param custom_shader? boolean If specified, uses `_send` as an array to send values to the shader
--- @param tilt_shadow? number
--- @overload fun(self: self, _shader: string, _shadow_height?: number, _send: balatro.Sprite.SendArray[], _no_tilt?: boolean, other_obj?: balatro.Sprite, ms?: number, mr?: number, mx?: number, my?: number, custom_shader: true, tilt_shadow?: number)
function ISprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow) end

--- @param overlay?  ColorHex
function ISprite:draw_self(overlay) end

--- @param overlay?  ColorHex
function ISprite:draw(overlay) end

--- Draws a sprite from other sprite, with applied transformation from this sprite.
--- Commonly used by seals
--- @param other_obj balatro.Sprite
--- @param ms? number Scale
--- @param mr? number Rotation
--- @param mx? number X offset
--- @param my? number Y offset
function ISprite:draw_from(other_obj, ms, mr, mx, my) end

function ISprite:remove() end

--- @type balatro.Sprite | fun(X: number, Y: number, W: number, H: number, new_sprite_atlas: balatro.Atlas, sprite_pos: Position): balatro.Sprite
Sprite = function() end

--- @class balatro.Sprite.SendArray
--- @field name string
--- @field value? any
--- @field func? fun(): any
--- @field ref_table? any
--- @field ref_value? any

--- @class balatro.Sprite.SpritePos: Position
--- @field v? number If set, randomly sets X from 0 to v

--- @class balatro.Sprite.DrawStep
--- @field shader string? Defaults to dissolve
--- @field shadow_height? number
--- @field send? any
--- @field no_tilt? boolean
--- @field other_obj? balatro.Sprite Other sprite to draw on this sprite
--- @field ms? number Only used when `other_obj` is specified. Scaling for other sprite.
--- @field mr? number Only used when `other_obj` is specified. Rotation for other sprite.
--- @field mx? number Only used when `other_obj` is specified. X offset for other sprite.
--- @field my? number Only used when `other_obj` is specified. Y offset for other sprite.

--- @class balatro.Sprite.DrawStepDefined: balatro.Sprite.DrawStep
--- @field shader string
