-- INSTRUCTIONS
-- Just put the name of the image
-- Image must be a PNG and it's name must start with "bgc_"
-- But the "bgc_" and the ".png" should not be included in the list.


-- Backgrounds for the main menu
local main_menu_keys = {
	"main_menu",
}

-- Backgrounds for mid-run
local run_keys = {
	"run",
	"main_menu",
}
























-- BEHIND THE COURTAIN
-- SPAGHETTI GALORE

function register_key(key)
	SMODS.Atlas({
		key = key,
		path = "bgc_" .. key .. ".png",
		px = 1920,
		py = 1080,
	})
end

function register_keys(keys)
	for _, key in pairs(keys) do
		if not G.ASSET_ATLAS["bgc_" .. key] then
			register_key(key)
		end
	end
end

register_keys(main_menu_keys)
register_keys(run_keys)

local main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
	local ret = main_menu_ref(self, change_context)

	set_background(main_menu_keys)

	return ret
end

local start_run_ref = Game.start_run
function Game:start_run(args)
	start_run_ref(self, args)

	set_background(run_keys)
end


function set_background(atlas_keys)
	if (G.SPLASH_BACK) then
		G.SPLASH_BACK:remove()
		G.SPLASH_BACK = nil
	end

	local atlas_key = atlas_keys[math.random(#atlas_keys)]

	G.SPLASH_BACK = Sprite(-30, -13, G.ROOM.T.w+41, G.ROOM.T.h+15, G.ASSET_ATLAS["bgc_" .. atlas_key], {x = 0, y = 0})

	G.SPLASH_BACK:set_alignment({
		major = G.ROOM_ATTACH,
		type = 'cm',
		offset = {x=0,y=0}
	})
end