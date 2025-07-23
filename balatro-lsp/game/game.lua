--- @meta

--- @class balatro.Game: balatro.Object
local IGame = {}

--- Sets global G.
--- Calls set_globals(), implemented in globals.lua
---
--- @see balatro.Global
function IGame:init() end

--- Called when love.load() is executed.
--- - Loads settings
---   - Set suit color
---   - Set graphics texture scaling
---   - Sets language
--- - Loads sounds (resources/sounds) to memory
--- - Initializes window
--- - Makes sound manager if `F_SOUND_THREAD` is true
--- - Makes save manager
--- - Makes HTTP manager
--- - Loads shaders
--- - Makes controller manager
--- - Loads profile
--- - Sets render settings
--- - Initialize item prototypes
--- - Makes shared sprites
--- - Makes event manager
--- - Sets progile progress
--- - Shows splash screen
---
--- @see balatro.Game.init_window
--- @see balatro.SoundManager
--- @see balatro.SaveManager
--- @see balatro.HttpManager
--- @see balatro.Controller
--- @see balatro.Game.load_profile
--- @see balatro.Game.set_render_settings
--- @see balatro.Game.set_language
--- @see balatro.Game.init_item_prototypes
--- @see balatro.Game.splash_screen
function IGame:start_up() end

--- Load item prototypes.
--- @see balatro.GameDefs.InitItemProto
function IGame:init_item_prototypes() end

--- Loads profile
--- @param profile number Which profile to load, 1 or 2 or 3
function IGame:load_profile(profile) end

--- Set languages.
--- Tnitializes LANGAUGES and FONTS if not exist.
--- @see balatro.GameDefs.Language
function IGame:set_language() end

--- Initializes animation atlas and asset atlas
function IGame:set_render_settings() end

--- Creates window configuration.
--- Also calls `G.FUNCS.apply_window_changes`
function IGame:init_window(reset) end

--- Removes all game UI
function IGame:delete_run() end

--- Queues to save progress (settings `G.SETTINGS` and profile `G.PROFILES[profile]`)
function IGame:save_progress() end

function IGame:save_notify(card) end

--- Queues to save settings (`G.SETTINGS`)
function IGame:save_settings() end

--- Queues to save metrics (`G.METRICS`)
function IGame:save_metrics() end

--- Prepares new `G.ROOM` and `G.ROOM_ATTACH`.
--- if `new_game_obj` is true, sets `G.GAME` to `init_game_object()`
--- @param new_stage balatro.Game.StagesObject
--- @param new_state balatro.Game.StateObject
function IGame:prep_stage(new_stage, new_state, new_game_obj) end

function IGame:sandbox() end

--- Shows splash screen
function IGame:splash_screen() end

--- Shows main menu
--- @param change_context? 'game' | 'splash' 'splash' if from splash, 'game' if from game
function IGame:main_menu(change_context) end

--- Shows demo end screen, showing link to "playbalatro.com"
function IGame:demo_cta() end

--- @return balatro.Game.Current
function IGame:init_game_object() end

--- @class balatro.Game.StartRunArg
--- @field stake? number
--- @field savetext? balatro.Game.Current
--- @field challenge? balatro.Challenge
--- @field seed string?

--- Starts a new / saved run
--- @param args? balatro.Game.StartRunArg
function IGame:start_run(args) end

function IGame:update(dt) end

function IGame:draw() end

--- Gets color state, used for debugging
--- @param _state number
function IGame:state_col(_state) end

function IGame:update_selecting_hand(dt) end
function IGame:update_shop(dt) end
function IGame:update_play_tarot(dt) end
function IGame:update_hand_played(dt) end
function IGame:update_draw_to_hand(dt) end
function IGame:update_new_round(dt) end
function IGame:update_blind_select(dt) end
function IGame:update_round_eval(dt) end
function IGame:update_arcana_pack(dt) end
function IGame:update_spectral_pack(dt) end
function IGame:update_standard_pack(dt) end
function IGame:update_buffoon_pack(dt) end
function IGame:update_celestial_pack(dt) end
function IGame:update_game_over(dt) end
function IGame:update_menu(dt) end

--- @class balatro.Game: balatro.Game.AfterStartUp

--- Only exists after `Game:start_up()`
--- @class balatro.Game.AfterStartUp: balatro.Game.SharedSprites
--- @field SHADERS balatro.Game.Shaders
--- @field CURSOR  balatro.Sprite
--- @field STAGE_OBJECT_INTERRUPT boolean
--- @field E_MANAGER balatro.EventManager
--- @field SPEEDFACTOR number
--- @field CONTROLLER balatro.Controller

--- Shared sprites only exists after `Game:start_up()`
--- @class balatro.Game.SharedSprites
--- @field shared_soul balatro.Sprite
--- @field shared_undiscovered_joker balatro.Sprite
--- @field shared_undiscovered_tarot balatro.Sprite
--- @field shared_sticker_eternal balatro.Sprite
--- @field shared_sticker_perishable balatro.Sprite
--- @field shared_sticker_rental balatro.Sprite
--- @field shared_stickers {White: balatro.Sprite, Red: balatro.Sprite, Green: balatro.Sprite, Black: balatro.Sprite, Blue: balatro.Sprite, Purple: balatro.Sprite, Orange: balatro.Sprite, Gold: balatro.Sprite}
--- @field shared_seals {Gold: balatro.Sprite, Purple: balatro.Sprite, Red: balatro.Sprite, Blue: balatro.Sprite}
--- @field sticker_map string[]

--- @class balatro.Game.Shaders: { [string]: love.Shader }
--- @field CRT love.Shader
--- @field background love.Shader
--- @field booster love.Shader
--- @field debuff love.Shader
--- @field dissolve love.Shader
--- @field flame love.Shader
--- @field flash love.Shader
--- @field foil love.Shader
--- @field gold_seal love.Shader
--- @field holo love.Shader
--- @field hologram love.Shader
--- @field negative love.Shader
--- @field negative_shine love.Shader
--- @field played love.Shader
--- @field polychrome love.Shader
--- @field skew love.Shader
--- @field splash love.Shader
--- @field vortex love.Shader
--- @field voucher love.Shader

--- @type balatro.Game | fun(): balatro.Game
Game = function() end

--- @type balatro.Game
G = IGame
