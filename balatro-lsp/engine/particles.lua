--- @meta

--- @class balatro.Particles: balatro.Moveable
--- If true, the particle will spawn in an area instead of a single spot
--- @field fill? boolean
--- Padding. Higher value means tighter area. Lower value (negative) means more area.
--- Only effective if `fill` is `true`
--- @field padding number
--- Attached Moveable
--- @field parent? balatro.Moveable
--- Delay in seconds before creating a new particle
--- @field timer number
--- Timer type to use
--- @field timer_type balatro.TimerType
--- Last time when a particle is created
--- @field last_real_time number
--- Currently unused
--- @field last_drawn number
--- Particle duration in seconds
--- @field lifespan number
--- Alpha on draw
--- @field fade_alpha number
--- Particle velocity
--- @field speed number
--- Maximum number of particle
--- @field max number
--- Maixmum number of particles _on pulse_.
--- Used to create some particles after specified maximum.
--- @field pulse_max number
--- Number of created particles _on pulse_.
--- Always goes up wwhen a particle is created
--- @field pulsed number
--- Particle velocity variation, 1 = 0-1, 0 = no variation
--- @field vel_variation number
--- Particle scale
--- @field scale number
--- Particle colors
--- @field colours ColorHex[]
--- Particles created
--- @field particles balatro.Particles.Particle[]
local IParticles = {}

--- @param X number
---@param Y number
---@param W number
---@param H number
---@param config balatro.Particles.Config
function IParticles:init(X, Y, W, H, config) end

---- @param dt number
function IParticles:update(dt) end

--- @param dt number
function IParticles:move(dt) end

--- @param delay? number
--- @param to? number
function IParticles:fade(delay, to) end

--- @param alpha? number
function IParticles:draw(alpha) end

function IParticles:remove() end

--- @type balatro.Particles | fun(X: number, Y: number, W: number, H: number, config: balatro.Particles.Config): balatro.Particles
Particles = function() end

--- @class balatro.Particles.Particle
--- @field draw boolean
--- @field dir number
--- @field facing number
--- @field size number
--- @field age number
--- @field velocity number
--- @field r_vel number
--- @field e_vel number
--- @field e_prev number
--- @field e_curr number
--- @field scale number
--- @field visible_scale number
--- @field time number
--- @field colour ColorHex
--- @field offset Position

--- @class balatro.Particles.Config
--- If true, the particle will spawn in an area instead of a single spot
--- @field fill? boolean
--- Padding. Higher value means tighter area. Lower value (negative) means more area.
--- Only effective if `fill` is `true`
--- @field padding? number
--- Where to attach this particle at.
--- This will transform the particle (X, Y, W, H, R) accordingly to attached Moveable.
--- @field attach? balatro.Moveable
--- Delay in seconds before creating a new particle.
--- Defaults to `0.5`
--- @field timer? number
--- Timer type to use.
--- Defaults to `REAL`
--- @field timer_type? balatro.TimerType
--- Particle lifespan, in seconds.
--- Changing this value will affect scaling speed on particles.
--- @field lifespan? number
--- Velocity speed modifier.
--- @field speed? number
--- Maximum number of particles
--- @field max? number
--- Maximum number of created particles _on pulse_.
--- This allows creation of particles when this hits maximum particle limit.
--- Counter goes up everytime a particle is created.
--- Defaults to 0. Maximum is 20.
--- @field pulse_max? number
--- Velocity variation. Determines how random the particle speed.
--- Defaults to 1. Set to 0 for no speed randomness
--- @field vel_variation? number
--- Particle scaling.
--- Defaults to 1
--- @field scale? number
--- Particle colors
--- @field colours? ColorHex[]
--- If true, this Particle may have some preexisting particles upon creation
--- @field initialize? boolean