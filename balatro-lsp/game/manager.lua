--- @class balatro.Game
--- @field HTTP_MANAGER balatro.Game.ManagerIO
--- @field SAVE_MANAGER balatro.Game.ManagerOutput
--- @field SOUND_MANAGER balatro.Game.SoundManager

--- @class balatro.Game.ManagerIO
--- @field in_channel love.Channel
--- @field out_channel love.Channel
--- @field thread love.Thread

--- @class balatro.Game.ManagerOutput
--- @field channel love.Channel
--- @field thread love.Thread

--- @class balatro.Game.SoundManager: balatro.Game.ManagerOutput
--- @field load_channel love.Channel
--- @field thread love.Thread
