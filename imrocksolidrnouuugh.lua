-- HUGE shoutout to the following people for their help:
-- Aikoyori for the SMODS.Font stuff
-- Modding developers for helping me along the way
-- Especially Somethingcom515, N', and BepisFever for the HUGE help
-- And of course, the people who play the mod, and the people who play the mod's mod, and the mod's mod's mod.

wankers = 0
dicks = 0

-- MIKE, REBUILD MY MOD
SMODS.load_file("stuff/wankers/cummon/thisdick.lua")()
SMODS.load_file("stuff/wankers/unCUMmon/aintfree.lua")()
SMODS.load_file("stuff/wankers/SKRRRRARE/matteroffact.lua")()
SMODS.load_file("stuff/wankers/TheLegend27/its9inches.lua")()
SMODS.load_file("stuff/dicks/strictlydickly.lua")()

--- Talisman compat
to_big = to_big or function(num)
    return num
end

to_number = to_number or function(num)
    return num
end

tangentry = SMODS.current_mod

nxkoo_dies = {
    show_mustard = false,
    mustard_timer = 0,
    show_image = false,
    image_timer = 0,
    show_flashbang = false,
    flashbang_timer = 0,
    current_flashbang = nil,
    default_flashbang = string.sub(SMODS.current_mod.path, string.find(SMODS.current_mod.path, "Mods")).."/assets/customimages/jumpscare_2.png",
    path = SMODS.current_mod.path,
    flashbangs = {
        shop = "shop_flashbang.png",
        blind = "blind_flashbang.png",
        hand_played = "hand_flashbang.png",
        discard = "discard_flashbang.png",
        round_start = "round_flashbang.png",
        joker_trigger = "joker_flashbang.png"
    }
}

nxkoo_dies.optional_features = function()
    return {
        quantum_enhancements = true,
        post_trigger = true
    }
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
                ref_value = "sane"
            }),
            create_toggle_spec({
                label = "{C:white}Homosexual?",
                ref_table =
                    tangentry.config,
                ref_value = "homosexual"
            }),
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

SMODS.current_mod.badge_colour = fourthwall_gradient

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

SMODS.Atlas {
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "balatro",
    path = "balatro.png",
    px = 332,
    py = 216
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
    key = "ModdedVanilla",
    path = "ModdedVanilla.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla2",
    path = "ModdedVanilla2.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla3",
    path = "ModdedVanilla3.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla4",
    path = "ModdedVanilla4.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla5",
    path = "ModdedVanilla5.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla6",
    path = "ModdedVanilla6.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla7",
    path = "ModdedVanilla7.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla8",
    path = "ModdedVanilla8.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla9",
    path = "ModdedVanilla9.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla10",
    path = "ModdedVanilla10.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla11",
    path = "ModdedVanilla11.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ModdedVanilla12",
    path = "ModdedVanilla12.png",
    px = 71,
    py = 95
}

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
