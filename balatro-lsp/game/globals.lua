--- @type string
VERSION = ""

--- @class balatro.Game: balatro.Global

--- @class balatro.Global: balatro.Global.FeatureFlags, balatro.Global.RenderScale, balatro.Global.State, balatro.Global.Constants, balatro.Global.Instances, balatro.Game.AfterStartUp
--- @field SEED number
--- @field TIMERS balatro.Timers
--- @field exp_times balatro.ExpTimes
--- @field SETTINGS balatro.Settings
--- @field COLLABS balatro.Global.Collabs
--- @field METRICS balatro.Metrics Unused
--- @field PROFILES balatro.Profile[]
--- @field STATES balatro.Game.StateObject
--- @field STAGES balatro.Game.StagesObject
--- @field UIT balatro.UITypeObject
--- @field handlist string[]
--- @field button_mapping table<love.GamepadButton, string|nil>
--- @field keybind_mapping table<love.KeyConstant, love.GamepadButton>[]

--- @class balatro.Global.Collabs
--- @field pos { Jack: Position, Queen: Position, King: Position }
--- @field options CardSuit<string[]>

--- @class balatro.Global.FeatureFlags
--- @field F_QUIT_BUTTON boolean              Feature: Include the main menu 'Quit' button
--- @field F_SKIP_TUTORIAL boolean            Feature: Completely skip the tutorial on fresh save
--- @field F_BASIC_CREDITS boolean            Feature: Remove references to Daniel Linssens itch.io
--- @field F_EXTERNAL_LINKS boolean           Feature: Remove all references to any external links (mainly for console)
--- @field F_ENABLE_PERF_OVERLAY boolean      Feature: Disable debugging tool for performance of each frame
--- @field F_NO_SAVING boolean                Feature: Disables all 'run' saving
--- @field F_MUTE boolean                     Feature: Force mute all sounds
--- @field F_SOUND_THREAD boolean             Feature: Have sound in a separate thread entirely - if not sounds will run on main thread
--- @field F_VIDEO_SETTINGS boolean           Feature: Let the player change their video settings
--- @field F_CTA boolean                      Feature: Call to Action video for the Demo - keep this as false
--- @field F_VERBOSE boolean                  Feature: Extra debug information on screen and in the console
--- @field F_HTTP_SCORES boolean              Feature: Include HTTP scores to fetch/set high scores
--- @field F_RUMBLE boolean                   Feature: Add rumble to the primary controller - adjust this for amount of rumble
--- @field F_CRASH_REPORTS boolean            Feature: Send Crash reports over the internet
--- @field F_NO_ERROR_HAND boolean            Feature: Hard crash without error message screen
--- @field F_SWAP_AB_PIPS boolean             Feature: Swapping button pips for A and B buttons (mainly for switch)
--- @field F_SWAP_AB_BUTTONS boolean          Feature: Swapping button function for A and B buttons (mainly for switch)
--- @field F_SWAP_XY_BUTTONS boolean          Feature: Swapping button function for X and Y buttons (mainly for switch)
--- @field F_NO_ACHIEVEMENTS boolean          Feature: Disable achievements
--- @field F_DISP_USERNAME boolean            Feature: If a username is required to be displayed in the main menu, set this value to that name
--- @field F_ENGLISH_ONLY boolean             Feature: Disable language selection - only in english
--- @field F_GUIDE boolean                    Feature: Replace back/select button with 'guide' button
--- @field F_JAN_CTA boolean                  Feature: Call to action for Jan demo
--- @field F_HIDE_BG boolean                  Feature: Hiding the game objects when paused
--- @field F_TROPHIES boolean                 Feature: use 'trophy' terminology instead of 'achievemnt'
--- @field F_PS4_PLAYSTATION_GLYPHS boolean   Feature: use PS4 glyphs instead of PS5 glyphs for PS controllers
--- @field F_LOCAL_CLIPBOARD boolean          Feature: Use G.CLIPBOARD instead of love.system.setClipboardText
--- @field F_SAVE_TIMER number                Undocumented Feature
--- @field F_MOBILE_UI boolean                Feature: Scale desc to 1.5
--- @field F_HIDE_BETA_LANGS boolean          Undocumented Feature
--- @field F_DISCORD boolean                  Feature: Enable Discord button
--- @field F_STREAMER_EVENT boolean           Feature: Sends score to be used in `send_score`

--- @class balatro.Global.RenderScale
--- @field TILESIZE number
--- @field TILESCALE number
--- @field TILE_W number
--- @field TILE_H number
--- @field DRAW_HASH_BUFF number
--- @field CARD_W number
--- @field CARD_H number
--- @field HIGHLIGHT_H number
--- @field COLLISION_BUFFER number
--- @field PITCH_MOD number

--- @class balatro.Global.State
--- @field STAGE balatro.Game.StagesEnum
--- @field STATE balatro.Game.StateEnum
--- @field STAGE_OBJECTS balatro.Node[][]
--- @field TAROT_INTERRUPT balatro.Game.StateEnum
--- @field STATE_COMPLETE boolean

--- @class balatro.Global.Constants
--- @field MIN_CLICK_DIST number
--- @field MIN_HOVER_TIME number
--- @field DEBUG boolean
--- @field ANIMATION_FPS number
--- @field VIBRATION number
--- @field CHALLENGE_WINS number

--- @class balatro.Global.Instances
--- @field ARGS table
--- @field FUNCS balatro.Global.Functions
--- @field I balatro.Global.Instances.I
--- @field ANIMATION_ATLAS balatro.AnimationAtlas[]
--- @field ASSET_ATLAS balatro.AssetAtlas[]
--- @field MOVEABLES balatro.Moveable[]
--- @field ANIMATIONS balatro.Sprite[]
--- @field DRAW_HASH balatro.Node[]

--- @class balatro.Global.Functions: { [string]: fun(...) }

--- @class balatro.Global.Instances.I
--- @field NODE balatro.Node[]
--- @field MOVEABLE balatro.Moveable[]
--- @field SPRITE balatro.Sprite[]
--- @field UIBOX balatro.UIBox[]
--- @field POPUP balatro.Node[]
--- @field CARD balatro.Card[]
--- @field CARDAREA balatro.CardArea[]
--- @field ALERT balatro.Node[] Unused

--- @alias balatro.Global.Instances.InstanceType 'NODE' | 'MOVEABLE' | 'SPRITE' | 'UIBOX' | 'POPUP' | 'CARD' | 'CARDAREA' | 'ALERT' | 'POPUP'

--- @class balatro.Atlas
--- @field name string
--- @field image love.Image
--- @field px number
--- @field py number

--- @class balatro.Timers: { [string]: number }
--- @field TOTAL number
--- @field REAL number
--- @field REAL_SHADER number
--- @field UPTIME number
--- @field BACKGROUND number

--- @alias balatro.TimerType 'TOTAL' | 'REAL' | 'REAL_SHADER' | 'UPTIME' | 'BACKGROUND'

--- @class balatro.ExpTimes
--- @field xy number
--- @field scale number
--- @field r number

--- @class balatro.AnimationAtlas: balatro.Atlas
--- @field frames number

--- @class balatro.AssetAtlas: balatro.Atlas
--- @field type unknown

--- @enum balatro.Game.StateEnum
local _a = {
    SELECTING_HAND = 1,
    HAND_PLAYED = 2,
    DRAW_TO_HAND = 3,
    GAME_OVER = 4,
    SHOP = 5,
    PLAY_TAROT = 6,
    BLIND_SELECT = 7,
    ROUND_EVAL = 8,
    TAROT_PACK = 9,
    PLANET_PACK = 10,
    MENU = 11,
    TUTORIAL = 12,
    SPLASH = 13,--DO NOT CHANGE, this has a dependency in the SOUND_MANAGER
    SANDBOX = 14,
    SPECTRAL_PACK = 15,
    DEMO_CTA = 16,
    STANDARD_PACK = 17,
    BUFFOON_PACK = 18,
    NEW_ROUND = 19
}

--- @enum balatro.Game.StagesEnum
local _b = {
    MAIN_MENU = 1,
    RUN = 2,
    SANDBOX = 3
}

--- @enum balatro.UITypeEnum
local _c = {
    --- Text UI (text, colour, scale)
    T=1,
    --- Box / rounded box
    B=2,
    --- Column
    C=3,
    --- Row
    R=4,
    --- Object contains Node (Sprite, Card, CardArea, DynaText)
    O=5,
    --- Root (Top level node of every UIBox)
    ROOT=7,
    --- Slider
    S=8,
    --- Text input
    I=9,
    --- default padding
    padding = 0,
}

--- @class balatro.Game.StateObject
local _a = {
    SELECTING_HAND = 1,
    HAND_PLAYED = 2,
    DRAW_TO_HAND = 3,
    GAME_OVER = 4,
    SHOP = 5,
    PLAY_TAROT = 6,
    BLIND_SELECT = 7,
    ROUND_EVAL = 8,
    TAROT_PACK = 9,
    PLANET_PACK = 10,
    MENU = 11,
    TUTORIAL = 12,
    SPLASH = 13,--DO NOT CHANGE, this has a dependency in the SOUND_MANAGER
    SANDBOX = 14,
    SPECTRAL_PACK = 15,
    DEMO_CTA = 16,
    STANDARD_PACK = 17,
    BUFFOON_PACK = 18,
    NEW_ROUND = 19
}

--- @class balatro.Game.StagesObject
local _b = {
    MAIN_MENU = 1,
    RUN = 2,
    SANDBOX = 3
}

--- @class balatro.UITypeObject
local _c = {
    --- Text UI (text, colour, scale)
    T=1,
    --- Box / rounded box
    B=2,
    --- Column
    C=3,
    --- Row
    R=4,
    --- Object contains Node (Sprite, Card, CardArea, DynaText)
    O=5,
    --- Root (Top level node of every UIBox)
    ROOT=7,
    --- Slider
    S=8,
    --- Text input
    I=9,
    --- default padding
    padding = 0,
}

function Game:set_globals() end