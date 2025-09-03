-- HUGE shoutout to the following people for their help:
-- Aikoyori for the SMODS.Font stuff
-- Modding developers for helping me along the way
-- Especially Somethingcom515, N', and BepisFever for the HUGE help
-- And of course, the people who play the mod, and the people who play the mod's mod, and the mod's mod's mod.

wankers = 0
dicks = 0

--- Talisman compat
to_big = to_big or function(num)
    return num
end

to_number = to_number or function(num)
    return num
end

tangentry = SMODS.current_mod

G.nxkoo_dies = {
    discord_timer = 0,
    discord_interval = 120,
    discord_chance = 0.01,
    show_explosion = false,
    explosion_timer = 0,
    explosion_frames = {},
    current_frame = 1,
    frame_timer = 0,
    frame_delay = 0.075,
    trigger_sound = "tngt_neverforget",
    show_mustard = false,
    mustard_timer = 0,
    show_image = false,
    image_timer = 0,
    show_flashbang = false,
    flashbang_timer = 0,
    current_flashbang = nil,
    default_flashbang = string.sub(SMODS.current_mod.path, string.find(SMODS.current_mod.path, "Mods")) ..
        "/assets/customimages/jumpscare_2.png",
    path = SMODS.current_mod.path,
    flashbangs = {
        shop = "shop_flashbang.png",
        blind = "blind_flashbang.png",
        hand_played = "hand_flashbang.png",
        discard = "discard_flashbang.png",
        round_start = "round_flashbang.png",
        joker_trigger = "joker_flashbang.png"
    },
    theworldcrispiestfries = {
        "Are these.. the world's",
        "crispiest fries? Let's find out.",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
        "...",
    },
    desc_sprites = {
        soul = {
            atlas = "tngt_descsprite",
            pos = { x = 0, y = 0 },
            w = 0.3,
            h = 0.3,
        },
        susie = {
            atlas = "tngt_descsprite",
            pos = { x = 1, y = 0 },
            w = 0.3,
            h = 0.3,
        }
    }
}

tangentry.optional_features = function()
    return {
        quantum_enhancements = true,
        post_trigger = true -- for flashbang
    }
end

for i = 1, 12 do
    local img_path = G.nxkoo_dies.path .. "assets/customimages/explosion_" .. i .. ".png"
    G.nxkoo_dies.explosion_frames[i] = love.graphics.newImage(NFS.newFileData(img_path))
    local original_play_sound = play_sound
    function play_sound(key, volume, pitch)
        original_play_sound(key, volume, pitch)

        if key == G.nxkoo_dies.trigger_sound then
            G.nxkoo_dies:start_explosion()
        end
    end

    function G.nxkoo_dies:start_explosion()
        self.show_explosion = true
        self.explosion_timer = 0.5
        self.current_frame = 1
        self.frame_timer = 0
    end

    function G.nxkoo_dies:update_explosion(dt)
        if not self.show_explosion then return end
        self.explosion_timer = self.explosion_timer - dt
        if self.explosion_timer <= 0 then
            self.show_explosion = false
            return
        end
        self.frame_timer = self.frame_timer + dt
        if self.frame_timer >= self.frame_delay then
            self.frame_timer = 0
            self.current_frame = self.current_frame + 1
            if self.current_frame > #self.explosion_frames then
            self.current_frame = 1
            end
        end
    end

    function G.nxkoo_dies:draw_explosion()
        if not self.show_explosion then return end

        local frame = self.explosion_frames[self.current_frame]
        if frame then
            local scale_x = love.graphics.getWidth() / 1920
            local scale_y = love.graphics.getHeight() / 1080

            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(frame, 0, 0, 0, scale_x, scale_y)
        end
    end
end
local original_update = Game.update
function Game:update(dt)
    original_update(self, dt)
    G.nxkoo_dies:update_explosion(dt)
end

local original_draw = love.draw
function love.draw()
    original_draw()
    G.nxkoo_dies:draw_explosion()
end

G.C.UI.CONFIG_EMBOSS = HEX("4c5257")
function create_toggle_spec(args)
    args = args or {}
    args.active_colour = args.active_colour or G.C.RED
    args.inactive_colour = args.inactive_colour or G.C.BLACK
    args.w = args.w or 6
    args.h = args.h or 5
    args.scale = args.scale or 1
    args.label = args.label or 'shake yo booty?'
    args.desc = args.desc or nil
    args.label_scale = args.label_scale or 1.5
    args.desc_scale = args.desc_scale or 1
    args.ref_table = args.ref_table or {}
    args.ref_value = args.ref_value or 'test'

    local check = Sprite(0, 0, 0.5 * args.scale, 0.5 * args.scale, G.ASSET_ATLAS["icons"], { x = 1, y = 0 })
    check.states.drag.can = false
    check.states.visible = false

    local info = nil
    if args.info then
        info = {}
        for k, v in ipairs(args.info) do
            table.insert(info, {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.05 },
                nodes = {
                    { n = G.UIT.T, config = { text = v, scale = 0.25, colour = G.C.UI.TEXT_LIGHT } }
                }
            })
        end
        info = { n = G.UIT.R, config = { align = "cm", minh = 0.05 }, nodes = info }
    end

    local tyesd = nil

    if args.desc ~= nil then
        tyesd = {
            n = G.UIT.R,
            config = { align = "cm", minw = args.w },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cl", minw = args.w + .2 },
                    nodes = SMODS.localize_box(loc_parse_string(args.desc),
                        { scale = args.desc_scale, colour = G.C.BLACK, align = "cl" })

                },
            }
        }
    end

    local t =
    {
        n = args.col and G.UIT.C or G.UIT.R,
        config = { align = "cm", r = .1, colour = G.C.UI.CONFIG_EMBOSS, emboss = 0.05, w = 100, focus_args = { funnel_from = true } },
        nodes = {
            {
                n = args.col and G.UIT.C or G.UIT.R,
                config = { align = "cl", padding = .1, focus_args = { funnel_from = true } },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cm", minw = args.w },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cm", minw = args.w },
                                nodes = {
                                    {
                                        n = G.UIT.R,
                                        config = { align = "cl", minw = args.w + .2 },
                                        nodes = SMODS.localize_box(loc_parse_string(args.label),
                                            { scale = args.label_scale, colour = G.C.BLACK, align = "cl" })
                                    },
                                }
                            },
                            tyesd
                        }
                    },
                    {
                        n = G.UIT.C,
                        config = { align = "cr", minw = 0.3 * args.w },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { align = "cr", r = 0.1, colour = G.C.BLACK },
                                nodes = {
                                    {
                                        n = G.UIT.C,
                                        config = {
                                            align = "cm",
                                            r = 0.1,
                                            padding = 0.03,
                                            minw = 0.4 * args.scale,
                                            minh = 0.4 * args.scale,
                                            outline_colour = G.C.WHITE,
                                            outline = 1.2 * args.scale,
                                            line_emboss = 0.5 * args.scale,
                                            ref_table = args,
                                            colour = args.inactive_colour,
                                            button = 'toggle_button',
                                            button_dist = 0.2,
                                            hover = true,
                                            toggle_callback = args.callback,
                                            func = 'toggle',
                                            focus_args = { funnel_to = true }
                                        },
                                        nodes = {
                                            { n = G.UIT.O, config = { object = check } },
                                        }
                                    },
                                }
                            }
                        }
                    },
                }
            },
        }
    }

    if args.info then
        t = {
            n = args.col and G.UIT.C or G.UIT.R,
            config = { align = "cm" },
            nodes = {
                t,
                info,
            }
        }
    end
    return t
end

tangentry.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 10, align = 'cm', padding = 0.1, colour = G.C.BLACK },
        nodes = {
            create_toggle_spec({
                label = "{C:white}Sex?",
                desc =
                "{C:inactive}Pretty self explanatory if you ask me.{}",
                ref_table = tangentry.config,
                ref_value =
                "sex"
            }),
            create_toggle_spec({
                label = "{C:white}Premium Mode",
                desc =
                "{C:inactive}Only available for Discord Nitro user.",
                ref_table = tangentry.config,
                ref_value =
                "premium"
            }),
            create_toggle_spec({
                label = "{X:dark_edition,C:white}HYPERDEATH{} {C:dark_edition}MODE",
                desc = "{C:inactive}Biblically accurate and personalized .exe",
                ref_table =
                    tangentry.config,
                ref_value = "hyperdeath"
            }),
            create_toggle_spec({
                label = "{C:white}Sane person?",
                desc = "{C:inactive}Click this to make your run more immersive",
                ref_table =
                    tangentry.config,
                ref_value = "homosexual"
            }),
            create_toggle_spec({
                label = "{C:white}Homosexual?",
                ref_table =
                    tangentry.config,
                ref_value = "homosexual"
            })
        }
    }
end

--Thank you PERKOLATED and HPR
function Card:resize(mod, force_save)
    self:hard_set_T(self.T.x, self.T.y, self.T.w * mod, self.T.h * mod)
    remove_all(self.children)
    self.children = {}
    self.children.shadow = Moveable(0, 0, 0, 0)
    self:set_sprites(self.config.center, self.base.id and self.config.card)
end

local mainmenuref2 = Game.main_menu
Game.main_menu = function(change_context)
    local ret = mainmenuref2(change_context)

    local newcard = Card(G.title_top.T.x, G.title_top.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty,
        G.P_CENTERS.j_tngt_wherethefuck, { bypass_discovery_center = true })
    G.title_top.T.w = G.title_top.T.w * 1.7675
    G.title_top.T.x = G.title_top.T.x - 0.8
    G.title_top:emplace(newcard)
    newcard:start_materialize()
    newcard:resize(1.1 * 1.2)
    newcard.no_ui = true
    return ret
end

local animatedSprites = {}

function add_animated_sprite(card, config)
    if config and config.increment_pos then
        local add_x = card.children.center.sprite_pos.x + (config.increment_pos.x or 0)
        local add_y = card.children.center.sprite_pos.y + (config.increment_pos.y or 0)
        config.increment_pos = nil
        config.end_pos = { x = add_x, y = add_y }
    end
    if config and config.go_back and not config.saved_pos then
        config.saved_pos = { x = card.children.center.sprite_pos.x, y = card.children.center.sprite_pos.y }
    end
    animatedSprites[#animatedSprites + 1] = { ["card"] = card, ["config"] = config, ["count_delay"] = 0 }
end

function remove_all_running_animation(card)
    for i, v in ipairs(animatedSprites) do
        if v.card == card then table.remove(animatedSprites, i) end
    end
end

function remove_running_animation(card, ids)
    if type(ids) == "table" then
        for _, v in ipairs(ids) do
            remove_running_animation(card, v)
        end
    else
        if not card then
            for i, v in ipairs(animatedSprites) do
                if v.config and v.config.id == id then
                    table.remove(animatedSprites, i); break
                end
            end
        else
            if not ids then
                for i, v in ipairs(animatedSprites) do
                    if v.card == card then
                        table.remove(animatedSprites, i); break
                    end
                end
            else
                for i, v in ipairs(animatedSprites) do
                    if v.card == card and v.config and v.config.id == ids then
                        table.remove(animatedSprites, i); break
                    end
                end
            end
        end
    end
end

function get_running_animation(card, id)
    if not card then
        for _, v in ipairs(animatedSprites) do
            if v.config and v.config.id == id then return v end
        end
    else
        for _, v in ipairs(animatedSprites) do
            if v.card == card and v.config and v.config.id == id then return v end
        end
    end
end

function modify_running_animation(card, id, new_config)
    if not card then
        for i, v in ipairs(animatedSprites) do
            if v.config and v.config.id == id then
                animatedSprites[i]["config"] = new_config
                break
            end
        end
    else
        for i, v in ipairs(animatedSprites) do
            if v.card == card and v.config and v.config.id == id then
                animatedSprites[i]["config"] = new_config
                break
            end
        end
    end
end

function disable_running_animation(card, ids, disable)
    if type(ids) == "table" then
        for _, v in ipairs(ids) do
            disable_running_animation(card, ids, disable)
        end
    else
        if not card then
            for i, v in ipairs(animatedSprites) do
                if v.config and v.config.id == id then
                    animatedSprites[i]["config"]["disabled"] = disable; break
                end
            end
        else
            if not ids then
                for i, v in ipairs(animatedSprites) do
                    if v.card == card then
                        animatedSprites[i]["config"]["disabled"] = disable; break
                    end
                end
            else
                for i, v in ipairs(animatedSprites) do
                    if v.card == card and v.config and v.config.id == ids then
                        animatedSprites[i]["config"]["disabled"] = disable; break
                    end
                end
            end
        end
    end
end

local game_update_ref = Game.update
function Game:update(dt)
    game_update_ref(self, dt)

    if #animatedSprites > 0 then
        for i, v in ipairs(animatedSprites) do
            local card = v.card
            if card and card.children and card.children.center and card.children.center.set_sprite_pos and not v.disabled then
                v.config = v.config or {}

                local frame_delay = v.config.frame_delay or (card.config.center.frame_delay or 0.2)
                local frames = v.config.frames or card.config.center.frames or 10

                local current_x = card.children.center.sprite_pos.x
                local current_y = card.children.center.sprite_pos.y
                local x_until_y = v.config.x_until_y or card.config.center.x_until_y

                local start_pos = (v.config and v.config.start_pos) or (card.config.center.start_pos) or {}
                local end_pos = v.config.end_pos or {}

                local reset_x = start_pos.x or 0
                local reset_y = start_pos.y or 0

                if v.config.atlas and G.ASSET_ATLAS[v.config.atlas] then
                    card.children.center.atlas = G.ASSET_ATLAS[v.config.atlas]
                    card.children.center:set_sprite_pos(card.children.center.sprite_pos)
                end

                if start_pos and not v.set_start_pos then
                    v.set_start_pos = true
                    current_x = start_pos.x or current_x
                    current_y = start_pos.y or current_y
                    card.children.center:set_sprite_pos({ x = current_x, y = current_y })
                end

                v.count_delay = v.count_delay or 0
                v.count_delay = v.count_delay + G.real_dt
                if v.count_delay >= frame_delay then
                    v.count_delay = v.count_delay - frame_delay
                    if v.config.one_shot and end_pos and (end_pos.x or (end_pos.y and x_until_y)) then
                        if end_pos.y and x_until_y then
                            if end_pos.y == current_y then
                                if current_x > end_pos.x then
                                    current_x = current_x - 1
                                else
                                    current_x = current_x + 1
                                end
                            else
                                if end_pos.y < current_y then
                                    current_x = current_x - 1
                                    if current_x <= 0 then
                                        current_x = x_until_y
                                        current_y = current_y - 1
                                    end
                                else
                                    current_x = current_x + 1
                                    if current_x >= x_until_y then
                                        current_x = start_pos.x or reset_x
                                        current_y = current_y + 1
                                    end
                                end
                            end
                        else
                            if current_x > end_pos.x then
                                current_x = current_x - 1
                            else
                                current_x = current_x + 1
                            end
                        end
                    else
                        if end_pos.x or end_pos.y then
                            if current_y == (end_pos.y or 0) then
                                if current_x > (end_pos.x or 0) then
                                    current_x = current_x - 1
                                else
                                    current_x = current_x + 1
                                end
                            else
                                if end_pos.y < current_y then
                                    current_x = current_x - 1
                                    if current_x <= 0 then
                                        current_x = x_until_y
                                        current_y = current_y - 1
                                    end
                                else
                                    current_x = current_x + 1
                                    if current_x >= x_until_y then
                                        current_x = start_pos.x or reset_x
                                        current_y = current_y + 1
                                    end
                                end
                            end

                            if current_x == (end_pos.x or 0) and current_y == (end_pos.y or 0) then
                                current_x = reset_x
                                current_y = reset_y
                            end
                        else
                            current_x = current_x + 1
                            if x_until_y and current_x >= x_until_y then
                                current_x = reset_x
                                current_y = current_y + 1
                            end
                            if (current_x + (current_y * (x_until_y or 0))) >= frames then
                                current_x = reset_x
                                current_y = reset_y
                            end
                        end
                    end

                    card.children.center:set_sprite_pos({ x = current_x, y = current_y })
                    if v.config.one_shot and current_x == (end_pos.x or 0) and current_y == (end_pos.y or 0) then
                        table.remove(animatedSprites, i)
                        if v.config and v.config.go_back then
                            card.children.center:set_sprite_pos(v.config.saved_pos)
                        end
                    end
                end
            end
        end
    end
end

local card_remove_ref = Card.remove
function Card:remove()
    local ret = card_remove_ref(self)
    for i, v in ipairs(animatedSprites) do
        if v.card == self then table.remove(animatedSprites, i) end
    end
    return ret
end

SMODS.ObjectType({
    key = "Food",
    default = "j_reserved_parking",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
        -- insert base game food jokers
        self:inject_card(G.P_CENTERS.j_gros_michel)
        self:inject_card(G.P_CENTERS.j_egg)
        self:inject_card(G.P_CENTERS.j_ice_cream)
        self:inject_card(G.P_CENTERS.j_cavendish)
        self:inject_card(G.P_CENTERS.j_turtle_bean)
        self:inject_card(G.P_CENTERS.j_diet_cola)
        self:inject_card(G.P_CENTERS.j_popcorn)
        self:inject_card(G.P_CENTERS.j_ramen)
        self:inject_card(G.P_CENTERS.j_selzer)
    end,
})

SMODS.ObjectType({
    key = "Beans",
    default = "j_turtle_bean",
    cards = {},
    inject = function(self)
        SMODS.ObjectType.inject(self)
        self:inject_card(G.P_CENTERS.j_turtle_bean)
    end,
})

local fourthwall_gradient = SMODS.Gradient({
    key = "fourthwall",
    colours = {
        HEX("ff0000"),
        HEX("ff6600"),
        HEX("ffff00"),
        HEX("4bc292"),
        HEX("1e9eba"),
        HEX("00ffff"),
        HEX("0000ff"),
        HEX("708b91"),
        HEX("ef0098"),
        HEX("ff00ff"),
        HEX("ff0000"),
        HEX("ff6600"),
        HEX("ffff00"),
        HEX("4bc292"),
        HEX("1e9eba"),
        HEX("00ffff"),
        HEX("0000ff"),
        HEX("708b91"),
        HEX("ef0098"),
        HEX("ff00ff")
    },
    cycle = 1
})

--[[
SMODS.current_mod.badge_colour = fourthwall_gradient
]]

local fourwall_gradient = SMODS.Gradient({
    key = "fourwall",
    colours = {
        HEX("00bfff"),
        HEX("0080ff"),
        HEX("4b0082"),
    },
    cycle = 5
})

SMODS.Rarity({
    key = "fourwall",
    loc_txt = {
        name = "Fourth Wall"
    },
    badge_colour = fourwall_gradient,
    default_weight = 0.005,
    pools = { ["Joker"] = true },
    get_weight = function(self, weight, object_type)
        return weight
    end
})

SMODS.Rarity({
    key = "4TH WALL",
    loc_txt = {
        name = "4TH WALL"
    },
    badge_colour = fourthwall_gradient,
    default_weight = 0.005,
    pools = { ["Joker"] = true },
    get_weight = function(self, weight, object_type)
        return weight
    end
})

SMODS.Sound {
    key = "music_tvtime",
    path = "tvtime.ogg",
    vol = 0.6,
    pitch = 1,
    select_music_track = function()
        if (G.GAME and G.GAME.blind and G.GAME.blind.in_blind and next(SMODS.find_card('j_tngt_tenna'))) then
            return 10
        end
    end,
}

SMODS.Sound {
    key = "music_greenroom",
    path = "greenroom.ogg",
    vol = 0.6,
    pitch = 1,
    select_music_track = function()
        if (next(SMODS.find_card('j_tngt_tenna'))) then
            return 9
        end
    end,
}

local co = Card.open
function Card:open()
    co(self)
    if self.config and self.config.center and self.config.center.kind and self.config.center.kind == "Food" then
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tngt_canigetsomeicecream')
                return true
            end
        }))
    end
end

SMODS.Sound {
    key = "tngt_canigetsomeicecream",
    path = "canigetsomeicecream.ogg"
}

SMODS.Sound {
    key = "tngt_onlyaspoonful",
    path = "onlyaspoonful.ogg"
}

SMODS.Sound {
    key = "tngt_neverforget",
    path = "neverforget.ogg"
}

SMODS.Sound {
    key = "tngt_birdthatihate",
    path = "birdthatihate.ogg"
}

SMODS.Sound {
    key = "tngt_thatFUCKINbirdthatihate",
    path = "thatFUCKINbirdthatihate.ogg"
}

SMODS.Sound {
    key = "tngt_snowgrave",
    path = "snowgrave.ogg"
}

SMODS.Sound {
    key = "tngt_recruit",
    path = "recruit.ogg"
}

SMODS.Sound {
    key = "tngt_shitass",
    path = "shitass.ogg"
}

SMODS.Sound {
    key = "tngt_bwomp",
    path = "bwomp.ogg"
}

SMODS.Sound {
    key = "tngt_dealsogood",
    path = "dealsogood.ogg"
}

SMODS.Sound {
    key = "tngt_iamindanger",
    path = "iamindanger.ogg"
}

SMODS.Sound {
    key = "tngt_NOW",
    path = "NOW.ogg"
}

SMODS.Sound {
    key = "tngt_mustard",
    path = "mustard.ogg"
}

SMODS.Sound {
    key = "tngt_aughhh",
    path = "aughhh.ogg"
}

SMODS.Sound {
    key = "tngt_ineedamedicbag",
    path = "ineedamedicbag.ogg"
}

SMODS.Sound {
    key = "tngt_connectionterminated",
    path = "connectionterminated.ogg"
}

SMODS.Sound {
    key = "tngt_eggwah",
    path = "eggwah.ogg"
}

SMODS.Sound {
    key = "tngt_pingas",
    path = "pingas.ogg"
}

SMODS.Sound {
    key = "tngt_damn",
    path = "damn.ogg"
}

SMODS.Sound {
    key = "tngt_flashbang",
    path = "flashbang.ogg"
}

SMODS.Sound {
    key = "tngt_fromyourhouse",
    path = "fromyourhouse.ogg"
}

SMODS.Sound {
    key = "tngt_sayitwithmefolks",
    path = "sayitwithmefolks.ogg"
}

SMODS.Sound {
    key = "tngt_damndaniel",
    path = "damndaniel.ogg"
}

SMODS.Sound {
    key = "tngt_ararararar",
    path = "ararararar.ogg"
}

SMODS.Sound {
    key = "tngt_jumpscare1",
    path = "jumpscare1.ogg"
}

SMODS.Sound {
    key = "tngt_jumpscare2",
    path = "jumpscare2.ogg"
}

SMODS.Sound {
    key = "tngt_jumpscare3",
    path = "jumpscare3.ogg"
}

SMODS.Sound {
    key = "tngt_jumpscare4",
    path = "jumpscare4.ogg"
}

SMODS.Sound {
    key = "tngt_jumpscare5",
    path = "jumpscare5.ogg"
}

SMODS.Sound {
    key = "tngt_yousuck",
    path = "yousuck.ogg"
}

SMODS.Sound {
    key = "tngt_aaa",
    path = "AAAAHHH.ogg"
}

SMODS.Sound {
    key = "tngt_speedbridge",
    path = "speedbridge.ogg"
}

SMODS.Sound {
    key = "tngt_heyshitass",
    path = "heyshitass.ogg"
}

SMODS.Sound {
    key = "tngt_boss",
    path = "eyboss.ogg"
}

SMODS.Sound {
    key = "tngt_hawk",
    path = "hawk.ogg"
}

SMODS.Sound {
    key = "tngt_tuah",
    path = "tuah.ogg"
}

SMODS.Sound {
    key = "tngt_meow",
    path = "meow.ogg"
}

SMODS.Sound {
    key = "tngt_boom",
    path = "boom.ogg"
}

SMODS.Sound {
    key = "tngt_fries",
    path = "theworldmostcrispyfries.ogg"
}

SMODS.Sound {
    key = "tngt_hellomario",
    path = "hellomario.ogg"
}

SMODS.Atlas {
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34,
    frames = 23,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Atlas {
    key = "balatro",
    path = "balatro.png",
    px = 332,
    py = 216
}

SMODS.Atlas {
    key = "descsprite",
    path = "descsprite.png",
    px = 18,
    py = 18
}


SMODS.Sound {
    key = 'THX',
    path = 'introPad1.wav',
    replace = 'introPad1'
}

SMODS.Sound {
    key = 'watchyojet',
    path = 'magic_crumple.wav',
    replace = 'magic_crumple'
}

SMODS.Sound {
    key = 'PS2',
    path = 'magic_crumple2.wav',
    replace = 'magic_crumple2'
}

SMODS.Sound {
    key = 'GAY',
    path = 'magic_crumple3.wav',
    replace = 'magic_crumple3'
}

SMODS.Sound {
    key = 'tngt_weedeveryday',
    path = 'weedeveryday.ogg',
}

SMODS.Sound {
    key = 'tngt_baguette',
    path = 'baguette.ogg',
}

SMODS.Sound {
    key = 'tngt_ping',
    path = 'ping.ogg',
}


SMODS.Atlas {
    key = "npe",
    path = "npe.jpg",
    px = 300,
    py = 301
}:register()

SMODS.Atlas {
    key = "boosters",
    path = "booster.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "shop_sign",
    path = "slop.png",
    px = 113,
    py = 57,
    atlas_table = 'ANIMATION_ATLAS',
    raw_key = true,
    frames = 4,
    prefix_config = { key = false }
}

SMODS.Atlas {
    key = "tvtime",
    path = "itstvtime.png",
    px = 478,
    py = 120
}

SMODS.Atlas {
    key = "goddamnit",
    path = "goddamnit.png",
    px = 600,
    py = 174
}

SMODS.Atlas {
    key = "DEVS",
    path = "DEVS.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "CUM",
    path = "cum.png",
    px = 71,
    py = 95
}

--[[
dear nxkoo,

increase atlasAmount by 1 when you are adding a new atlas.
having more lines doesn't make you cool

from yours truly,
bepis
]]
local atlasAmount = 16
for i = 1, atlasAmount do
    if i == 1 then i = "" end
    SMODS.Atlas {
        key = "ModdedVanilla" .. i,
        path = "ModdedVanilla" .. i .. ".png",
        px = 71,
        py = 95
    }
end

SMODS.Atlas {
    key = "tennas",
    path = "tennas.png",
    px = 64,
    py = 64,
}

SMODS.Atlas {
    key = "donotredeem",
    path = "donotredeem.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "fuhhnaf",
    path = "fuhhnaf.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "southamerica",
    path = "southamerica.png",
    frames = 21,
    atlas_table = "ANIMATION_ATLAS",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "redball",
    path = "redball.png",
    frames = 21,
    atlas_table = "ANIMATION_ATLAS",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "washington",
    path = "washington.png",
    frames = 21,
    atlas_table = "ANIMATION_ATLAS",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "dicks",
    path = "dicks.png",
    px = 71,
    py = 95
}

SMODS.Font {
    key = "DDLC",
    path = "Hashtag.ttf",
    render_scale = 200,
    TEXT_HEIGHT_SCALE = 0.75,
    TEXT_OFFSET = { x = 10, y = -17 },
    FONTSCALE = 0.075,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Font {
    key = "DETERMINATION",
    path = "determination.ttf",
    render_scale = 200,
    TEXT_HEIGHT_SCALE = 0.75,
    TEXT_OFFSET = { x = 10, y = -17 },
    FONTSCALE = 0.075,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Font {
    key = "times",
    path = "times.ttf",
    render_scale = 200,
    TEXT_HEIGHT_SCALE = 0.75,
    TEXT_OFFSET = { x = 10, y = -17 },
    FONTSCALE = 0.075,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Font {
    key = "gross",
    path = "DJGROSS.ttf",
    render_scale = 128,
    TEXT_HEIGHT_SCALE = 1,
    TEXT_OFFSET = { x = 0, y = 0 },
    FONTSCALE = 0.11,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Font {
    key = "papyrus",
    path = "PAPYRUS.TTF",
    render_scale = 200,
    TEXT_HEIGHT_SCALE = 0.75,
    TEXT_OFFSET = { x = 10, y = -17 },
    FONTSCALE = 0.075,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Font {
    key = "omori",
    path = "OMORI_GAME2.ttf",
    render_scale = 128,
    TEXT_HEIGHT_SCALE = 1,
    TEXT_OFFSET = { x = 0, y = 0 },
    FONTSCALE = 0.23,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Font {
    key = "emoji",
    path = "NotoEmoji-Regular.ttf",
    render_scale = 95,
    TEXT_HEIGHT_SCALE = 1,
    TEXT_OFFSET = { x = 10, y = -17 },
    FONTSCALE = 0.15,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Font {
    key = "chinese",
    path = "YRDZST.ttf",
    render_scale = 200,
    TEXT_HEIGHT_SCALE = 0.75,
    TEXT_OFFSET = { x = 10, y = -17 },
    FONTSCALE = 0.075,
    squish = 1,
    DESCSCALE = 1
}

--[[
SMODS.Shader {
    key = "french",
    path = "french.fs"
}

SMODS.Edition {
    key = "french",
    order = 1,
    loc_txt = {
        name = "Fr*nch",
        label = "Vive la France!",
        text = {
            "{C:green}1 in 6{} chance to give",
            "{X:blue,C:white}X2{} {C:blue}Hands{} and {X:mult,C:white}X2{} {C:red}Discards{ }",
            "if triggered"
        }
    },
	sound = {
		sound ="tngt_baguette",
		per = 1,
		vol = 0.3,
	},
    weight = 21,
	shader = "french",
	in_shop = true,
	extra_cost = 3,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue)
        return { vars = { '4.20' } }
    end,
    calculate = function(self, card, context)
        if context.mod_probability then
            return {
                numerator = context.numerator * 4.20
            }
        end
        if (context.edition and context.cardarea == G.jokers and card.config.trigger) or
           (context.main_scoring and context.cardarea == G.play) then
            return { x_chips = self.config.x_chips }
        end
        
        if context.joker_main then
            card.config.trigger = true
        end

        if context.after then
            card.config.trigger = nil
        end
    end
}
]]

SMODS.Shader {
    key = "weed",
    path = "weed.fs"
}

SMODS.Edition {
    key = "weed",
    order = 1,
    loc_txt = {
        name = "Weed",
        label = "420BLAZEIT",
        text = {
            "{X:green,C:white}X#1#{} odds of",
            "any listed probabilities (ALL cards)"
        }
    },
	sound = {
		sound = "tngt_weedeveryday",
		per = 1,
		vol = 0.3,
	},
    weight = 21,
	shader = "weed",
	in_shop = true,
	extra_cost = 3,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue)
        return { vars = { '4.20' } }
    end,
    calculate = function(self, card, context)
        if context.mod_probability then
            return {
                numerator = context.numerator * 4.20
            }
        end
        if (context.edition and context.cardarea == G.jokers and card.config.trigger) or
           (context.main_scoring and context.cardarea == G.play) then
            return { x_chips = self.config.x_chips }
        end
        
        if context.joker_main then
            card.config.trigger = true
        end

        if context.after then
            card.config.trigger = nil
        end
    end
}

local function reset_card_picker_selection()
    G.GAME.current_round.card_picker_selection = { rank = 'Ace', suit = 'Spades' }
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local picked_card = pseudorandom_element(valid_cards, 'card_picker' .. G.GAME.round_resets.ante)
    if picked_card then
        G.GAME.current_round.card_picker_selection = {
            rank = picked_card.base.value,
            suit = picked_card.base.suit,
            id = picked_card.base.id
        }
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_card_picker_selection()
end

local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.current_round.castle2_card = { suit = 'Spades' }
    return ret
end

function tngt_desc_from_rows(desc_nodes, empty, align, maxw) --Taken from JoyousSpring's code like... a year ago? I don't remember :sob:
    local t = {}
    for k, v in ipairs(desc_nodes) do
        t[#t + 1] = { n = G.UIT.R, config = { align = align or "cl", maxw = maxw }, nodes = v }
    end
    return {
        n = G.UIT.R,
        config = { align = "cm", colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE, r = 0.1, padding = 0.04, minw = 2, minh = 0.25, emboss = not empty and 0.05 or nil, filler = true },
        nodes = {
            { n = G.UIT.R, config = { align = align or "cl", padding = 0.03 }, nodes = t }
        }
    }
end

function tngt_create_text_box(key) --Clean text box :3
    local desc_node = {}
    localize { type = 'descriptions', key = key, set = 'dictionary', nodes = desc_node, scale = 1, text_colour = G.C.WHITE }
    desc_node = tngt_desc_from_rows(desc_node, true, "cm")
    desc_node.config.align = "cm"

    return {
        n = G.UIT.R,
        config = { align = "tm", colour = G.C.BLACK, r = 0.2, padding = 0.1 },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "tm" },
                nodes = {
                    desc_node
                }
            },
        }
    }
end

function tngt_emplace_card_to_area(key, area, atlas, pos, size) --Creating fake cards and add them to the area.
    local keys = {}
    if type(key) == "table" then
        keys = key
    else
        keys[#keys + 1] = key
    end
    for _, c_key in ipairs(keys) do
        local card = Card(area.T.x + area.T.w / 2, area.T.y,
            G.CARD_W, G.CARD_H, G.P_CARDS.empty,
            G.P_CENTERS[c_key])
        card.children.back = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
            G.ASSET_ATLAS[(G.P_CENTERS[c_key] and G.P_CENTERS[c_key].atlas) or atlas or "tngt_VanillaRemade"],
            (G.P_CENTERS[c_key] and G.P_CENTERS[c_key].pos) or { x = 0, y = 0 })
        card.children.back.states.hover = card.states.hover
        card.children.back.states.click = card.states.click
        card.children.back.states.drag = card.states.drag
        card.children.back.states.collide.can = false
        card.children.back:set_role({ major = card, role_type = 'Glued', draw_major = card })
        if size then card:resize(size) end
        area:emplace(card)
    end
end

tangent_credit_cards = {
    { card_key = "j_tngt_nxkoo",     credit = "ssecun" },
    { card_key = "j_tngt_ssecun",    credit = "ssecun" },
    { card_key = "j_tngt_incognito", credit = "Incognito" },
    { card_key = "j_tngt_crazydave", credit = "crazy_dave" },
    { card_key = "j_tngt_bepis",     credit = "BepisFever" },
    { card_key = "j_tngt_bread",     credit = "superbread" },
    { card_key = "j_tngt_astro",     credit = "Astro" },
}
tangent_credit_card_per_row = 4
tangent_credit_card_row = 2
tangent_credit_pages = math.max(
    math.ceil(#tangent_credit_cards / (tangent_credit_card_per_row * tangent_credit_card_row)),
    1)
tangent_current_credit_page = 1
tangent_credit_config = {
    reverse = true
}

function G.FUNCS.tngt_next_credit_page(e)
    if tangent_credit_config.reverse and tangent_current_credit_page >= tangent_credit_pages then
        tangent_current_credit_page = 1
    else
        tangent_current_credit_page = math.min(tangent_current_credit_page + 1, tangent_credit_pages)
    end
    G.FUNCS["openModUI_tangent"](e, SMODS.LAST_SELECTED_MOD_TAB)
end

function G.FUNCS.tngt_previous_credit_page(e)
    if tangent_credit_config.reverse and tangent_current_credit_page <= 1 then
        tangent_current_credit_page = tangent_credit_pages
    else
        tangent_current_credit_page = math.max(math.min(tangent_current_credit_page - 1, tangent_credit_pages), 1)
    end
    G.FUNCS["openModUI_tangent"](e, SMODS.LAST_SELECTED_MOD_TAB)
end

--Extra Tabs
tangentry.extra_tabs = function()
    return {
        {
            label = "Credits",
            tab_definition_function = function()
                local root_nodes = {
                    tngt_create_text_box("tngt_credit1")
                }
                local name_node = {}
                localize { type = 'descriptions', key = "tngt_credit_name", set = 'dictionary', nodes = name_node, scale = 2, text_colour = G.C.WHITE, shadow = true }
                name_node = tngt_desc_from_rows(name_node, true, "cm") --Reorganizes the text in the node properly (?).
                name_node.config.align = "cm"

                local desc_node = {}
                localize { type = 'descriptions', key = "tngt_credit_desc", set = 'dictionary', nodes = desc_node, scale = 1, text_colour = G.C.WHITE }
                desc_node = tngt_desc_from_rows(desc_node, true, "cm")
                desc_node.config.align = "cm"

                local function add_credit_card(page, row)
                    local order = (((page - 1) * tangent_credit_card_per_row * tangent_credit_card_row) + ((row - 1) * tangent_credit_card_per_row) + 1)
                    local cardareas = {}
                    if G["tngt_registered_config_cardareas" .. row] and G["tngt_registered_config_cardareas" .. row].area then
                        for _, v in ipairs(G["tngt_registered_config_cardareas" .. row].area) do
                            v:remove()
                            v = nil
                        end
                        G["tngt_registered_config_cardareas" .. row] = nil
                    end
                    for i = order, order + (tangent_credit_card_per_row - 1) do
                        if tangent_credit_cards[i] then
                            G["tngt_credit_cardarea" .. order] = CardArea(
                                G.ROOM.T.x + 0.1 * G.ROOM.T.w / 2, G.ROOM.T.h,
                                0.82 * G.CARD_W,
                                0.82 * G.CARD_H,
                                { card_limit = 5, type = 'title', highlight_limit = 0, collection = true }
                            )
                            local area = G["tngt_credit_cardarea" .. order]
                            local config_card = tangent_credit_cards[i]
                            if config_card then
                                tngt_emplace_card_to_area(config_card.card_key, area, nil, nil, 0.8)
                            end
                            cardareas[#cardareas + 1] = { area = area, c_info = config_card }
                        end
                    end
                    G["tngt_registered_config_cardareas" .. row] = cardareas
                    return cardareas
                end

                for i = 1, tangent_credit_card_row do
                    local cardarea_nodes = {}
                    for _, v in ipairs(add_credit_card(tangent_current_credit_page, i)) do
                        cardarea_nodes[#cardarea_nodes + 1] = {
                            n = G.UIT.C,
                            config = { align = "cm", colour = G.C.BLACK, r = 0.2, padding = 0.02 },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.O, config = { object = v.area } },
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.1 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize("tngt_made_by") .. " " .. ((v.c_info.credit_key and localize(v.c_info.credit_key)) or v.c_info.credit or "?"), colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                                    }
                                },
                            }
                        }
                    end
                    cardarea_nodes = { {
                        n = G.UIT.R,
                        config = { align = "cm", padding = 0.02 },
                        nodes =
                            cardarea_nodes
                    } }
                    root_nodes[#root_nodes + 1] = {
                        n = G.UIT.R,
                        config = { align = "cm", padding = 0.02 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { align = "cm", padding = 0.02 },
                                nodes =
                                    cardarea_nodes
                            },
                        }
                    }
                end

                table.insert(root_nodes, 1, {
                    n = G.UIT.R,
                    config = { align = "tm", colour = G.C.CLEAR },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { align = "tm", colour = G.C.CLEAR },
                            nodes = {
                                name_node,
                                desc_node
                            }
                        },
                    }
                })

                root_nodes[#root_nodes + 1] = {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0.02 },
                    nodes = { --Page turning stuff. This is always added to root_nodes.
                        {
                            n = G.UIT.C,
                            config = { align = "cm", minw = 0.5, minh = 0.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.BLACK, shadow = true, button = "tngt_previous_credit_page" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.05 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = "<", scale = 0.4, colour = G.C.UI.TEXT_LIGHT } }
                                    }
                                }
                            }
                        },
                        {
                            n = G.UIT.C,
                            config = { align = "cm", minw = 0.5, minh = 0.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.BLACK, shadow = true },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.05 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize("tngt_page") .. " " .. tangent_current_credit_page .. "/" .. tangent_credit_pages, scale = 0.4, colour = G.C.UI.TEXT_LIGHT } }
                                    }
                                }
                            }
                        },
                        {
                            n = G.UIT.C,
                            config = { align = "cm", minw = 0.5, minh = 0.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.BLACK, shadow = true, button = "tngt_next_credit_page" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", padding = 0.05 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = ">", scale = 0.4, colour = G.C.UI.TEXT_LIGHT } }
                                    }
                                }
                            }
                        },
                    }
                }

                return {
                    n = G.UIT.ROOT,
                    config = { r = 0.1, minw = 5, align = "cm", padding = 0.2, colour = G.C.BLACK },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { r = 0.1, minw = 5, minh = 3, align = "tm", colour = G.C.L_BLACK, padding = 0.05 },
                            nodes = --We are using G.UIT.C here so that configs are aligned vertically.
                                root_nodes
                        },
                    }
                }
            end
        }
    }
end

local _create_UIBox_options = create_UIBox_options
function create_UIBox_options()
    local ret = _create_UIBox_options()
    local m = UIBox_button({
        minw = 5,
        button = 'TestButton_Menu',
        label = { 'Use' },
        colour = G.C.SO_1.SPADES,
    })
    table.insert(ret.nodes[1].nodes[1].nodes[1].nodes, #ret.nodes[1].nodes[1].nodes[1].nodes + 1, m)
    return ret
end

function G.FUNCS.TestButton_Menu(e)
    print('I FUCKING LOVE KASANE TETO')
end

--[[ Functions for allowing jokers to be used ]] --

local _G_UIDEF_use_and_sell_buttons = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local ret = _G_UIDEF_use_and_sell_buttons(card)
    local m =
    {
        n = G.UIT.C,
        config = { align = "cr" },
        nodes = {
            {
                n = G.UIT.C,
                config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_joker' },
                nodes = {
                    { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                    { n = G.UIT.T, config = { text = localize('b_use'), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
                }
            }
        }
    }
    if card.ability.set == 'Joker' and card.config.center.key == 'j_tngt_mahlazor' then
        table.insert(ret.nodes[1].nodes[2].nodes, #ret.nodes[1].nodes[2].nodes + 1, m)
    end
    return ret
end

function G.FUNCS.can_use_joker(e)
    if e.config.ref_table:can_use_joker() then
        e.config.colour = G.C.RED
        e.config.button = 'use_card'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

function Card:can_use_joker(any_state, skip_check)
    if not skip_check and ((G.play and #G.play.cards > 0) or
            (G.CONTROLLER.locked) or
            (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
    then
        return false
    end
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
        if self.config.center.key == 'j_tngt_mahlazor' then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if not my_pos or my_pos == 1 then
                return {
                    message = "...",
                    colour = G.C.RED
                }
            end
            local total_value = 0
            local destroyed_jokers = {}
            for i = 1, my_pos - 1 do
                local left_joker = G.jokers.cards[i]
                if not SMODS.is_eternal(left_joker, card) and not left_joker.getting_sliced then
                    left_joker.getting_sliced = true
                    total_value = total_value + left_joker.sell_cost
                    destroyed_jokers[#destroyed_jokers + 1] = left_joker
                end
            end

            if #destroyed_jokers == 0 then
                return {
                    message = "...",
                    colour = G.C.RED
                }
            end
            G.GAME.joker_buffer = G.GAME.joker_buffer - #destroyed_jokers
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _, joker in ipairs(destroyed_jokers) do
                        joker:start_dissolve({ HEX("ff0000") }, nil, 1.6)
                        play_sound('slice1', 0.9 + math.random() * 0.2)
                    end
                    local total = 0
                    for k, v in pairs(G.jokers.cards) do
                        total = total + v.sell_cost
                    end
                    card.ability.extra_value = (card.ability.extra_value or 0) + total
                    card:juice_up(0.8, 0.8)
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            return {
                message = "bruh",
                colour = G.C.RED,
                no_juice = true
            }
        end
    end
    return false
end

local _G_FUNCS_use_card = G.FUNCS.use_card
function G.FUNCS.use_card(e, mute, nosave)
    local hcard = e.config.ref_table
    local harea = hcard.area
    if hcard.ability.consumeable then G.GAME.osquo_ext_using_consumeable = true end
    local ret = _G_FUNCS_use_card(e, mute, nosave)
    if e.config.ref_table.config.center.key == 'j_tngt_mahlazor' then
        delay(0.2)
        e.config.ref_table:use_joker(harea)
    end
    G.GAME.osquo_ext_using_consumeable = nil
    return ret
end

function Card:use_joker(area, copier)
    stop_use()
    if self.debuff then return nil end
    local used_joker = copier or self

    if self.config.center.key == 'j_tngt_mahlazor' then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                for _, joker in ipairs(destroyed_jokers) do
                    joker:start_dissolve({ HEX("ff0000") }, nil, 1.6)
                    play_sound('slice1', 0.9 + math.random() * 0.2)
                end
                local total = 0
                for k, v in pairs(G.jokers.cards) do
                    total = total + v.sell_cost
                end
                card.ability.extra_value = (card.ability.extra_value or 0) + total
                card:juice_up(0.8, 0.8)
                G.GAME.joker_buffer = 0
                return true
            end
        }))
        delay(0.6)
    end
end

function tangentry.replacecards(area, replace, bypass_eternal, keep, keeporiginal)                            --Cards not keeping editions/seals/stickers is intended. //Probably extremely inefficient /// Like why tf did i make the keep n entire seperate section. I probably wont even use "replace" or teh destruction part of this like ever.
    if G.shop_booster and area == G.shop_booster.cards or G.shop_vouchers and area == G.shop_vouchers.cards then --Setting the area as these 2 disables the entire thing below and will not have a support for them anytime soon cause NONE of the jokers does anything with destroyed booster PACKS and VOUCHERS. Including mods
        if area == G.shop_booster.cards then
            for i = 1, #area do
                local tab = {}
                for i = 1, #G.P_CENTER_POOLS.Booster do
                    tab[#tab + 1] = G.P_CENTER_POOLS.Booster[i].key
                end
                if area[i] ~= keeporiginal then
                    area[i]:juice_up()
                    area[i]:set_ability(pseudorandom_element(tab))
                end
                tab = {}
            end
        end
        if area == G.shop_vouchers.cards then
            for i = 1, #area do
                local tab = {}
                for i = 1, #G.P_CENTER_POOLS.Voucher do
                    tab[#tab + 1] = G.P_CENTER_POOLS.Voucher[i].key
                end
                if area[i] ~= keeporiginal then
                    area[i]:juice_up()
                    area[i]:set_ability(pseudorandom_element(tab))
                end
                tab = {}
            end
        end
    else
        if keep then
            for i = 1, #area do
                if area[i].config.center.rarity then
                    local b
                    local rarity
                    if not replace then
                        for k, v in pairs(G.P_JOKER_RARITY_POOLS) do
                            if area[i].config.center.rarity == k then
                                rarity = k
                                b = k
                            end
                        end
                        if rarity == 1 then
                            rarity = "Common"
                        elseif rarity == 2 then
                            rarity = "Uncommon"
                        elseif rarity == 3 then
                            rarity = "Rare"
                        elseif rarity == 4 then
                            rarity = "Legendary"
                        end
                        local set = area[i].ability.set
                        local tab = {}
                        for i = 1, #G.P_CENTER_POOLS.Joker do
                            if G.P_CENTER_POOLS.Joker[i].rarity == b then
                                tab[#tab + 1] = G.P_CENTER_POOLS.Joker[i].key
                            end
                        end
                        if area[i] ~= keeporiginal then
                            area[i]:juice_up()
                            area[i]:set_ability(pseudorandom_element(tab))
                            tab = {}
                        end
                    else
                        local set = area[i].ability.set
                        local rarity = SMODS.poll_rarity(set)
                        local b = rarity
                        if rarity == 1 then
                            rarity = "Common"
                        elseif rarity == 2 then
                            rarity = "Uncommon"
                        elseif rarity == 3 then
                            rarity = "Rare"
                        elseif rarity == 4 then
                            rarity = "Legendary"
                        end
                        local tab = {}
                        for i = 1, #G.P_CENTER_POOLS.Joker do
                            if G.P_CENTER_POOLS.Joker[i].rarity == b then
                                tab[#tab + 1] = G.P_CENTER_POOLS.Joker[i].key
                            end
                        end
                        if area[i] ~= keeporiginal then
                            area[i]:juice_up()
                            area[i]:set_ability(pseudorandom_element(tab))
                        end
                        tab = {}
                    end
                elseif area[i].ability.set then
                    local set = area[i].ability.set
                    local tab = {}
                    if area[i].ability.set == "Enhanced" or area[i].ability.set == "Default" or area[i].ability.set == "Playing Card" or area == G.hand.cards then
                        area[i]:juice_up()
                        local _suit, _rank =
                            pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
                        SMODS.change_base(area[i], _suit, _rank)
                        area[i]:set_ability(SMODS.poll_enhancement())
                        area[i]:set_edition(poll_edition())
                    else
                        for i = 1, #G.P_CENTER_POOLS.Consumeables do
                            if G.P_CENTER_POOLS.Consumeables[i].set == set then
                                tab[#tab + 1] = G.P_CENTER_POOLS.Consumeables[i].key
                            end
                        end
                    end
                    if area[i] ~= keeporiginal then
                        area[i]:juice_up()
                        area[i]:set_ability(pseudorandom_element(tab))
                    end
                end
            end
        else
            if replace then --Doesnt stick to joker rarities
                for i = 1, #area do
                    if bypass_eternal then
                        if area[i].ability.set and area[i] ~= keeporiginal then
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i], true)
                            SMODS.add_card({
                                set = set,
                                area = G.pack_cards,
                            })
                        end
                    else
                        if area[i].ability.set and not area[i].ability.eternal and area[i] ~= keeporiginal then
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i])
                            SMODS.add_card({
                                set = set,
                                area = G.pack_cards,
                            })
                        end
                    end
                end
            else
                for i = 1, #area do
                    if bypass_eternal then
                        if area[i].config.center.rarity and area[i] ~= keeporiginal then --Reroll them while keeping the same rarity
                            local rarity
                            if area[i].config.center.rarity == 1 then
                                rarity = "Common"
                            elseif area[i].config.center.rarity == 2 then
                                rarity = "Uncommon"
                            elseif area[i].config.center.rarity == 3 then
                                rarity = "Rare"
                            elseif area[i].config.center.rarity == 4 then
                                rarity = "Legendary"
                            else
                                rarity = area[i].config.center.rarity
                            end
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i], true)
                            SMODS.add_card({
                                set = set,
                                rarity = rarity,
                                area = G.pack_cards,
                            })
                        elseif area[i].ability.set and area[i] ~= keeporiginal then
                            if area[i].ability.set == "Enhanced" or area[i].ability.set == "Default" or area[i].ability.set == "Playing Card" or area == G.hand.cards then
                                area[i]:juice_up()
                                local _suit, _rank =
                                    pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
                                SMODS.change_base(area[i], _suit, _rank)
                                area[i]:set_ability(SMODS.poll_enhancement())
                                area[i]:set_edition(poll_edition())
                            else
                                for i = 1, #G.P_CENTER_POOLS.Consumeables do
                                    if G.P_CENTER_POOLS.Consumeables[i].set == set then
                                        tab[#tab + 1] = G.P_CENTER_POOLS.Consumeables[i].key
                                    end
                                end
                            end
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i], true)
                            SMODS.add_card({
                                set = set,
                                area = G.pack_cards,
                            })
                        end
                    else
                        if area[i].config.center.rarity and not area[i].ability.eternal and area[i] ~= keeporiginal then
                            local rarity
                            if area[i].config.center.rarity == 1 then
                                rarity = "Common"
                            elseif area[i].config.center.rarity == 2 then
                                rarity = "Uncommon"
                            elseif area[i].config.center.rarity == 3 then
                                rarity = "Rare"
                            elseif area[i].config.center.rarity == 4 then
                                rarity = "Legendary"
                            else
                                rarity = area[i].config.center.rarity
                            end
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i])
                            SMODS.add_card({
                                set = set,
                                rarity = rarity,
                                area = G.pack_cards,
                            })
                        elseif area[i].ability.set and not area[i].ability.eternal and area[i] ~= keeporiginal then
                            if area[i].ability.set == "Enhanced" or area[i].ability.set == "Default" or area[i].ability.set == "Playing Card" or area == G.hand.cards then
                                area[i]:juice_up()
                                local _suit, _rank =
                                    pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
                                SMODS.change_base(area[i], _suit, _rank)
                                area[i]:set_ability(SMODS.poll_enhancement())
                                area[i]:set_edition(poll_edition())
                            else
                                for i = 1, #G.P_CENTER_POOLS.Consumeables do
                                    if G.P_CENTER_POOLS.Consumeables[i].set == set then
                                        tab[#tab + 1] = G.P_CENTER_POOLS.Consumeables[i].key
                                    end
                                end
                            end
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i])
                            SMODS.add_card({
                                set = set,
                                area = G.pack_cards,
                            })
                        end
                    end
                end
            end
        end
    end
end

--end

-- MIKE, REBUILD MY MOD
SMODS.load_file("stuff/beefstroganoff/worldwideweb.lua")()
SMODS.load_file("stuff/wankers/cummon/thisdick.lua")()
SMODS.load_file("stuff/wankers/unCUMmon/aintfree.lua")()
SMODS.load_file("stuff/wankers/SKRRRRARE/matteroffact.lua")()
SMODS.load_file("stuff/wankers/TheLegend27/its9inches.lua")()
SMODS.load_file("stuff/wankers/DONOTOPEN/classified.lua")()
SMODS.load_file("stuff/dicks/strictlydickly.lua")() 
SMODS.load_file("stuff/cumchalice/concumables.lua")()
SMODS.load_file("stuff/bosster/likeaboss.lua")()
if background == true then
    SMODS.load_file("BGChanger")()
end
