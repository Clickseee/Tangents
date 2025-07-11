-- HUGE shoutout to the following people for their help:
-- Aikoyori for the SMODS.Font stuff
-- Modding developers for helping me along the way
-- Especially Somethingcom515 and N' for the HUGE help
-- And of course, the people who play the mod, and the people who play the mod's mod, and the mod's mod's mod.

--- Talisman compat
to_big = to_big or function(num)
    return num
end

to_number = to_number or function(num)
    return num
end

nxkoo_dies = {
    show_mustard = false,
    mustard_timer = 0,
    show_image = false,
    image_timer = 0,
    show_flashbang = false,
    flashbang_timer = 0,
    current_flashbang = nil,
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
        quantum_enhancements = true
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

local about = {
    "{C:white}A mod made by one and only, {C:blue}@nxkoo_{}",
}

local textwall = {}
for i = 1, #about do
    table.insert(textwall, {
        n = G.UIT.R,
        config = { align = "cm", minh = 0.05 },
        nodes = SMODS.localize_box(loc_parse_string(about[i]), { scale = 2 })
    })
end

nxkoo_dies.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 10, align = 'cm', padding = 0.1, colour = G.C.BLACK },
        nodes = {
            create_toggle_spec({
                label = "{C:white}Sex?",
                desc =
                "{C:inactive}Pretty self explanatory if you ask me.{}",
                ref_table = nxkoo_dies.config,
                ref_value =
                "items"
            }),
            create_toggle_spec({
                label = "{C:white}Premium Mode",
                desc =
                "{C:inactive}Only available for Discord Nitro user.",
                ref_table = nxkoo_dies.config,
                ref_value =
                "premium"
            }),
            create_toggle_spec({
                label = "{X:dark_edition,C:white}HYPERDEATH{} {C:dark_edition}MODE",
                desc = "{C:inactive}Biblically accurate and personalized .exe",
                ref_table =
                    nxkoo_dies.config,
                ref_value = "hypergod"
            }),
            create_toggle_spec({
                label = "{C:white}Sane person?",
                desc = "{C:inactive}Click this to make your run more immersive",
                ref_table =
                    nxkoo_dies.config,
                ref_value = "gurp"
            }),
            create_toggle_spec({
                label = "{C:white}Homosexual?",
                ref_table =
                    nxkoo_dies.config,
                ref_value = "gurp"
            }),
        }
    }
end

nxkoo_dies.custom_ui = function(mod_nodes)
    mod_nodes[#mod_nodes + 1] = {
        n = G.UIT.R,
        config = { minh = 0.2, padding = 0.2 }
    }
    mod_nodes[#mod_nodes + 1] = {
        n = G.UIT.R,
        { n = G.UIT.C, config = { align = 'tm' }, nodes = textwall }
    }
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
    py = 216,
    prefix_config = { key = false }
}:register()


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

SMODS.Back {
    key = "pyro",
    loc_txt = {
        name = "Slop Deck",
        text = {
            "After defeating a blind:",
            "Spawn 1 common {C:attention}Joker{}",
            "and 1 random {C:attention}consumable{}"
        }
    },
    unlocked = true,
    discovered = true,
    atlas = "dicks",
    pos = { x = 0, y = 1 },
    calculate = function(self, back, context)
        if context.end_of_round and not context.repetition and not context.individual then
            if not G.GAME.blind.disabled then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local joker_pool = {}
                        for _, joker in pairs(G.P_CENTERS) do
                            if joker.set == "Joker" and joker.rarity == 1 then
                                table.insert(joker_pool, joker.key)
                            end
                        end

                        if #joker_pool > 0 then
                            local joker_key = pseudorandom_element(joker_pool, pseudoseed('welcomebacktosloplive'))
                            SMODS.add_card({
                                set = "Joker",
                                rarity = "Common"
                            })
                        end

                        local consumable_types = { 'Tarot', 'Planet', 'Spectral' }
                        local chosen_type = pseudorandom_element(consumable_types, pseudoseed('thanksforsloppingby'))

                        SMODS.add_card({
                            set = chosen_type,
                            area = G.consumeables,
                            from_card = nil,
                            discovered = true
                        })

                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Back {
    key = "elon",
    loc_txt = {
        name = "Elon Dihh Deck",
        text = {
            "Start with {C:money}$250{}",
            "and a {C:dark_edition}Negative{} {C:attention}Mail-in Rebate{} Joker"
        }
    },
    unlocked = true,
    discovered = true,
    atlas = "dicks",
    pos = { x = 1, y = 1 },
    config = { dollars = 250 },

    apply = function(self)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                SMODS.add_card({
                    key = "j_mail",
                    edition = "e_negative",
                    area = G.jokers,
                    discovered = true
                })
                return true
            end
        }))
    end
}

SMODS.Joker {
    key = 'cope',
    loc_txt = {
        name = 'C.O.P.E',
        text = {
            "Each played {C:attention}4{} and {C:attention}7{} will be retriggered {C:attention}twice.{}",
            "{C:inactive,s:0.7}WHAT THE FUCK IS A KILOMETRE?!?!?!?!??!??!?{}"
        }
    },
    config = { extra = { mult = 4 }, retriggers = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    atlas = 'ModdedVanilla',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 7 or context.other_card:get_id() == 4 then
                return { repetitions = 2 }
            end
        end
    end
}

SMODS.Joker {
    key = 'error',
    loc_txt = {
        name = 'joker.mdl',
        text = {
            "{C:inactive}(undefined Mult)"
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    atlas = 'ModdedVanilla2',
    pos = { x = 0, y = 0 },
    cost = 4,
    config = {
        extra = {
            min_xmult = 1,
            max_xmult = 10
        }
    },

    loc_vars = function(self, info_queue, card)
        local r_xmults = {}
        for i = card.ability.extra.min_xmult * 10, card.ability.extra.max_xmult * 10 do
            r_xmults[#r_xmults + 1] = tostring(i / 10)
        end

        local loc_xmult = ' ' .. localize('k_xmult') .. ' '
        main_start = {
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = '+', colour = G.C.RED },
                            { string = 'X', colour = G.C.MULT },
                            { string = '^', colour = G.C.MULT },
                            { string = '=', colour = G.C.MULT },
                            { string = '?', colour = G.C.RED },
                            { string = '!', colour = G.C.RED }
                        },
                        colours = { G.C.UI.TEXT_DARK },
                        scale = 0.32
                    })
                }
            },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = r_xmults,
                        colours = { G.C.RED },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = ' Upd ati nng..',                       colour = G.C.JOKER_GREY },
                            { string = ' Missi ng..',                          colour = G.C.JOKER_GREY },
                            { string = ' #@' .. (G.deck and #G.deck.cards or 0), colour = G.C.RED },
                            loc_xmult, loc_xmult, loc_xmult
                        },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            }
        }
        return { main_start = main_start }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            -- Generate random Xmult between min and max
            local random_xmult = pseudorandom(
                'chaos_orb_xmult_' .. G.GAME.round_resets.ante,
                card.ability.extra.min_xmult * 10,
                card.ability.extra.max_xmult * 10
            ) / 10

            return {
                x_mult = random_xmult,
                colour = G.C.RED
            }
        end
    end,
}

SMODS.Joker {
    key = 'house',
    loc_txt = {
        name = 'House J.K{C:inactive,s:0.7}.R{}',
        text = {
            "This Doctor will cure your cards and gain {X:blue,C:white}X#1#{} Vicodins",
            "Sick cards = {C:attention}Enhanced{} cards",
            "{C:inactive}(Currently {X:blue,C:white} X#2# {C:inactive} Vicodins)",
            "{C:inactive,s:2}I told you it's not {C:green,s:2}Lupus.{C:inactive}"
        }
    },
    config = { extra = { xchips_gain = 0.5, xchips = 1 } },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    atlas = 'ModdedVanilla3',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips_gain, card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local enhanced = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff and not scored_card.vampired then
                    enhanced[#enhanced + 1] = scored_card
                    scored_card.vampired = true
                    scored_card:set_ability('c_base', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            scored_card.vampired = nil
                            return true
                        end
                    }))
                end
            end

            if #enhanced > 0 then
                card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain * #enhanced
                return {
                    message = "Cured.",
                    colour = G.C.GREEN
                }
            end
        end
        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
    end,
}

SMODS.Joker {
    key = 'dealmaker',
    loc_txt = {
        name = 'Dealmaker',
        text = {
            "Played {C:attention}face cards{} will earn you a random amount of {C:gold,s:1.5,E:2}[[KROMER]]{}",
            "{C:inactive,s:0.7}WHAT THE [[FIFTY DOLLARS SPECIAL.]]{}"
        }
    },
    config = {},
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    atlas = 'ModdedVanilla4',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.starting_shop then
            local has_joker = next(SMODS.find_card("j_tngt_dealmaker"))
            if has_joker then
                return {
                    message = "DEALS SO GOOD I'LL [$!$$] MYSELF",
                    sound = "tngt_dealsogood",
                    colour = G.C.YELLOW
                }
            end
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            local amount = pseudorandom('BIGSHOT', 1, 8)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + amount
            return {
                dollars = amount,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}

SMODS.Joker {
    key = 'strike',
    loc_txt = {
        name = 'Dear {C:gold}God{}, please {C:red}strike{} this {C:attention}Joker{} down.',
        text = {
            "After #2# {C:attention}Rounds{}, sell this Cat to",
            "add {C:dark_edition}Negative.{} to a random Joker",
            "{C:inactive}(Currently {C:attention}#1#{}{C:inactive}/{}{C:inactive}#2#{} {C:inactive}Rounds)"
        }
    },
    config = {
        extra = {
            neg_rounds = 0,
            total_rounds = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.neg_rounds, card.ability.extra.total_rounds } }
    end,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    atlas = 'ModdedVanilla5',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint and not context.game_over then
            card.ability.extra.neg_rounds = card.ability.extra.neg_rounds + 1

            if card.ability.extra.neg_rounds == card.ability.extra.total_rounds then
                juice_card_until(card, function(c) return not c.REMOVED end, true)
            end

            return {
                message = (card.ability.extra.neg_rounds < card.ability.extra.total_rounds)
                    and (card.ability.extra.neg_rounds .. "/" .. card.ability.extra.total_rounds)
                    or localize("k_active_ex"),
                colour = G.C.EDITION.negative
            }
        end

        if context.selling_self and card.ability.extra.neg_rounds >= card.ability.extra.total_rounds and not context.blueprint then
            local jokers = {}
            for _, j in ipairs(G.jokers.cards) do
                if j ~= card and not j.edition then
                    table.insert(jokers, j)
                end
            end

            if #jokers > 0 then
                local chosen = pseudorandom_element(jokers, pseudoseed("strikethisfuckerdown"))
                chosen:set_edition("e_negative", true)
                juice_card(chosen, 0.6, 0.6)
                return { message = localize("k_edition_applied_ex") }
            else
                return { message = localize("k_no_other_jokers") }
            end
        end
    end
}

-- CREDIT TO FINITY, I LOVE YOU FREH MWAAAAAAAAAAHHH
SMODS.Joker {
    key = 'shitass',
    loc_txt = {
        name = 'Hey {C:attention}shitass{}, wanna {C:attention}see{} me {C:blue}speedrun?{}',
        text = {
            "{C:red}Beat his ass{} by beating the {C:attention}Blind{} before",
            "{C:attention}20{} seconds runs out.",
            "{C:gold,s:2}AND WIN BIG PRIZES.",
            "{C:inactive}(The Timer is down here.)",
            "{C:inactive,s:0.7}Yes, you have to hover over the Joker to see it, cry about it."
        }
    },
    config = { start = 0, inblind = 0, time = 20 },
    loc_vars = function(self, info_queue, card)
        return {
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.3 },
                    nodes = {
                        {
                            n = G.UIT.T,
                            config = {
                                ref_table = card.ability,
                                ref_value = "time",
                                scale = 0.32,
                                colour = G.C.GREEN
                            }
                        }
                    }
                }
            }
        }
    end,
    update = function(self, card)
        card.ability.time = string.gsub(
        string.format("%.2f", 20 - (G.TIMERS.REAL - card.ability.start) * card.ability.inblind), "%.", ":")
    end,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    atlas = 'ModdedVanilla6',
    pos = { x = 0, y = 0 },
    cost = 3,
    calculate = function(self, card, context)
        if context.blueprint then return end

        if context.setting_blind then
            card.ability.start = G.TIMERS.REAL
            card.ability.inblind = 1
            return {
                sound = "tngt_shitass",
                message = "*loud mechanical keyboard noise*"
            }
        end

        if (context.end_of_round and context.main_eval and not context.repetition) or context.forcetrigger then
            card.ability.inblind = 0
            if (G.TIMERS.REAL - card.ability.start <= 20) or context.forcetrigger then
                card:start_dissolve()
                SMODS.add_card {
                    set = "Joker",
                    rarity = "Legendary"
                }
                return {
                    message = "AAAAAAAAAAAAAAAAAAAAAAAAAA",
                    colour = G.C.BLUE
                }
            else
                return {
                    message = "...W- wha?..",
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'steve',
    loc_txt = {
        name = 'I.. am Joker.',
        text = {
            "This Joker gives {C:red}+#1#{} Mult,",
            "{C:red,s:2}BUT",
            "{C:attention}adds{} another {C:red}+15{} Mult into the Joker based on his {C:attention}position{}.",
            "{C:inactive}(EXAMPLE: Slot 1 = +15, Slot 2 = +30, Slot 3 = +45, and so on.)",
            "{C:inactive}(Currently {C:red}+#2#{} {C:inactive}based on this position.)"
        }
    },
    config = { extra = { base_mult = 15, position_mult = 0 } },
    loc_vars = function(self, info_queue, card)
        local position_mult = 0
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    position_mult = i * card.ability.extra.base_mult
                end
            end
        end
        return { vars = { card.ability.extra.base_mult, position_mult or 0 } }
    end,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    atlas = 'ModdedVanilla7',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            local position_mult = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    position_mult = i * card.ability.extra.base_mult
                    break
                end
            end
            return {
                mult = position_mult
            }
        end
    end
}

SMODS.Joker {
    key = 'sneakthruthedoorman',
    loc_txt = {
        name = '{C:red,E:2}DOOR STUCK{}',
        text = {
            "{X:mult,C:white}X#1#{} Mult",
            "{s:0.5}Sent to the {C:dark_edition,s:0.5}Void{} {s:0.5}if sold."
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    atlas = 'ModdedVanilla8',
    pos = { x = 0, y = 0 },
    cost = 2,
    config = { extra = { xmult = 1.6 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            local original_sell = Card.sell
            function Card:sell()
                if self == card then
                    G.FUNCS.start_run()
                    return
                else
                    return original_sell(self)
                end
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            function Card:sell()
                if self == card then
                    G.FUNCS.start_run()
                    return
                else
                    return original_sell(self)
                end
            end
        end
    end
}

SMODS.Joker {
    key = 'eggwuh',
    loc_txt = {
        name = 'It comes with {f:tngt_times}eggwah..~{}{f:emoji}👅',
        text = {
            "Has {C:green}1{} in {C:green}#1#{} chance to give {C:attention}Egg Joker{}",
            "whenever you {C:attention}buy{} something from the {C:attention}shop{}"
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    atlas = 'ModdedVanilla9',
    pos = { x = 0, y = 0 },
    cost = 6,
    config = { extra = { chance = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chance } }
    end,
    calculate = function(self, card, context)
        if context.buying_card and not context.blueprint then
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                if pseudorandom('hayadies') < G.GAME.probabilities.normal / card.ability.extra.chance then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({
                                set = "Joker",
                                key = "j_egg",
                                key_append = "eggroll"
                            })
                            G.GAME.joker_buffer = 0

                            card:juice_up(0.5, 0.5)
                            play_sound('tngt_eggwah', 0.9 + math.random() * 0.1)
                            return true
                        end
                    }))

                    return {
                        message = localize('k_plus_joker'),
                        colour = G.C.BLUE,
                        card = card
                    }
                end
            else
                return {
                    message = localize('k_no_room_ex'),
                    colour = G.C.RED
                }
            end
        end
    end,
}

SMODS.Joker {
    key = 'watericesalt',
    loc_txt = {
        name = 'A waterballoon?',
        text = {
            "This kid will give you {X:mult,C:white}X10000000{} Mult, {X:blue,C:white}X10000000{} Chips",
            "{C:gold}$100000000{}, and Infinite {C:blue}Hands{}",
            "{C:inactive}(Only works if you hit the Game Over screen.)"
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 1,
    atlas = 'ModdedVanilla10',
    pos = { x = 0, y = 0 },
    cost = 1,
    config = { {} },
    loc_vars = function(self, info_queue, card)
        return { {} }
    end,
    calculate = function(self, card, context)
    end
}

--[[
SMODS.Joker {
	key = 'revive',
	loc_txt = {
		name = 'Mr. Revive?',
		text = {
			"Prevents you from any source of {X:mult,C:white}DEATH{}",
			"if chips scored are atleast {C:attention}1%{} of the required chips",
			"Will {C:red}self destructs{} in {C:attention}2{} losses."
		}
	},
	rarity = 2,
	atlas = 'ModdedVanilla',
	pos = { x = 1, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { rounds_left = 0 } },
	calculate = function(self, card, context)
		card.ability.extra.rounds_left = card.ability.extra.rounds_left + 1
		if card.ability.extra.rounds_left >= 2 then
			G.E_MANAGER:add_event(Event({
			func = function()
				G.hand_text_area.blind_chips:juice_up()
				G.hand_text_area.game_chips:juice_up()
				play_sound('tarot1')
				card:start_dissolve()
				return true
			end
			}))
		end
		return {saved = true}
    end,
}
]]

SMODS.Joker {
    key = 'geo',
    loc_txt = {
        name = 'National Geographic',
        text = {
            "Played {C:attention}Wild{} cards will gives you either {C:red}+#1#{} Mult,",
            "{X:mult,C:white}X#2#{} Mult, {C:blue}+#3#{} Chips, or {C:gold}$#4#{} Dollars."
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla2',
    pos = { x = 1, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = { extra = { mult = 7, xmult = 1.5, chips = 65, dollars = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.chips, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and SMODS.has_enhancement(context.other_card, 'm_wild') then
            local roll = pseudorandom('NATIONALGEOGRAPHIC', 1, 4)
            if roll == 1 then
                return {
                    mult = 5,
                    colour = G.C.RED
                }
            elseif roll == 2 then
                return {
                    xmult = 1.5,
                    colour = G.C.MAGENTA
                }
            elseif roll == 3 then
                return {
                    chips = 50,
                    colour = G.C.BLUE
                }
            elseif roll == 4 then
                return {
                    dollars = 5,
                    colour = G.C.YELLOW
                }
            end
        end
    end
}

local atlussy = 0
for not_victin, victin in pairs(G.ASSET_ATLAS) do
    atlussy = atlussy + 1
end

SMODS.Joker {
    key = 'atlas',
    loc_txt = {
        name = 'Atlas',
        text = {
            "{X:mult,C:white}X#1#{} Mult for each {C:dark_edition}precious{} {C:attention}Atlas{} in your {C:attention}Directory{}.",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla3',
    pos = { x = 1, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult * atlussy } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult * atlussy
            }
        end
    end
}

SMODS.Joker {
    key = 'bigrig',
    loc_txt = {
        name = "{C:attention}YOU'RE WINNER !{}",
        text = {
            "Attempt to summon random {C:attention}Jokers{} upon",
            "defeating the {C:attention}Boss Blind.{}",
            "{C:inactive}(Cannot overflow, maybe..){}"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla4',
    pos = { x = 1, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    calculate = function(self, card, context)
        if G.GAME.blind.boss and context.end_of_round then
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = pseudorandom_element({ 'Common', 'Uncommon', 'Rare', 'Legendary' }, pseudoseed('BIGRIG')),
                            key_append = 'spawned_by_boss' -- optional: useful for tracking
                        }
                        G.GAME.joker_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_joker'),
                    colour = G.C.BLUE
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'radiohead',
    loc_txt = {
        name = "Radio{C:attention}haaaaaaacho!{}",
        text = {
            "This Thom Shoerke gains {X:mult,C:white}X1.5{} Mult for each",
            "{f:tngt_papyrus,X:dark_edition,C:white}Head..{} given by {C:attention}Radio{} in this run.",
            "{C:inactive}(Currently {X:mult,C:white}X3{} {C:inactive}Mult)"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla5',
    pos = { x = 1, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = { mult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end,
}

SMODS.Joker {
    key = 'chris',
    loc_txt = {
        name = "Chris {C:blue}Chips{}",
        text = {
            "{C:blue}+#1#{} Chips for each {C:attention}consumable{} held in this run.",
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla6',
    pos = { x = 1, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    config = { extra = { chips_per_consumable = 150 } },

    loc_vars = function(self, info_queue, card)
        local consumable_count = G.consumeables and #G.consumeables.cards or 0
        return {
            vars = {
                card.ability.extra.chips_per_consumable,
                consumable_count,
                card.ability.extra.chips_per_consumable * consumable_count
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local consumable_count = G.consumeables and #G.consumeables.cards or 0
            if consumable_count > 0 then
                return {
                    chips = card.ability.extra.chips_per_consumable * consumable_count,
                    card_eval = card,
                    colour = G.C.CHIPS
                }
            end
        end
    end,

    callbacks = {
        on_consumeable_added = function(card)
            card:juice_up(0.2, 0.2)
        end,
        on_consumeable_removed = function(card)
            card:juice_up(0.2, 0.2)
        end
    }
}

SMODS.Joker {
    key = 'jpeg',
    loc_txt = {
        name = "Do {C:attention}i{} look like i {C:attention}know{} what a {C:dark_edition}.JPEG{} is?",
        text = {
            "Shitty resolution = {X:mult,C:white}X1.5{} Mult.",
            "{C:attention}Resize{} your damn {C:blue}Window{} to win it {s:1.5,C:gold}BIG{}",
            "{C:inactive}(Will be punished if it's played Fullscreen.)",
            "{C:inactive,s:0.7}Yahimod? What's that?"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla7',
    pos = { x = 1, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            mult = 1.0,
            fullscreen_penalty = 0.5,
            is_fucked = false
        }
    },

    update = function(self, card, front)
        local w, h = love.graphics.getDimensions()
        local _xscale = w / 1920
        local _yscale = h / 1080
        local _factor = 1 / ((_xscale + _yscale) / 2)

        local is_fullscreen = love.window.getFullscreen()
            or (_xscale >= 1.0 and _yscale >= 1.0)

        card.ability.extra.mult = math.floor(_factor * 100) / 100
        card.ability.extra.is_fucked = is_fullscreen

        if is_fullscreen and not card.ability.warned then
            card.ability.warned = true
            card:juice_up(0.5, 0.5)
            play_sound('tngt_neverforget')
        elseif not is_fullscreen then
            card.ability.warned = false
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.mult },
            main_start = {
                { n = G.UIT.T, config = { text = " > Current: x" .. card.ability.extra.mult, scale = 0.35, colour = G.C.GREEN } },
                { n = G.UIT.T, config = { text = " | Fullscreen Debuff: x" .. card.ability.extra.fullscreen_penalty, scale = 0.35, colour = G.C.RED } },
                {
                    n = G.UIT.T,
                    config = {
                        text = card.ability.extra.is_fucked and " | FUCKED. (Fullscreen)" or " | Aye :D (windowed)",
                        scale = 0.35,
                        colour = card.ability.extra.is_fucked and G.C.RED or G.C.GREEN
                    }
                }
            }
        }
    end,

    calculate = function(self, card, context)
        local effective_mult = card.ability.extra.mult or 1.0

        if card.ability.extra.is_fucked then
            effective_mult = effective_mult * card.ability.extra.fullscreen_penalty
        end

        return {
            Xmult = effective_mult,
            message = card.ability.extra.is_fucked and
                "FULLSCREEN PENALTY! X" .. effective_mult or
                "Window Scaling: X" .. effective_mult,
            colour = card.ability.extra.is_fucked and G.C.RED or G.C.MULT
        }
    end
}

SMODS.Joker {
    key = 'pingas',
    loc_txt = {
        name = "Snoo{C:attention}ping as{} usual?",
        text = {
            "{C:red}+#1#{} Mult for each {C:attention}Played{} cards",
            "{C:attention}He{} might see {C:red}you{} snooping around."
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla8',
    pos = { x = 1, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = { mult_per_card = 4, mult_mod = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_per_card } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand then
            local total_mult = #context.scoring_hand * card.ability.extra.mult_per_card

            for i = 1, #context.scoring_hand do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.05 * i,
                    blockable = false,
                    func = function()
                        play_sound('tngt_pingas')
                        return true
                    end
                }))
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.05 * #context.scoring_hand + 0.1,
                blockable = false,
                func = function()
                    card:juice_up(0.3, 0.3)
                    return true
                end
            }))

            return {
                mult_mod = card.ability.extra.mult_per_card,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_per_card } },
                sound = "tngt_pingas",
            }
        end
    end
}

SMODS.Joker {
    key = 'papersplease',
    loc_txt = {
        name = "Jorji",
        text = {
            "{X:mult,C:white}X#1#{} Mult, but if you let {C:attention}Jorji{} stays",
            "for {C:attention}3{} rounds, he might give you {C:gold}something{} {C:red}useful."
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla9',
    pos = { x = 1, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            rounds_remaining = 3,
            base_xmult = 0.5,
            reward_dollars = 25,
            reward_rarity = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base_xmult,
                card.ability.extra.rounds_remaining,
                card.ability.extra.reward_dollars,
                localize(card.ability.extra.reward_rarity, 'rarities')
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.base_xmult
            }
        end

        if context.end_of_round and context.main_eval and not context.blueprint and not context.game_over then
            card.ability.extra.rounds_remaining = card.ability.extra.rounds_remaining - 1

            if card.ability.extra.rounds_remaining <= 0 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.reward_dollars

                local reward_message = ""
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    reward_message = localize { type = 'variable', key = 'a_dollars_and_joker', vars = {
                        card.ability.extra.reward_dollars,
                        localize(card.ability.extra.reward_rarity, 'rarities')
                    } }
                else
                    reward_message = localize { type = 'variable', key = 'a_dollars', vars = { card.ability.extra.reward_dollars } }
                end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.jokers.cards + G.GAME.joker_buffer <= G.jokers.config.card_limit then
                            SMODS.add_card({
                                set = "Joker",
                                rarity = card.ability.extra.reward_rarity,
                                key_append = "thanks"
                            })
                        end
                        G.GAME.joker_buffer = 0
                        G.GAME.dollar_buffer = 0
                        card:start_dissolve()
                        return true
                    end
                }))

                return {
                    message = "Glory to Balatrotzka",
                    colour = G.C.MONEY,
                    card = card
                }
            else
                return {
                    message = card.ability.extra.rounds_remaining .. "/3",
                    colour = G.C.FILTER,
                    card = card
                }
            end
        end
    end
}

local updatehook = Game.update
function Game:update(dt)
    updatehook(self, dt)
    if nxkoo_dies.show_image then
        nxkoo_dies.image_timer = nxkoo_dies.image_timer - dt
        if nxkoo_dies.image_timer <= 0 then
            nxkoo_dies.show_image = false
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()

    function load_image(fn)
        local full_path = (nxkoo_dies.path .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempimagedata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempimagedata)))
    end

    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080

    if nxkoo_dies.show_image then
        if not nxkoo_dies.show_image then
            nxkoo_dies.show_image = load_image("damnbird.png")
        end
        local alpha = math.min(1, nxkoo_dies.image_timer * 2)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(nxkoo_dies.damnbird_png, 0, 0, 0, _xscale, _yscale)
    end
end

SMODS.Joker {
    key = 'DMAN',
    loc_txt = {
        name = "DAMN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",
        text = {
            "Gives {X:mult,C:white}X#1#{} DAMN",
            "for each {C:money}$4{} you have",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}DAMN){}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla10',
    pos = { x = 1, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = { mult_per_2_dollars = 1.5 } },
    loc_vars = function(self, info_queue, card)
        local current_mult = math.floor((G.GAME.dollars or 0) / 2) * card.ability.extra.mult_per_2_dollars
        return { vars = { card.ability.extra.mult_per_2_dollars, current_mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local dollars = G.GAME.dollars or 0
            local multiplier = math.floor(dollars / 4) * card.ability.extra.mult_per_2_dollars

            if not nxkoo_dies.damnbird_png then
                nxkoo_dies.damnbird_png = load_image("damnbird.png")
            end
            nxkoo_dies.show_image = true
            nxkoo_dies.image_timer = 0.5

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                blockable = false,
                func = function()
                    play_sound('tngt_damn', 1, 1)
                    card:juice_up(0.5, 0.5)
                    return true
                end
            }))

            return {
                xmult = multiplier
            }
        end
    end
}

SMODS.Joker {
    key = 'fish',
    loc_txt = {
        name = 'You know what that mean? :D',
        text = {
            "Gains {C:blue}+15{} Chips for each played cards.",
            "{C:inactive}--------------------------------",
            "{C:attention,s:3}fish.{}"
        }
    },
    config = { extra = { chips = 15 } },
    rarity = 1,
    atlas = 'ModdedVanilla',
    pos = { x = 2, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.other_card:is_face() then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}

SMODS.Joker {
    key = 'illusions',
    loc_txt = {
        name = 'This Joker',
        text = {
            "If played hand contains only {C:spades}Spades{} or {C:clubs}Clubs{},",
            "gives {C:mult}+#1#{} Mult. If both, gives {X:mult,C:white}X#2#{} Mult instead.",
            "If held cards are also {C:spades}Spades{} or {C:clubs}Clubs{}, gives {X:mult,C:white}X#3#{} Mult",
            "and {X:chips,C:white}X#4#{} Chips"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla2',
    pos = { x = 2, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            base_mult = 10,
            dual_xmult = 2.1,
            held_xmult = 2,
            held_xchips = 3.5
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'crazy', set = 'Other' }
        return {
            vars = {
                card.ability.extra.base_mult,
                card.ability.extra.dual_xmult,
                card.ability.extra.held_xmult,
                card.ability.extra.held_xchips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_black = true
            local has_clubs = false
            local has_spades = false

            for _, playing_card in ipairs(context.scoring_hand) do
                if not (playing_card:is_suit('Clubs', nil, true) or playing_card:is_suit('Spades', nil, true)) then
                    all_black = false
                    break
                end
                if playing_card:is_suit('Clubs', nil, true) then has_clubs = true end
                if playing_card:is_suit('Spades', nil, true) then has_spades = true end
            end

            local held_match = true
            if all_black then
                for _, hand_card in ipairs(G.hand.cards) do
                    if not context.scoring_hand or not tableContains(context.scoring_hand, hand_card) then
                        if not (hand_card:is_suit('Clubs', nil, true) or hand_card:is_suit('Spades', nil, true)) then
                            held_match = false
                            break
                        end
                    end
                end
            end

            if all_black then
                local ret = {}

                if not (has_clubs and has_spades) then
                    ret.mult = card.ability.extra.base_mult
                end

                if has_clubs and has_spades then
                    ret.xmult = card.ability.extra.dual_xmult
                end

                if held_match then
                    ret.xmult = (ret.xmult or 1) * card.ability.extra.held_xmult
                    ret.xchips = card.ability.extra.held_xchips
                end

                return ret
            end
        end
    end
}

-- Helper function to check if a table contains an item
function tableContains(tbl, item)
    for _, v in ipairs(tbl) do
        if v == item then return true end
    end
    return false
end

SMODS.Joker {
    key = 'starwalker',
    loc_txt = {
        name = 'The original  {C:attention}starwalker{}',
        text = {
            "{s:2}* This sprite is {C:attention,s:2}pissing{} {s:2}me off...{}",
            "{C:inactive}--------------------------------",
            "Gives a random amount of {C:red}+Mult{} for each {C:attention}Diamonds{} played."
        }
    },
    config = { extra = { mult = 15 } },
    rarity = 2,
    atlas = 'ModdedVanilla3',
    pos = { x = 2, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    add_to_deck = function()
        play_sound('tngt_recruit')
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit('Diamonds') then
            local amount = pseudorandom('iwillalsojoin', 2, 12)
            return {
                mult = amount,
                message = "This card is pissing  me off.",
                colour = G.C.YELLOW
            }
        end
    end
}

SMODS.Joker {
    key = 'balatrez',
    loc_txt = {
        name = 'I {C;red}LOVE{} MY BEAUTIFUL {C:attention}JOKERS{}',
        text = {
            "Spawn a {C:attention}Gros Michel{} when you enter",
            "a {C:attention}boss{} blind.",
            "{C:inactive}Reacts differently if it's {C:attention}The Plant.{}"
        }
    },
    config = {},
    rarity = 2,
    atlas = 'ModdedVanilla4',
    pos = { x = 2, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local username = G.PROFILES[G.SETTINGS.profile].name
        return {
            vars = {},
            main_start = {
                { n = G.UIT.T, config = { text = username .. " Get The Banana.", scale = 0.35, colour = G.C.RARITY[4] } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.blind.boss then
            local spawn_key = (context.blind.name == "The Plant") and "j_cavendish" or "j_gros_michel"

            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({
                            set = "Joker",
                            key = spawn_key,
                            forced = true
                        })
                        G.GAME.joker_buffer = 0
                        card:juice_up(0.5, 0.5)
                        play_sound('tarot1')
                        return true
                    end
                }))

                return {
                    message = (spawn_key == "j_cavendish") and
                        "Cavendish" or
                        "Gros Michel",
                    colour = G.C.RARITY[4]
                }
            else
                return {
                    message = "No room:(",
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'nothing',
    loc_txt = {
        name = "{C:inactive}...{}",
        text = {
            "This {C:attention}#{} gains {C:attention}#{} for each {C:attention}#{}",
            "{C:attention}#{} in this run.{}",
            "{C:inactive}(Currently {C:attention}#{} {C:inactive}out of {C:attention}#{}{C:inactive})"
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla5',
    pos = { x = 2, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 1, xmult_gain = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker {
    key = 'melvin',
    loc_txt = {
        name = "Melvin {C:red}Mult{}",
        text = {
            "{C:red}+#1#{} Mult for each {C:attention}Joker{} in this run."
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla6',
    pos = { x = 2, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = { mult = 2.5 } },
    loc_vars = function(self, info_queue, card)
        local gem_alert = 0
        if G.jokers then
            for _, j in ipairs(G.jokers.cards) do
                if j ~= card and j.config.center.rarity > 1 then
                    gem_alert = gem_alert + 1
                end
            end
        end
        return { vars = { card.ability.extra.mult, gem_alert } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local gem_alert = 0
            for _, j in ipairs(G.jokers.cards) do
                if j ~= card and j.config.center.rarity > 1 then
                    gem_alert = gem_alert + 1
                end
            end

            if gem_alert > 0 then
                return {
                    mult = card.ability.extra.mult * gem_alert
                }
            end
        end
    end,

    sprite_effects = {
        on_trigger = function(card)
            if G.jokers then
                local gem_alert = 0
                for _, j in ipairs(G.jokers.cards) do
                    if j ~= card and j.config.center.rarity > 1 then
                        gem_alert = gem_alert + 1
                    end
                end
                if gem_alert > 0 then
                    card:juice_up(0.3, 0.3)
                end
            end
        end
    }
}

SMODS.Joker {
    key = 'kingbach',
    loc_txt = {
        name = "Aye dawg, can i get some {C:red}I{}{C:blue}c{}{C:gold}e{} {C:attention}cream?",
        text = {
            "{C:red}+#1#{} Mult,",
            "{C:blue}+#2#{} Chips,",
            "{C:gold}+$#3#{} Dollars,",
            "and {C:blue}15{} Bitches.",
            "{C:inactive}King Bach pulls out a Comically Large Spoon.{}"
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla7',
    pos = { x = 2, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            scoring_mult = 15,
            scoring_chips = 15,
            blind_dollars = 15
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.scoring_mult,
                card.ability.extra.scoring_chips,
                card.ability.extra.blind_dollars
            }
        }
    end,
    add_to_deck = function()
        play_sound('tngt_canigetsomeicecream')
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                sound = "tngt_onlyaspoonful",
                mult = card.ability.extra.scoring_mult,
                chips = card.ability.extra.scoring_chips,
                card = card
            }
        end
        if context.setting_blind and not context.blueprint then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.blind_dollars
            return {
                sound = "tngt_onlyaspoonful",
                dollars = card.ability.extra.blind_dollars,
                message = localize { type = 'variable', key = 'a_h_size_plus', vars = { card.ability.extra.h_size } },
                colour = G.C.MONEY,
                card = card
            }
        end
    end
}

SMODS.Joker {
    key = 'medicbag',
    loc_txt = {
        name = "Jallas",
        text = {
            "When exiting shop, rob initally {C:money}$1{} for every",
            "{C:money}$1{} worth of Jokers {C:attention}left in shop{C:white}",
            "{C:inactive}(Current shop value: {C:money}$#1#{C:inactive})"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla8',
    pos = { x = 2, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    config = { extra = { shop_value = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.shop_value } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        play_sound("tngt_aughhh", 1, 1)
    end,
    calculate = function(self, card, context)
        if context.starting_shop then
            card.ability.extra.shop_value = 0
            for _, shop_joker in ipairs(G.shop_jokers.cards) do
                if not shop_joker.uncosted then
                    card.ability.extra.shop_value = card.ability.extra.shop_value + shop_joker.cost
                end
            end
        end

        if context.ending_shop and card.ability.extra.shop_value > 0 then
            local payout = card.ability.extra.shop_value
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + payout

            return {
                card = card,
                sound = 'tngt_ineedamedicbag',
                extra = {
                    message = localize('k_from_leftovers'),
                    colour = G.C.UI.TEXT_LIGHT
                }
            }
        end
    end
}

SMODS.Joker {
    key = 'itstartswith',
    loc_txt = {
        name = "{C:attention}One{} thing, i {C:red}don't{} know {C:attention}why{}..",
        text = {
            "Gains {X:mult,C:white}X#1#{} for each {C:attention}played{} cards.",
            "{C:inactive}(Currently {X:mult,C:white}X#3#{} {C:inactive}Mult.)",
            "{C:inactive,s:0.7}(To be honest, this is just the worst version of Duplicare)",
            "{C:inactive,s:0.7}(It's here for balancing reason.)"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla9',
    pos = { x = 2, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            base_xmult = 1,
            mult_per_card = 0.1,
            cards_played = 0
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_per_card,
                card.ability.extra.cards_played,
                card.ability.extra.base_xmult + (card.ability.extra.cards_played * card.ability.extra.mult_per_card)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            local prev_mult = card.ability.extra.base_xmult +
            (card.ability.extra.cards_played * card.ability.extra.mult_per_card)

            card.ability.extra.cards_played = card.ability.extra.cards_played + #context.scoring_hand

            local new_mult = card.ability.extra.base_xmult +
            (card.ability.extra.cards_played * card.ability.extra.mult_per_card)

            if new_mult > prev_mult then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { new_mult }
                    },
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.base_xmult +
                (card.ability.extra.cards_played * card.ability.extra.mult_per_card)
            }
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.extra.cards_played = 0
        end
    end
}

SMODS.Joker {
    key = 'yogurt',
    loc_txt = {
        name = "{s:2}gurt:",
        text = {
            "yo",
            "{C:inactive}(Earn {C:gold}$#1#{} {C:inactive}when playing {C:attention}#2#{} {C:inactive}consecutive cards in order)"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla10',
    pos = { x = 2, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            streak = 0,
            last_id = nil,
            payout = 4,
            sequence_length = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.payout,
                card.ability.extra.sequence_length
            },
            colours = { G.C.MONEY, G.C.ATTENTION }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == (card.ability.extra.last_id or 0) + 1 then
                card.ability.extra.streak = card.ability.extra.streak + 1
                if card.ability.extra.streak % 3 == 0 then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.payout
                    return {
                        message = localize { type = 'variable', key = 'a_dollars',
                            vars = { card.ability.extra.payout } },
                        colour = G.C.MONEY
                    }
                end
            else
                card.ability.extra.streak = 0
            end
            card.ability.extra.last_id = context.other_card:get_id()
        end
    end
}

SMODS.Joker {
    key = 'freak',
    loc_txt = {
        name = '{f:tngt_papyrus}jofreak{}',
        text = {
            "{f:tngt_papyrus}i'm fr a {f:tngt_papyrus,X:dark_edition,C:white}freak{}, {f:tngt_papyrus}just {f:tngt_papyrus,C:attention,E:1}lmk...{}",
            "{f:tngt_papyrus}Played {f:tngt_papyrus,C:attention}6{} {f:tngt_papyrus}and {f:tngt_papyrus,C:attention}9{} {f:tngt_papyrus}has {f:tngt_papyrus,C:green}#1# in #2#{} {f:tngt_papyrus}chance to give {f:tngt_papyrus,X:mult,C:white}X6.9{} {f:tngt_papyrus}Mult."
        }
    },
    config = { extra = { odds = 2, xmult = 6.9 } },
    rarity = 3,
    atlas = 'ModdedVanilla',
    pos = { x = 3, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and (context.other_card:get_id() == 6 or context.other_card:get_id() == 9) and
            pseudorandom('luhhfreakyy') < G.GAME.probabilities.normal / card.ability.extra.odds then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

SMODS.Joker {
    key = 'friends',
    loc_txt = {
        name = 'Joker Inside Me',
        text = {
            "{X:mult,C:white}X#1#{} Mult for each remaining card in deck.",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla2',
    pos = { x = 3, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult * ((G.deck and G.deck.cards) and #G.deck.cards or 52) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult * #G.deck.cards
            }
        end
    end
}

SMODS.Joker {
    key = 'dud',
    loc_txt = {
        name = '{C:attention}dud{}',
        text = {
            "{C:red}You{} found the {C:attention}dud.{}",
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla3',
    pos = { x = 3, y = 0 },
    cost = 1,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult * ((G.deck and G.deck.cards) and #G.deck.cards or 52) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult * #G.deck.cards
            }
        end
    end
}

SMODS.Joker {
    key = 'omori',
    loc_txt = {
        name = "{f:tngt_omori}Junny{}",
        text = {
            "Opens {E:2}OMORI{} {C:blue}website{} if triggered",
            "{C:green}1{} in {C:green}1.000{} chances to fight {C:dark_edition}sans.{} instead."
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla4',
    pos = { x = 3, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            main_url = "https://omori-game.com",
            secret_url = "https://jcw87.github.io/c2-sans-fight/",
            odds = 1000,
            triggered = false
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.main_url }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not card.ability.extra.triggered and love.system then
            card.ability.extra.triggered = true

            local url = card.ability.extra.main_url
            local message = "OMORI"

            if pseudorandom('badtime' .. G.GAME.round_resets.ante) < G.GAME.probabilities.normal / card.ability.extra.odds then
                url = card.ability.extra.secret_url
                message = "ya wanna have a bad time?"
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        SMODS.add_card({
                            set = "Joker",
                            rarity = "Legendary"
                        })
                        card:juice_up(0.5, 0.5)
                        play_sound('tngt_neverforget', 1, 1)
                        card:start_dissolve()
                        return true
                    end
                }))
            end

            G.E_MANAGER:add_event(Event({
                func = function()
                    love.system.openURL(url)
                    return true
                end
            }))

            return {
                message = message,
                colour = (url == card.ability.extra.secret_url) and G.C.PURPLE or G.C.BLUE,
                sound = (url == card.ability.extra.secret_url) and 'tngt_neverforget' or nil
            }
        end
    end,
    reset_trigger = function(self, card)
        card.ability.extra.triggered = false
    end
}

SMODS.Joker {
    key = 'meth',
    loc_txt = {
        name = "{C:blue}Prio{C:red}rity.{}",
        text = {
            "Either {C:green,E:1}1{} in {C:green,E:1}#3#{} chances to grant {X:blue,C:white}X#1#{} Chips",
            "{C:red,s:2}OR{}",
            "{C:green,E:1}1{} in {C:green,E:1}1{} chance to grant {X:mult,C:white}X#2#{} Mult",
            "{C:inactive,s:0.7}Meth rules, tbh, no competition.{}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla5',
    pos = { x = 3, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = { extra = { xchips = 2.5, xmult = 1.5, odds = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xmult, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom("methstr8up:3") < 1 / card.ability.extra.odds then
                return {
                    xchips = card.ability.extra.xchips,
                    message = "SAVE CHILDREN.",
                    colour = G.C.CHIPS
                }
            else
                return {
                    xmult = card.ability.extra.xmult,
                    message = "M E T H",
                    colour = G.C.MULT
                }
            end
        end
    end
}

-- Shein, HeavenPierceHer, whatever the fuck, TYSMMMMMMM!!
SMODS.Joker {
    key = 'mone',
    loc_txt = {
        name = "imagine {X:gold,C:white}X3{} money",
        text = {
            "{X:mult,C:white}Heck{}, imagine {X:gold,C:white}X4{} mone.",
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla6',
    pos = { x = 3, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    config = { extra = { x = 5 } },
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            return {
                dollars = G.GAME.dollars * card.ability.extra.x - 1,
                message = "HECK.",
                message_card = card
            }
        end
    end
}

SMODS.Joker {
    key = 'lossforword',
    loc_txt = {
        name = "is this {C:red}loss{}????",
        text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult for each destroyed card.",
            "{C:inactive}(Currently {X:mult,C:white}X#3#{} {C:inactive}Mult.){}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla7',
    pos = { x = 3, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = { extra = { mult_per_card = 0.4, four_finger_bonus = 4, mult = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "Loss", set = "Other" }
        return {
            vars = {
                card.ability.extra.mult_per_card,
                card.ability.extra.four_finger_bonus,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local destroyed_count = #context.removed

            local four_finger_active = next(SMODS.find_card("j_four_fingers")) ~= nil

            if four_finger_active then
                card.ability.extra.mult = card.ability.extra.mult +
                    (destroyed_count * card.ability.extra.four_finger_bonus)
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.mult } },
                    colour = G.C.RED
                }
            else
                card.ability.extra.mult = card.ability.extra.mult +
                    (destroyed_count * card.ability.extra.mult_per_card)
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.mult } },
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end,
    callbacks = {
        on_play_destroy = function(card, context)
            card:juice_up(0.5, 0.5)
            return nil
        end
    }
}

local updatehook = Game.update
function Game:update(dt)
    updatehook(self, dt)
    if nxkoo_dies.show_mustard then
        nxkoo_dies.mustard_timer = nxkoo_dies.mustard_timer - dt
        if nxkoo_dies.mustard_timer <= 0 then
            nxkoo_dies.show_mustard = false
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()

    function load_image(fn)
        local full_path = (nxkoo_dies.path .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempimagedata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempimagedata)))
    end

    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080

    if nxkoo_dies.show_mustard then
        if not nxkoo_dies.mustard_png then
            nxkoo_dies.mustard_png = load_image("mustard.png")
        end
        local alpha = math.min(1, nxkoo_dies.mustard_timer * 2)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(nxkoo_dies.mustard_png, 0, 0, 0, _xscale, _yscale)
    end
end

SMODS.Joker {
    key = 'kendih',
    loc_txt = {
        name = ". . .{X:attention,C:white,s:2,E:2}M-{}",
        text = {
            "{C:green}1{} in {C:green}#1#{} chance for {C:attention}Kendih{}{f:tngt_emoji}🥀{}",
            "to scream {X:attention,C:white,s:2,E:2}MUSTARD{}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla8',
    pos = { x = 3, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = {
        chance = 4,
        xmult = 1000,
        variance = 5000
    } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chance,
                card.ability.extra.xmult,
                card.ability.extra.xmult + card.ability.extra.variance
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and pseudorandom('mustard') < G.GAME.probabilities.normal / card.ability.extra.chance then
            local multard = card.ability.extra.xmult +
                pseudorandom('mustard') % card.ability.extra.variance

            if not nxkoo_dies.mustard_png then
                nxkoo_dies.mustard_png = load_image("mustard.png")
            end
            nxkoo_dies.show_mustard = true
            nxkoo_dies.mustard_timer = 0.5

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                    card:juice_up(2, 2)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function()
                    play_sound('tngt_mustard', 1, 1000)
                    return true
                end)
            }))

            return {
                xmult = multard,
                sound = "tngt_neverforget",
                card = card,
            }
        end
    end
}

SMODS.Joker {
    key = 'dafoe',
    loc_txt = {
        name = "{C:blue}D:{}",
        text = {
            "{C:blue}+#1#{} Chips and {X:blue,C:white}X#2#{} Chips",
            "if the {C:blue}chip{} counter number is {C:gold}higher{} than the {C:red}Mult{} one"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla9',
    pos = { x = 3, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            chips = 200,
            xchips = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            if hand_chips > mult then
                play_sound('tngt_neverforget', 1.2)
                card:juice_up(0.5, 0.5)
                return {
                    colour = G.C.CHIPS,
                    chips = card.ability.extra.chips,
                    xchips = card.ability.extra.xchips
                }
            else
                card:juice_up(0.1, 0.1)
            end
        end
    end
}

SMODS.Joker {
    key = 'bepisfever',
    loc_txt = {
        name = "{C:blue,E:2}BEPIS{} MAN.",
        text = {
            "{X:blue,C:white}X#1#{} Chips for every {C:attention}#2#{} played {C:clubs}Clubs{}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla10',
    pos = { x = 3, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            xchips = 7,
            clubs_required = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "bepis", set = "Other" }
        return {
            vars = {
                card.ability.extra.xchips,
                card.ability.extra.clubs_required,
                G.GAME.current_round.clubs_played or 0,
                math.floor((G.GAME.current_round.clubs_played or 0) / card.ability.extra.clubs_required) *
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit('Clubs') then
            G.GAME.current_round.clubs_played = (G.GAME.current_round.clubs_played or 0) + 1
        end

        if context.joker_main then
            local club_batches = math.floor((G.GAME.current_round.clubs_played or 0) / card.ability.extra.clubs_required)
            return {
                xchips = club_batches * card.ability.extra.xchips,
                card_eval_status = (club_batches > 0) and 'active' or nil
            }
        end
    end,
    callbacks = {
        on_round_start = function(self, card)
            G.GAME.current_round.clubs_played = 0
        end
    }
}

SMODS.Joker {
    key = 'twintowers',
    loc_txt = {
        name = 'Never Forget',
        text = {
            "Enhance all",
            "played {C:attention}9{} and {C:attention}Aces{} into a Steel card",
            "and retrigger it {C:attention}twice{}",
            "{C:green}1 in 6{} chance to destroy played cards"
        }
    },
    config = { extra = { repetitions = 1 } },
    rarity = 2,
    atlas = 'ModdedVanilla',
    pos = { x = 4, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    end,
    calculate = function(self, card, context)
        local c = context.other_card
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 9 or context.other_card:get_id() == 14 then
                c:set_ability("m_steel")
                return {
                    repetitions = 2
                }
            end
        end

        if context.joker_main and not context.blueprint and pseudorandom('neverforget', 1, 6) == 1 then
            return {
                remove = true,
                message = "THEY HIT THE SECOND TOWER!",
                play_sound = "tngt_neverforget",
                colour = G.C.RED
            }
        end
    end
}

SMODS.Joker {
    key = 'chud	',
    loc_txt = {
        name = '{C:attention}High Card{} Has fallen.',
        text = {
            "{C:green}Jimbillions{} must play {C:attention}#2#{}",
            "{C:inactive}Seriously, who made this meme big, it sucks."
        }
    },
    config = { extra = { repetitions = 1 } },
    rarity = 2,
    atlas = 'ModdedVanilla2',
    pos = { x = 4, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 10, poker_hand = 'High Card' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == card.ability.extra.poker_hand then
            return {
                mult = card.ability.extra.xmult,
                message = 'West has fallen!',
                colour = G.C.RED
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and k ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = k
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('GAMBAGAMBA'))
            return {
                message = localize('k_reset')
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible then
                _poker_hands[#_poker_hands + 1] = k
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands,
            pseudoseed((card.area and card.area.config.type == 'title') and 'tngt_chud' or 'tngt_chud'))
    end
}

SMODS.Joker {
    key = 'johncena',
    config = { extra = { repetitions = 1 } },
    rarity = 2,
    atlas = 'ModdedVanilla3',
    pos = { x = 4, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            chips = 300,
            chip_loss = 50,
            xchips = 3,
            xchips_loss = 0.5
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chip_loss,
                card.ability.extra.xchips,
                card.ability.extra.xchips_loss
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and context.main_eval and not context.blueprint then
            if card.ability.extra.chips - card.ability.extra.chip_loss <= 0 or
                card.ability.extra.xchips - card.ability.extra.xchips_loss <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.4)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))

                return {
                    message = localize('k_melted_ex'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_loss
                card.ability.extra.xchips = card.ability.extra.xchips - card.ability.extra.xchips_loss

                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_chips_xchips_minus',
                        vars = {
                            card.ability.extra.chip_loss,
                            card.ability.extra.xchips_loss
                        }
                    },
                    colour = G.C.RED
                }
            end
        end

        -- Apply the current values when scoring
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                xchips = card.ability.extra.xchips
            }
        end
    end
}

SMODS.Joker {
    key = 'jesus',
    loc_txt = {
        name = "{C:gold}He{} has rizzen.",
        text = {
            "This Jesus gains {X:mult,C:white}X#2#{} Mult",
            "for each {X:dark_edition,C:white}Divine{} {X:dark_edition,C:white}Intervention{} happened in this run.",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
        }
    },
    config = { extra = { repetitions = 1 } },
    rarity = 2,
    atlas = 'ModdedVanilla4',
    pos = { x = 4, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 1, xmult_gain = 0.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            card.ability.extra.mult = card.ability.extra.xmult + 0.5
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { 0.5 } },
                colour = G.C.RED,
                card = card
            }
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    callbacks = {
        on_end_round = function(self, card)
            if not G.GAME.round_resets.turn and not G.GAME.round_resets.ante then
                card:juice_up(0.3, 0.3)
            end
            return nil
        end
    }
}

SMODS.Joker {
    key = 'divorce',
    loc_txt = {
        name = "She {C:attention{}took{} the {C:red}kids{} again..",
        text = {
            "This AirDrop gains {C:blue}+#3#{} Chips",
            "and {C:red}+#4#{} Mult for each {C:blue}Hands{} with no {C:attention}retriggers{}.",
            "{C:inactive}(Currently {C:blue}+#1#{} {C:inactive}Chips and {C:red}+#2#{} {C:inactive}Mult)"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla5',
    pos = { x = 4, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            chips = 0,
            mult = 0,
            chips_gain = 100,
            mult_gain = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.chips_gain, card.ability.extra.mult_gain }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card.scored then
                context.other_card.retriggered = true
            else
                context.other_card.scored = true
            end
        end

        if context.after and context.scoring_hand then
            local no_retrigger = true
            for _, v in ipairs(context.scoring_hand) do
                v.scored = nil
                if v.retriggered then
                    no_retrigger = false
                    v.retriggered = nil
                end
            end

            if no_retrigger then
                card.ability.extra.chips = card.ability.extra.chips + 100
                card.ability.extra.mult = card.ability.extra.mult + 5
                return {
                    message = "-$100 Child Support Money & -5 Kids",
                    colour = G.C.FILTER
                }
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
    key = 'donpollo',
    loc_txt = {
        name = "El que quiera perder el tiempo- {f:tngt_emoji}📞📞📞📞{}",
        text = {
            "Upon {C:attention}selecting a blind{} or {C:attention}exiting a shop{},",
            "create a {C:attention}Food{} Joker."
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla6',
    pos = { x = 4, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            chips = 0,
            mult = 0,
            chips_gain = 100,
            mult_gain = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if (context.setting_blind or context.ending_shop) and
            not context.blueprint and
            #G.jokers.cards < G.jokers.config.card_limit then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    SMODS.add_card({
                        set = "Food",
                        key_append = "gordon_ramsay"
                    })
                    card:juice_up(0.5, 0.5)
                    play_sound('tngt_neverforget', 1, 1)
                    return true
                end
            }))

            return {
                message = "DIO MÍO QUE HAGO",
                colour = G.C.BLUE
            }
        end
    end,

    sprite_effects = {
        on_trigger = function(card)
            if G.GAME.current_round and
                (G.GAME.current_round.blind_select or G.GAME.current_round.shop_ended) then
                card.children.floating_sprite:juice_up()
            end
        end
    }
}

--[[
SMODS.Joker {
	key = 'absolute',
	loc_txt = {
		name = "Absolute cinema",
		text = {
			"Upon {C:attention}selecting a blind{} or {C:attention}exiting a shop{},",
			"create a {C:attention}Food{} Joker."
		}
	},
	rarity = 2,
	atlas = 'ModdedVanilla7',
	pos = { x = 4, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			chips = 0,
			mult = 0,
			chips_gain = 100,
			mult_gain = 5
		}
	},	
	loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if next(SMODS.find_mod("kino")) and (context.setting_blind or context.ending_shop) and
           not context.blueprint and
           #G.jokers.cards < G.jokers.config.card_limit then

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    SMODS.add_card({
                        set = "Food",
                        key_append = "gordon_ramsay"
                    })
                    card:juice_up(0.5, 0.5)
                    play_sound('tngt_neverforget', 1, 1)
                    return true
                end
            }))

            return {
                message = "DIO MÍO QUE HAGO",
                colour = G.C.BLUE
            }
        end
    end,

    sprite_effects = {
        on_trigger = function(card)
            if G.GAME.current_round and
               (G.GAME.current_round.blind_select or G.GAME.current_round.shop_ended) then
                card.children.floating_sprite:juice_up()
            end
        end
    }
}
]]

SMODS.Joker {
    key = 'mentlegen',
    loc_txt = {
        name = "Buttsecks XD >:D",
        text = {
            "This Spy gives {C:blue}+#2#{} Chips and {C:red}+#1#{} Mult",
            "{C:inactive}However, if played hand is a {C:attention}Flush{} {C:inactive}or{} {C:attention}Five Of A Kind{}",
            "{}{X:blue,C:white}X#3#{} {C:inactive}Cloak instead"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla8',
    pos = { x = 4, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            base_mult = 3,
            xchips = 3.5,
            base_chips = 25
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base_mult,
                card.ability.extra.base_chips,
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand and #context.scoring_hand == 5 then
            local bonus_active = false
            local ret = {
                mult = card.ability.extra.base_mult,
                chips = card.ability.extra.base_chips
            }
            local all_same_suit = true
            local all_same_rank = true
            local first_suit = context.scoring_hand[1].base.suit
            local first_rank = context.scoring_hand[1]:get_id()
            for i = 2, #context.scoring_hand do
                if context.scoring_hand[i].base.suit ~= first_suit then
                    all_same_suit = false
                end
                if context.scoring_hand[i]:get_id() ~= first_rank then
                    all_same_rank = false
                end
                if not all_same_suit and not all_same_rank then break end
                if not bonus_active then
                    card:juice_up(0.2, 0.2)
                end
                if all_same_suit or all_same_rank then
                    bonus_active = true
                    ret.xchips = card.ability.extra.xchips
                    ret.message = localize { type = 'variable', key = 'a_xchips', vars = { card.ability.extra.xchips } }
                    play_sound('tngt_neverforget', 1.1)
                    card:juice_up(0.5, 0.5)
                    return ret
                end
            end
        end
    end
}

SMODS.Joker {
    key = 'whosbro',
    loc_txt = {
        name = "The Joker nobody invited:",
        text = {
            "This dude gives both {C:attention}Rare Tag{} and {C:attention}Negative Tag{}",
            "when {X:attention,C:white}IMMEDIATELY{} sold if you find or bought them.",
            "{C:inactive}(Who invited him.)"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla9',
    pos = { x = 4, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_rare', set = 'Tag' }
        info_queue[#info_queue + 1] = { key = 'tag_negative', set = 'Tag' }
        return {}
    end,
    calculate = function(self, card, context)
        if G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER then
            for _, booster_card in ipairs(G.booster_pack.cards) do
                if booster_card.config.center.key == self.key then
                    G.FUNCS.use_card(booster_card)
                    return {
                        message = "What's good gng",
                        colour = G.C.BLUE,
                        sound = 'chips1'
                    }
                end
            end
        end

        if G.shop_jokers and not context then
            for _, shop_card in ipairs(G.shop_jokers.cards) do
                if shop_card.config.center.key == self.key and G.GAME.dollars >= shop_card.cost then
                    G.FUNCS.buy_from_shop(shop_card)
                    return {
                        message = "Whaddup slime",
                        colour = G.C.GREEN,
                        sound = 'tngt_neverforget'
                    }
                end
            end
        end

        if context and context.selling_self and not context.blueprint then
            return {
                message = "YO WAI-",
                colour = G.C.PURPLE,
                sound = 'tarot1',
                func = function()
                    add_tag(Tag("tag_rare"))
                    add_tag(Tag("tag_negative"))
                    play_sound('tngt_neverforget', 1.2)
                    card:juice_up(0.8, 0.5)
                end
            }
        end
    end,
    callbacks = {
        on_shop_refresh = function(card)
            card:calculate()
        end,
        on_booster_opened = function(card)
            card:calculate()
        end
    }
}

SMODS.Joker {
    key = 'thisdogisfuckedup',
    loc_txt = {
        name = "This Joker is {C:red,E:2}fucked up{} {f:tngt_times}brah..{f:tngt_emoji}🥀",
        text = {
            "The first {C:attention}face card{} played",
            "each round gets retriggered {C:attention}thrice",
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla10',
    pos = { x = 4, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            retriggered = false,
            first_face_card = nil
        }
    },
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.retriggered = false
            card.ability.extra.first_face_card = nil
        end

        if context.individual and context.cardarea == G.play and
            not card.ability.extra.retriggered then
            local is_face = (context.other_card:get_id() == 11 or
                context.other_card:get_id() == 12 or
                context.other_card:get_id() == 13)

            if is_face and not card.ability.extra.first_face_card then
                card.ability.extra.first_face_card = context.other_card
            end
        end

        if context.repetition and context.cardarea == G.play and
            not card.ability.extra.retriggered and
            card.ability.extra.first_face_card and
            context.other_card == card.ability.extra.first_face_card then
            card.ability.extra.retriggered = true
            return {
                repetitions = 3,
                card = card
            }
        end
    end
}

SMODS.Joker {
    key = 'lowtiergod',
    loc_txt = {
        name = '{C:red}Low{}{C:gold}Tier{}{C:dark_edition}God{}',
        text = {
            "{X:attention,C:white}X#1#{} Blind Requirements"
        }
    },
    rarity = 4,
    atlas = 'ModdedVanilla',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    config = { extra = 0.5 },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.GAME.blind.chips = math.floor(G.GAME.blind.chips * card.ability.extra)
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

                    local chips_UI = G.hand_text_area.blind_chips
                    G.FUNCS.blind_chip_UI_scale(chips_UI)
                    G.HUD_blind:recalculate()

                    if context.blueprint_card then
                        context.blueprint_card:juice_up()
                    else
                        card:juice_up()
                    end
                    chips_UI:juice_up()
                    play_sound('tngt_NOW')

                    return true
                end
            }))
        end
    end
}

--[[
SMODS.Joker {
	key = 'sybau',
	loc_txt = {
		name = '{f:tngt_times}SYBAU{}{f:tngt_emoji}💔{}',
		text = {
			"Every {C:attention}played cards{} are retriggered {C:attention}twice{},",
			"but {C:dark_edition}shut yo bitch ass up.{}"
		}
	},
	rarity = 4,
	atlas = 'ModdedVanilla2',
	pos = { x = 0, y = 1 },
	soul_pos = { x = 4, y = 1 },
	cost = 20,
	unlocked = true,
	discovered = true,
	config = { extra = {
        stored_volumes = {music = 0, sounds = 0, master = 0},
        mute_duration = 0.5
    }},

    loc_vars = function(self, info_queue, card)
        return { vars = { "2×" }, retriggers = 2 }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if card.ability.extra.stored_volumes.music == 0 then
                card.ability.extra.stored_volumes = {
                    music = G.SETTINGS.SOUND.music_volume,
                    sounds = G.SETTINGS.SOUND.sounds_volume,
                    master = G.SETTINGS.SOUND.master_volume
                }
            end

            G.SETTINGS.SOUND.music_volume = 0
            G.SETTINGS.SOUND.sounds_volume = 0
            G.SETTINGS.SOUND.master_volume = 0

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = card.ability.extra.mute_duration,
                blockable = false,
                func = function()
                    self:restore_volumes(card)
                    return true
                end
            }))

            return {
                repetitions = 2,
                colour = G.C.BLUE
            }
        end
    end,

    restore_volumes = function(self, card)
        if card and card.ability and card.ability.extra and card.ability.extra.stored_volumes then
            G.SETTINGS.SOUND.music_volume = card.ability.extra.stored_volumes.music
            G.SETTINGS.SOUND.sounds_volume = card.ability.extra.stored_volumes.sounds
            G.SETTINGS.SOUND.master_volume = card.ability.extra.stored_volumes.master
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        self:restore_volumes(card)
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and context.cards and #context.cards > 0 then
            for _, c in ipairs(context.cards) do
                if c == card then
                    self:restore_volumes(card)
                    break
                end
            end
        end
    end
}
]]

--[[
SMODS.Joker {
	key = 'you',
	loc_txt = {
		name = '{f:tngt_DETERMINATION}You{}',
		text = {
			"{f:tngt_DETERMINATION,}* Despite everything, it's still you.{}"
		}
	},
	config = { extra = {} },
	rarity = 4,
	atlas = 'ModdedVanilla3',
	pos = { x = 0, y = 1 },
	soul_pos = { x = 4, y = 1 },
	cost = 20,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
	end,
	calculate = function(self, card, context)
		if context.ending_shop then
			G.E_MANAGER:add_event(Event({
				func = function()
					local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('perkeo2')), nil)
					card:set_edition('e_negative', true)
					card:add_to_deck()
					G.consumeables:emplace(card)
					return true
				end
			}))
			card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
				{ message = localize('k_duplicated_ex') })
		end
	end,
in_pool = function(self, args)
        return G.GAME.pool_flags.vremade_gros_michel_extinct
    end
}
]]
SMODS.Joker {
    key = 'flamingo',
    loc_txt = {
        name = "{C:red,E:1}F{}{C:green,E:1}l{C:blue,E:1}a{}{C:red,E:1}m{C:green,E:1}i{C:blue,E:1}n{C:red,E:1}g{C:green,E:1}o{C:blue,E:1}.",
        text = {
            "If played hand is a {C:attention}Flush{}, convert",
            "all cards in hand to the suit of the played hand."
        }
    },
    config = { extra = {} },
    rarity = 4,
    atlas = 'ModdedVanilla4',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.after and context.poker_hands and context.poker_hands['Flush'] and #context.poker_hands['Flush'] > 0 then
            local flush_cards = context.poker_hands["Flush"][1]
            local example_card = flush_cards[1]
            if example_card and example_card.base and example_card.base.suit then
                local flush_suit = example_card.base.suit

                for _, c in ipairs(G.hand.cards) do
                    if c and c.base then
                        SMODS.change_base(c, flush_suit)
                        c:juice_up(0.5, 0.5)
                    end
                end

                return {
                    message = "Shrimps are pretty rich.",
                    colour = G.C.SUITS[flush_suit]
                }
            end
        end
    end
}

-- Huge thanks to N` / Somethingcom515 / SleepyG11 / HeavenPierceHer / HuyTheKiller | For the help with the compatibility indicator and merge function.
SMODS.Joker {
    key = 'jarvis',
    loc_txt = {
        name = "Clearly, {C:red}you{} don't {C:attention}own{} a {C:blue}Blueprint{}",
        text = {
            "Copies the abilities of both left AND right {C:attention}Jokers{}.",
            "{C:inactive}(Jarvis, inspect this guy's balls.)"
        }
    },
    config = { extra = {} },
    rarity = 4,
    atlas = 'ModdedVanilla6',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = {},

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local left_joker, right_joker = nil, nil
            local left_compat, right_compat = false, false

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    left_joker = G.jokers.cards[i - 1]
                    right_joker = G.jokers.cards[i + 1]
                    break
                end
            end

            left_compat = left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat
            right_compat = right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat

            local left_indicator = {
                n = G.UIT.C,
                config = {
                    align = "cm",
                    padding = 0.05,
                    minw = 1.5,
                    r = 0.1,
                    colour = left_compat and G.C.GREEN or G.C.RED
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            text = "← " .. (left_joker and string.sub(left_joker.config.center.name, 1, 8) or "None"),
                            scale = 0.32,
                            colour = G.C.UI.TEXT_LIGHT
                        }
                    }
                }
            }

            local right_indicator = {
                n = G.UIT.C,
                config = {
                    align = "cm",
                    padding = 0.05,
                    minw = 1.5,
                    r = 0.1,
                    colour = right_compat and G.C.GREEN or G.C.RED
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            text = (right_joker and string.sub(right_joker.config.center.name, 1, 8) or "None") .. " →",
                            scale = 0.32,
                            colour = G.C.UI.TEXT_LIGHT
                        }
                    }
                }
            }

            return {
                main_end = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm", padding = 0, minh = 0.6 },
                        nodes = { left_indicator, right_indicator }
                    }
                },
                vars = {
                    left_compat and "Compatible" or "Incompatible",
                    right_compat and "Compatible" or "Incompatible"
                }
            }
        end
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if not G.jokers then return nil end

        local left_effect, right_effect = nil, nil

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                local left_joker = G.jokers.cards[i - 1]
                local right_joker = G.jokers.cards[i + 1]

                if left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat then
                    left_effect = SMODS.blueprint_effect(card, left_joker, context)
                end

                if right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat then
                    right_effect = SMODS.blueprint_effect(card, right_joker, context)
                end
                break
            end
        end

        if left_effect or right_effect then
            local merged_effect = SMODS.merge_effects(
                { left_effect or {} },
                { right_effect or {} }
            )

            return merged_effect
        else
            return nil
        end
    end,
}

SMODS.Joker {
    key = 'spoiler',
    loc_txt = {
        name = "{X:dark_editon,C:white}(SPOILER){}",
        text = {
            "All cards {C:attention}held in hand{} are flipped",
            "But each cards contains {X:mult,C:white}X#1#{} Mult.",
            "{C:inactive}(Spoiler it bro, it just came out yesterday..){}"
        }
    },
    config = { extra = {} },
    rarity = 4,
    atlas = 'ModdedVanilla7',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = {
        extra = {
            xmult = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.xmult }
        }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            for _, v in ipairs(G.hand.cards) do
                if v.ability.play_flipped ~= true then
                    v.ability.play_flipped = true
                    v:flip()
                end
            end
        end

        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.play_flipped then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end

        if context.end_of_round then
            for _, v in ipairs(G.hand.cards) do
                if v.ability.play_flipped then
                    v.ability.play_flipped = nil
                    v:flip()
                end
            end
        end
    end
}

--[[
SMODS.Joker {
	key = 'flightreacts',
	loc_txt = {
			name = "There's no {C:dark_edition}limit{} in {C:attention}glazing{}",
		text = {
            "If you reach next {C:attention}Ante{}",
            "in {C:attention}#2#{} rounds or less,",
            "create a {C:dark_edition}negative{} copy of",
            "a random {C:uncommon}Uncommon Joker{}",
            "{C:inactive}(Current round: {C:attention}#3#{C:inactive})"
		}
	},
	rarity = 4,
	atlas = 'ModdedVanilla8',
	pos = { x = 0, y = 1 },
	soul_pos = { x = 4, y = 1 },
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
    eternal_compat = true,
    config = {
        extra = {
            max_rounds = 2,
            ante_target = 1,
            activated = false
        }
    },
	loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.ante_target,
                card.ability.extra.max_rounds,
                G.GAME.round_resets.ante,
                G.GAME.round
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not card.ability.extra.activated then
            if G.GAME.round_resets.ante >= card.ability.extra.ante_target and
               G.GAME.round <= card.ability.extra.max_rounds then
                card.ability.extra.activated = true

                local uncommon_jokers = {}
                for _, joker in pairs(G.P_CENTER_POOLS.Joker) do
                    if joker.rarity == 2 then
                        table.insert(uncommon_jokers, joker.key)
                    end
                end

                if #uncommon_jokers > 0 and #G.jokers.cards < G.jokers.config.card_limit then
                    local chosen_key = pseudorandom_element(uncommon_jokers, pseudoseed('damndaniel'))
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local new_joker = SMODS.add_card({
                                set = "Joker",
                                key = chosen_key,
                                edition = "e_negative",
                                from_card = card
                            })
                            new_joker:juice_up()
                            play_sound('tngt_neverforget', 1.1)
                            return true
                        end
                    }))

                    return {
                        message = localize('k_plus_joker').." ("..localize('k_negative_edition')..")",
                        colour = G.C.PURPLE
                    }
                end
            elseif G.GAME.round > card.ability.extra.max_rounds then
                card.ability.extra.activated = true
                return {
                    message = "damn daniel..",
                    colour = G.C.RED
                }
            end
        end
    end
}
]]

SMODS.Joker {
    key = 'whuh',
    loc_txt = {
        name = "What in the {C:red,E:2}fuck{}",
        text = {
            "{C:green}In the Before Times{}, when the cosmos was young and {C:blue}probability", -- AI slop, im not finishing writing this stupid ass description just for a shit joker
            "still flowed like {C:red}molten gold through the veins of creation, the",
            "{C:attention}Elder Gods of Chance forged this artifact from the {C:purple}crystallized",
            "essence of infinite {X:green,C:white}possibilities{}. Its very existence {C:red}warps the",
            "fundamental {C:green}mathematics of luck itself to serve its {C:attention}chosen bearer",
            "",
            "{C:mult}+#1#{} to thy {C:attention}Eternal Mult - {C:green}not merely a number, but a {C:tarot}sacred covenant with the {C:blue}arithmetic deities, elevating thy",
            "scoring potential {C:red}beyond mortal comprehension. Each point",
            "represents one of the {C:dark_edition}Ten Commandments of {C:green}Gambling handed",
            "down from the {C:purple}High Priests of Poker to their {C:blue}chosen disciples",
            "",
            "{C:chips}+#2#{} to thy {C:attention}Divine Chips - {C:green}a blessing so potent that even the {C:red}lowliest High Card shall shine with the {C:blue}radiance of",
            "a {C:attention}Royal Flush. These chips contain {C:tarot}fragments of the",
            "{C:purple}original dice cast by the {C:red}Fates when determining the",
            "{C:blue}destinies of men and {C:attention}gods alike",
            "",
            "{X:mult,C:white}X#3#{} to thy {C:attention}Cosmic Multiplier - {C:green}a coefficient of such {C:red}magnitude that {C:blue}Pythagoras himself would weep at its {C:purple}perfection",
            "This {C:tarot}golden ratio of victory transforms {C:green}modest hands into",
            "{C:attention}earth-shaking triumphs, each multiplication {C:red}echoing through",
            "the {C:blue}infinite gambling halls of the {X:purple,C:white}multiverse",
            "",
            "{X:chips,C:white}#4#{} to thy {C:attention}Apocalyptic Chips - {C:red}a doubling so {C:green}profound that it creates {C:blue}ripples in the {C:purple}space-time continuum of chance",
            "{C:tarot}Legend tells that when this {C:attention}multiplier activates, the",
            "{C:green}ghost of {X:green,C:white}Cardano{} can be heard {C:blue}cheering from beyond the",
            "{C:red}veil of probability",
            "",
            "{C:attention}WARNING: The {C:purple}Vatican's Secret Gambling Division has classified this Joker as a '{C:red}Divine Intervention Level' artifact",
            "{C:green}Prolonged exposure may cause:",
            "{C:blue}- Spontaneous combustion of nearby poker chips",
            "{C:red}- Unexplained appearance of royal flushes",
            "{C:tarot}- Temporary omniscience regarding river cards",
            "{C:purple}- Permanent alteration of local probability fields",
            "",
            "The {C:attention}Archdeacon of Blackjack has declared that {C:red}three (3) of these",
            "Jokers constitutes a {C:blue}Class-X Miracle",
            "and must be reported to the {C:green}International Luck Regulatory Board",
            "",
            "{C:tarot}Handle with reverence, for you wield {C:red}not merely a game piece,",
            "but a {C:attention}fragment of the primordial chaos from which all",
            "{C:purple}gambling was born. May your victories be {C:blue}legendary, your",
            "{C:green}draws fortunate, and your opponents {C:red}forever in awe of your",
            "{C:attention}divinely-enhanced statistical superiority"
        }
    },
    config = { extra = {} },
    rarity = 4,
    atlas = 'ModdedVanilla9',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = {
        extra = {
            mult = 10,
            chips = 50,
            xmult = 1.5,
            xchips = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips,
                card.ability.extra.xmult,
                card.ability.extra.xchips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
                xmult = card.ability.extra.xmult,
                xchips = card.ability.extra.xchips,
                card = card
            }
        end
    end
}

SMODS.Joker {
    key = 'wherethefuck',
    loc_txt = {
        name = "{f:tngt_DETERMINATION,s:2}GOD FUCKING DAMNIT {C:blue,f:tngt_DETERMINATION,s:2}KRIS{}",
        text = {
            "{f:tngt_DETERMINATION,X:mult,C:white}X2.75{} {f:tngt_DETERMINATION}Mult If played hand has exactly",
            "{f:tngt_DETERMINATION,C:attention}4{} {f:tngt_DETERMINATION} cards of the same suit."
        }
    },
    rarity = 4,
    atlas = 'ModdedVanilla10',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = {
        extra = {
            xmult = 2.75
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits_in_hand = {}

            for _, playing_card in ipairs(context.scoring_hand) do
                if not playing_card.debuff then -- Ignore debuffed cards
                    for suit, _ in pairs(G.C.SUITS) do
                        if playing_card:is_suit(suit) then
                            suits_in_hand[suit] = true
                        end
                    end
                end
            end

            local suit_count = 0
            for _ in pairs(suits_in_hand) do
                suit_count = suit_count + 1
            end

            if suit_count == 2 then
                return {
                    xmult = card.ability.extra.xmult,
                    message = localize('k_two_suits'),
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'mario',
    loc_txt = {
        name = "I've fucking had it with you",
        text = {
            "{C:attention,s:2}Woe!{}",
            "{C:red}Bricks{} be upon ye.",
            "{C:inactive,s:0.5}--------------------------------{}",
            "Each {C:attention}played{} Stone card permanently gains {C:red}+#1#{} Mult."
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla3',
    pos = { x = 1, y = 1 },
    soul_pos = { x = 5, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = { extra = { mult = 2 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, "m_stone") then
                context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) +
                    card.ability.extra.mult
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.EDITION.BLUE
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'teto',
    loc_txt = {
        name = "{C:red,s:2}TETO.{}",
        text = {
            "Played {C:red}Hearts{} will gives you either {X:mult,C:white}+#1#{} Mult,",
            "{X:mult,C:white}X#2#{} Mult, {X:mult,C:white}+#3#{} Chips, or {X:mult,C:white}$#4#{} Dollars.",
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla4',
    pos = { x = 1, y = 1 },
    cost = 7,
    unlocked = true,
    discovered = true,
    config = { extra = { mult_bonus = 20, xmult_bonus = 11, chip_bonus = 20.12, dollar_bonus = 14 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "teto", set = "Other" }
        return { vars = { card.ability.extra.mult_bonus, card.ability.extra.xmult_bonus, card.ability.extra.chip_bonus, card.ability.extra.dollar_bonus } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card.base and context.other_card.base.suit == 'Hearts' then
            local bonus_type = pseudorandom('IFUCKINGLOVEKASANETETO', 1, 4)
            local extra = card.ability.extra

            if bonus_type == 1 then
                return {
                    mult = extra.mult_bonus,
                    colour = G.C.SUITS.Hearts
                }
            elseif bonus_type == 2 then
                return {
                    xmult = extra.xmult_bonus,
                    colour = G.C.SUITS.Hearts
                }
            elseif bonus_type == 3 then
                return {
                    chips = extra.chip_bonus,
                    colour = G.C.SUITS.Hearts
                }
            elseif bonus_type == 4 then
                return {
                    dollars = extra.dollar_bonus,
                    colour = G.C.SUITS.Hearts
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'logan',
    loc_txt = {
        name = "I think i {C:attention}saw{} someone",
        text = {
            "This guy gains {X:blue,C:white}X#2#{} Dislikes",
            "for each {C:attention}Hanged Man{} used in this run.",
            "{C:inactive}(Currently {X:blue,C:white}X#1#{} {C:inactive}Dislikes)",
            "{C:inactive,s:0.9}I have made a severe lapse in my judgement.{}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla5',
    pos = { x = 1, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = { extra = { xchips = 1, xchips_gain = 0.5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_hanged_man
        return { vars = { card.ability.extra.xchips, card.ability.extra.xchips_gain } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.config.center.key == "c_hanged_man" then
            card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
            return {
                message = "Severe lapse in my judgement.",
                colour = G.C.TAROT
            }
        end

        if context.joker_main then
            return {
                x_chips = card.ability.extra.xchips
            }
        end
    end
}

SMODS.Joker {
    key = 'bwomp',
    loc_txt = {
        name = "{C:blue}Bwomp{}",
        text = {
            "{X:chips,C:white}X#1#{} Chips if it's your last {C:blue}hand{} of the round.",
            "{C:inactive}How is this even possible?{}"
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla6',
    pos = { x = 1, y = 1 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = { xchips = 3.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                sound = "tngt_bwomp",
                x_chips = card.ability.extra.xchips
            }
        end
    end
}

SMODS.Joker {
    key = 'fourloko',
    loc_txt = {
        text = {
            "This dude gains {X:mult,C:white}X#2#{} if played hand is a {C:attention}Four Of A Kind.{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla7',
    pos = { x = 1, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 1, xmult_gain = 0.4 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands['Four of a Kind']) then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

SMODS.Joker {
    key = "upyourass",
    loc_txt = {
        name = "Whoops!",
        text = {
            "{X:mult,C:white}X#1#{} Mult if {C:attention}CD{} is inserted",
            "if you don't have any, it will be {C:dark_edition}automatically{}",
            "created if you play {C:attention}#2#{} {C:blue}Hands"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla8',
    pos = { x = 1, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            xmult = 10,
            hands_played = 0,
            hands_needed = math.random(4, 5)
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.hands_needed } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.joker_main and not context.blueprint then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1

            if card.ability.extra.hands_played >= card.ability.extra.hands_needed then
                local success, err = pcall(function()
                    local file = io.open("CD.txt", "w")
                    if file then
                        file:write("CD INSERTED.")
                        file:close()
                    end
                end)

                if not success then
                    print("MISSINGNO", err)
                end

                card.ability.extra.hands_played = 0
                card.ability.extra.hands_needed = math.random(4, 5)
            end
        end

        local file_exists = io.open("CD.txt", "r")
        if file_exists then
            file_exists:close()
            os.remove("CD.txt")

            return {
                message = "CD INSERTED.",
                mult = card.ability.extra.xmult,
                sound = 'tngt_neverforget'
            }
        end
    end
}

SMODS.Joker {
    key = "noassforoldman",
    loc_txt = {
        name = "Call it.",
        text = {
            "{C:chips}+#1#{} Chips or {C:mult}+#1#{} Mult,",
            "call it."
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla9',
    pos = { x = 1, y = 1 },
    cost = 1,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            bonus = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.bonus },
            colours = { G.C.CHIPS, G.C.MULT }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local is_chips = pseudorandom('coin_flip_' .. G.GAME.round_resets.ante) < 0.5

            if is_chips then
                return {
                    chips = card.ability.extra.bonus,
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.bonus } },
                    colour = G.C.CHIPS
                }
            else
                return {
                    mult = card.ability.extra.bonus,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.bonus } },
                    colour = G.C.MULT
                }
            end
        end
    end
}

local updatehook = Game.update
function Game:update(dt)
    updatehook(self, dt)
    if nxkoo_dies.show_flashbang then
        nxkoo_dies.flashbang_timer = nxkoo_dies.flashbang_timer - dt
        if nxkoo_dies.flashbang_timer <= 0 then
            nxkoo_dies.show_flashbang = false
            nxkoo_dies.current_flashbang = nil
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()

    function load_flashbang(fn)
        local full_path = (nxkoo_dies.path .. "customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempflashbangdata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempflashbangdata)))
    end

    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080

    if nxkoo_dies.show_flashbang and nxkoo_dies.current_flashbang then
        local alpha = math.min(1, nxkoo_dies.flashbang_timer * 2)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(nxkoo_dies.current_flashbang, 0, 0, 0, _xscale, _yscale)
    end
end

SMODS.Joker {
    key = "flasbangout",
    loc_txt = {
        name = "Think fast, {C:dark_edition}Chucklenuts",
        text = {
            "Throwing {C:attention}flashbangs{} for ALL interactions",
            "Gains {C:chips}+#1#{} Chips per unique flashbang",
            "Gains {X:mult,C:white}X#2#{} Mult when scoring",
            "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips and {X:mult,C:white}X#4#{C:inactive} Mult)"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla10',
    pos = { x = 1, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {
        extra = {
            base_chips = 50,
            chip_per_flashbang = 25,
            base_mult = 1,
            mult_per_flashbang = 0.5,
            flashbangs_shown = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chip_per_flashbang,
                card.ability.extra.mult_per_flashbang,
                card.ability.extra.base_chips +
                (card.ability.extra.flashbangs_shown * card.ability.extra.chip_per_flashbang),
                card.ability.extra.base_mult +
                (card.ability.extra.flashbangs_shown * card.ability.extra.mult_per_flashbang)
            }
        }
    end,

    show_omnipotent_flashbang = function(self, card, flashbang_key)
        if not nxkoo_dies.flashbangs_loaded then
            for k, v in pairs(nxkoo_dies.flashbangs) do
                nxkoo_dies.flashbangs[k] = load_flashbang(v)
            end
            nxkoo_dies.flashbangs_loaded = true
        end

        nxkoo_dies.current_flashbang = nxkoo_dies.flashbangs[flashbang_key]
        nxkoo_dies.show_flashbang = true
        nxkoo_dies.flashbang_timer = 0.75

        if not card.ability.extra.shown_flashbangs then
            card.ability.extra.shown_flashbangs = {}
        end

        if not card.ability.extra.shown_flashbangs[flashbang_key] then
            card.ability.extra.shown_flashbangs[flashbang_key] = true
            card.ability.extra.flashbangs_shown = card.ability.extra.flashbangs_shown + 1

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                blockable = false,
                func = function()
                    play_sound('tarot1', 1.2, 0.4)
                    card:juice_up(0.5, 0.5)
                    return true
                end
            }))
        end
    end,

    calculate = function(self, card, context)
        if context.starting_shop and not context.blind then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'shop')
        end

        if context.ending_shop and not context.blind then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'shop')
        end

        if context.buying_card then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'shop')
        end

        if context.selling_card then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'shop')
        end

        if context.reroll_shop then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'shop')
        end

        if G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'shop')
        end

        if context.setting_blind and context.blind then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'blind')
        end

        if context.skip_blind then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'shop')
        end

        if G.GAME.blind and G.GAME.blind.boss and context.end_of_round and not context.game_over then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'blind')
        end

        if context.before and context.main_eval then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'hand_played')
        end

        if context.discard then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'discard')
        end

        if context.end_of_round and not context.blueprint then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'round_start')
        end

        if context.joker_main then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'joker_trigger')

            local chips = card.ability.extra.base_chips +
                (card.ability.extra.flashbangs_shown * card.ability.extra.chip_per_flashbang)
            local mult = card.ability.extra.base_mult +
                (card.ability.extra.flashbangs_shown * card.ability.extra.mult_per_flashbang)

            return {
                chips = chips,
                xmult = mult,
                card_eval_status = 'jokers'
            }
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        card.ability.extra.shown_flashbangs = {}
        card.ability.extra.flashbangs_shown = 0
    end
}

SMODS.Joker {
    key = 'virtual',
    loc_txt = {
        name = "Jokeroquai",
        text = {
            "Earn {C:gold}$#1#{} Dollars",
            "for each {C:attention}insanity{} occurence."
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla3',
    pos = { x = 2, y = 1 },
    soul_pos = { x = 3, y = 1 },
    cost = 2,
    unlocked = true,
    discovered = true,
    config = { extra = { interest = -1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.interest } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.interest_amount = G.GAME.interest_amount + card.ability.extra.interest
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.interest_amount = G.GAME.interest_amount - card.ability.extra.interest
    end
}

SMODS.Joker {
    key = 'lockin',
    loc_txt = {
        name = "Time to {C:attention,E:2}lock in.",
        text = {
            "This Monkey will {X:gold,C:white}double{} your {C:gold}cash{}",
            "if you didn't {C:attention}buy{} {E:2}anything{} from the last {C:attention}Shop{}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla2',
    pos = { x = 3, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    config = { extra = {} },

    calculate = function(self, card, context)
        if context.ending_shop and not context.blueprint then
            local purchases_made = false

            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.shop_was_bought then
                    purchases_made = true
                    break
                end
            end

            if not purchases_made then
                for _, consumable in ipairs(G.consumeables.cards) do
                    if consumable.ability.shop_was_bought then
                        purchases_made = true
                        break
                    end
                end
            end

            if not purchases_made then
                return {
                    dollars = G.GAME.dollars,
                    message = "LOCK THE FUCK IN.",
                    colour = G.C.MONEY,
                    message_card = card
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        local original_buy_card = buy_card
        buy_card = function(args)
            local bought_card = original_buy_card(args)
            if bought_card then
                bought_card.ability.shop_was_bought = true
            end
            return bought_card
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        buy_card = G.FUNCS.buy_card
    end
}

SMODS.Joker {
    key = 'youtried',
    loc_txt = {
        name = "{C:red}You{}{C:attention} Tried.{}",
        text = {
            "This Joker gains {X:mult,C:white}X#2#{} Mult",
            "for each time a blind is {C:attention}defeated{}",
            "with no {C:blue}Hands{} remaining.",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}"
        }
    },
    config = { extra = { xmult = 1, xmult_gain = 0.5 } },
    rarity = 2,
    atlas = 'ModdedVanilla4',
    pos = { x = 3, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            if G.GAME.current_round.hands_left == 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = "ay caramba",
                    colour = G.C.RED
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end

}

SMODS.Joker {
    key = 'bigjustice',
    loc_txt = {
        name = "broski tweakin{f:tngt_emoji}🙏🔥💀{}",
        text = {
            "After playing {C:attention}5 Big Booms{}",
            "{C:inactive}5 Big Booms = 5 played cards with ranks above 5{}",
            "Spawn {C:tarot}Justice{}"
        }
    },
    rarity = 2,
    cost = 5,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = true,
    atlas = 'ModdedVanilla5',
    pos = { x = 3, y = 1 },
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_justice
        return {}
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint and context.full_hand then
            local all_above_five = true
            for _, v in ipairs(context.full_hand) do
                if v:get_id() <= 5 then
                    all_above_five = false
                    break
                end
            end
            if all_above_five and #context.full_hand == 5 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        SMODS.add_card { set = 'Tarot', key = 'c_justice' }
                        return true
                    end
                }))
                return {
                    message = "Choco Chip Cookie.",
                    colour = G.C.TAROT
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'markimoo',
    loc_txt = {
        name = "Hello {C:attention}everybody{}, my name is {X:mult,C:white}Mult{}{C:red}iplier.{}",
        text = {
            "{C:red}+#1#{} Mult, otherwise {X:mult,C:white}X#2#{} Mult."
        }
    },
    rarity = 1,
    cost = 3,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = true,
    atlas = 'ModdedVanilla6',
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            base_mult = 9,
            mult_plier = 87,
            chance = 6
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base_mult,
                card.ability.extra.mult_plier,
                card.ability.extra.chance
            },
            colours = { nil, G.C.RED }
        }
    end,

    calculate = function(self, card, context)
    if context.joker_main and pseudorandom('mustard') < G.GAME.probabilities.normal / card.ability.extra.chance then
                card:juice_up(1, 0.8)
                play_sound('tarot1', 1.2)
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.mult_plier } },
                    xmult = card.ability.extra.mult_plier,
                    colour = G.C.RED,
                    card_eval = card
                }
            else
                return {
                    mult = card.ability.extra.base_mult,
                    card_eval = card
                }
            end
    end
}

SMODS.Joker {
    key = 'scary',
    loc_txt = {
        name = "{C:red}. . .",
        text = {
            "#"
        }
    },
    rarity = 2,
    cost = 4,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = true,
    atlas = 'ModdedVanilla7',
    pos = { x = 3, y = 1 },
    config = { extra = { mult_per_card = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "scary", set = "Other" }
        return { vars = { card.ability.extra.mult_per_card } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local numbered_cards = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                local card_id = playing_card:get_id()
                if card_id >= 2 and card_id <= 10 then
                    numbered_cards = numbered_cards + 1
                end
            end

            if numbered_cards > 0 then
                return {
                    mult = numbered_cards * card.ability.extra.mult_per_card,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'Ligma',
    loc_txt = {
        name = "Sigma {f:tngt_emoji}🗿{}",
        text = {
            "Earn {C:gold}$#1#{} at end of round,",
            "payout increases by {C:gold}$2{} for each defeated blind,",
            "Decreases by {C:red}$#2#{} after defeating a boss blind."
        }
    },
    rarity = 2,
    cost = 5,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = true,
    atlas = 'ModdedVanilla8',
    pos = { x = 3, y = 1 },
    config = { extra = { normal_reward = 2, boss_penalty = -3 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.normal_reward,
                card.ability.extra.boss_penalty
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            local amount = G.GAME.blind.boss and card.ability.extra.boss_penalty
                or card.ability.extra.normal_reward

            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + amount

            return {
                message = localize {
                    type = 'variable',
                    key = amount > 0 and 'a_dollars' or 'a_dollars_minus',
                    vars = { math.abs(amount) }
                },
                colour = amount > 0 and G.C.MONEY or G.C.RED,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}

SMODS.Joker {
    key = 'grippy',
    loc_txt = {
        name = "pipe down pookie",
        text = {
            "Duplicates all {C:attention}Played{} cards if",
            "it's the {C:attention}first hand{} of the round, but {C:tarot,E:2}pauses your game{}",
            "whenever you enter a {C:attention}shop{}."
        }
    },
    rarity = 2,
    cost = 6,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = true,
    atlas = 'ModdedVanilla9',
    pos = { x = 3, y = 1 },
    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    -- thanks to senfinbrare for the code and help
    calculate = function(self, card, context)
        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 then
            local copy_cards = {}
            for _, original_card in ipairs(context.full_hand) do
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copy_card = copy_card(original_card, nil, nil, G.playing_card)
                copy_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copy_card)
                G.hand:emplace(copy_card)
                copy_card.states.visible = nil
                copy_cards[#copy_cards + 1] = copy_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        copy_card:start_materialize()
                        return true
                    end
                }))
            end
            return {
                message = localize('k_copied_ex'),
                colour = G.C.PURPLE,
                card = card,
                playing_cards_created = copy_cards
            }
        end
        if context.first_hand_drawn and not context.blueprint then
            local eval = function()
                return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES
            end
            juice_card_until(card, eval, true)
        end
        if context.starting_shop and G.CONTROLLER then
            return {
                func = function()
                    G.CONTROLLER:key_press_update("escape", true)
                    G.CONTROLLER:key_press_update("escape", false)

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function() return true end
                    }))
                end
            }
        end
    end
}

SMODS.Joker {
    key = 'getthefuckout',
    loc_txt = {
        name = "{f:tngt_times}get the fuck out",
        text = {
            "FREE {C:gold}$#1#{} UPON {C:attention}PURCHASE!!!",
            "fixed {C:green}#2#{} chance to escorts you to your fucking {C:attention}Desktop",
            "{C:attention}fuck you."
        }
    },
    rarity = 2,
    cost = 4,
    discovered = true,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = true,
    atlas = 'ModdedVanilla10',
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            reward = 200,
            quit_chance = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.reward,
                tostring(math.floor(card.ability.extra.quit_chance * 100)) .. "%"
            },
            colours = { G.C.MONEY, G.C.RED }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            if pseudorandom('gettthefuckout') < G.GAME.probabilities.normal / card.ability.extra.quit_chance then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        love.event.quit()
                        return true
                    end
                }))
                return {
                    message = "get the fuck out",
                    colour = G.C.RED,
                    sound = 'tngt_neverforget'
                }
            else
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.reward
                return {
                    message = localize { type = 'variable', key = 'a_dollars', vars = { card.ability.extra.reward } },
                    colour = G.C.MONEY,
                    sound = 'chips1',
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end,
    add_to_deck = function(self, card)
        G.GAME.seed = G.GAME.seed + 1
    end
}

SMODS.Joker {
    key = "birdthatihate",
    loc_txt = {
        name = "That {C:red,s:2}FUCKIN'{} {C:green}Bird{} That I {C:attention}Hate{}"
    },
    rarity = 3,
    atlas = 'ModdedVanilla4',
    pos = { x = 2, y = 1 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local c = context.other_card
            local is_last_card = c == G.play.cards[#G.play.cards]

            return {
                xmult = 2,
                sound = is_last_card and "tngt_thatFUCKINbirdthatihate" or "tngt_birdthatihate",
                message = is_last_card and "T H A T  F U C K I N '  B I R D  T H A T  I  H A T E." or nil
            }
        end
    end
}

SMODS.Joker {
    key = "pizza",
    loc_txt = {
        name = "Pizza..",
        text = {
            "{X:chips,C:white}X#1#{} Chips and {X:mult,C:white}X#2#{} Mult",
            "Has {C:green}1 in #3#{} chance to be 'consumed' at end of round.",
            "{C:inactive,s:0.7}--------------------------------{}",
            "{s:0.7}Nxkoo says :{}",
            "{C:inactive}STOP MAKING JOKES ABOUT PIZZA. >:({}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla5',
    pos = { x = 2, y = 1 },
    cost = 4,
    unlocked = true,
    discovered = true,
    config = { extra = { xchips = 2.5, xmult = 1.5, odds = 6 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xmult, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
                chips = card.ability.extra.xchips
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval then
            if pseudorandom('pizzafuckerowo') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve()
                        play_sound('tarot1')
                        return true
                    end
                }))
                return {
                    message = "FUCKED.",
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker {
    key = "Ass",
    loc_txt = {
        name = "Joker World",
        text = {
            "{C:attention}Playing{} a hand that contains an {C:attention}Ace{} and a {C:attention}Pair of 5s{}",
            "will {C:attention}level up {C:green,E:2}mostly{} {C:attention}Full House{}."
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla6',
    pos = { x = 2, y = 1 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            if next(context.poker_hands["Full House"]) then
                local has_ace = false
                local has_two_fives = false
                local five_count = 0

                for _, c in ipairs(context.scoring_hand) do
                    if c:get_id() == 14 then
                        has_ace = true
                    elseif c:get_id() == 5 then
                        five_count = five_count + 1
                    end
                end

                has_two_fives = (five_count == 2)

                if has_ace and has_two_fives then
                    return {
                        level_up = true,
                        level_up_hand = "Full House",
                        message = localize('k_level_up_ex'),
                        colour = G.C.BLUE
                    }
                end
            end
        end
    end
}

local click_ref = Card.click
function Card:click()
    local ret = click_ref(self)
    SMODS.calculate_context { clicked_card = self }
end

SMODS.Joker {
    key = "danger",
    loc_txt = {
        name = "I am {X:mult,C:white}NOT{} in {C:red}danger{}, Jimbo",
        text = {
            "Knocking on this door will gain you {C:red}+25{} Mult.",
            "{C:inactive}(Only knock {C:attention}once{} {C:inactive}per {C:attention}Ante{}{C:inactive}, he's {C:red}busy{}{C:inactive}){}",
            "{C:inactive}(Currently {C:red}#1# Knocks{}{C:inactive}, you are the one who knocks.)"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla7',
    pos = { x = 2, y = 1 },
    cost = 4,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            knock_count = 0,
            mult_per_knock = 25,
            last_click_round = -1
        }
    },
    calculate = function(self, card, context)
        if context.clicked_card and context.clicked_card == card then
            if G.GAME.round_resets.ante ~= card.ability.extra.last_click_round then
                card.ability.extra.knock_count = (card.ability.extra.knock_count or 0) + 1
                card.ability.extra.last_click_round = G.GAME.round_resets.ante

                card:juice_up(0.5, 0.5)
                play_sound('tngt_iamindanger', 1.0 + math.random() * 0.1)
            end
        end

        if context.joker_main then
            local total_mult = (card.ability.extra.knock_count or 0) * (card.ability.extra.mult_per_knock or 25)
            return {
                mult = total_mult,
                message = total_mult > 0 and ("Knocks: " .. card.ability.extra.knock_count .. " (+" .. total_mult .. " Mult)") or
                nil,
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_per_knock or 25,
                card.ability.extra.knock_count or 0
            },
            main_start = {
                { n = G.UIT.T, config = { text = " | I AM THE DANGER! |", scale = 0.4, colour = G.C.RED } },
                { n = G.UIT.T, config = { text = " Knocks: " .. (card.ability.extra.knock_count or 0), scale = 0.35, colour = G.C.MULT } },
                { n = G.UIT.T, config = { text = " | Current Mult: +" .. (card.ability.extra.knock_count or 0) * 10, scale = 0.35, colour = G.C.MULT } }
            }
        }
    end
}

SMODS.Joker {
    key = "slopperin",
    loc_txt = {
        name = "The boy's hungry",
        text = {
            'After playing a hand,',
            'create {C:attention}1{} random {C:common}Common Joker{}',
            'and {C:attention}1{} random {C:attention}consumable{}',
            '{C:inactive}(Must have room)'
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla8',
    pos = { x = 2, y = 1 },
    cost = 4,
    unlocked = true,
    discovered = true,
    config = { extra = {} },

    calculate = function(self, card, context)
        if context.after and not context.blueprint and context.cardarea == G.play then
            local can_spawn_joker = G.jokers and #G.jokers.cards < G.jokers.config.card_limit
            local can_spawn_consumable = G.consumeables and
                (#G.consumeables.cards + (G.GAME.consumeable_buffer or 0)) < G.consumeables.config.card_limit

            if can_spawn_joker or can_spawn_consumable then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        if can_spawn_joker then
                            SMODS.add_card({
                                set = 'Joker',
                                rarity = 'Common',
                                key_append = 'sloplive2'
                            })
                        end

                        if can_spawn_consumable then
                            local consumable_types = { 'Tarot', 'Planet', 'Spectral' }
                            local selected_type = pseudorandom_element(consumable_types, pseudoseed('sloppy'))
                            SMODS.add_card({
                                set = selected_type,
                                key_append = 'sloplive3'
                            })
                        end

                        card:juice_up()
                        return true
                    end
                }))
            end

            return {
                message = can_spawn_joker or can_spawn_consumable and localize('k_created_ex') or
                localize('k_no_space_ex'),
                colour = can_spawn_joker or can_spawn_consumable and G.C.GREEN or G.C.RED
            }
        end
    end
}

SMODS.Joker {
    key = "gooning",
    loc_txt = {
        name = "The aggresive Jooner:",
        text = {
            'Gains {C:red}+#2#{} Mult per second',
            'After {C:attention}60 seconds{C:black}, scales {C:red}+#3#{} per second',
            '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)',
            '{C:attention}Resets when sold'
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla9',
    pos = { x = 2, y = 1 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            base_mult = 0,
            base_rate = 1,
            scaled_rate = 0.1,
            start_time = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base_mult,
                card.ability.extra.base_rate,
                card.ability.extra.scaled_rate
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.start_time = love.timer.getTime()
        card.ability.extra.base_mult = 0
    end,

    update = function(self, card, dt)
        if not card.ability.extra.start_time then
            card.ability.extra.start_time = love.timer.getTime()
        end

        local elapsed = love.timer.getTime() - card.ability.extra.start_time
        local base_seconds = math.min(elapsed, 60)
        local bonus_seconds = math.max(0, elapsed - 60)

        card.ability.extra.base_mult =
            (base_seconds * card.ability.extra.base_rate) +
            (bonus_seconds * (card.ability.extra.base_rate + card.ability.extra.scaled_rate))
    end,

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.base_mult > 0 then
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { math.floor(card.ability.extra.base_mult) } },
                mult = math.floor(card.ability.extra.base_mult),
                colour = G.C.RED,
                card = card
            }
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        card.ability.extra.base_mult = 0
        card.ability.extra.start_time = love.timer.getTime()
    end
}

SMODS.Joker {
    key = "morshu",
    loc_txt = {
        name = "{C:attention}Come back{} when you a little, {X:green,C:white}mmmmmm{}, {C:gold}richer",
        text = {
            "When you have between {C:attention}$#2#-{}",
            "{C:attention}$#3#{}, gives {C:money}#1#%{} discount",
            "{C:inactive}(Updates when money changes)"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla10',
    pos = { x = 2, y = 1 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            discount_percent = 75,
            threshold = 100,
            buffer = 15
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.discount_percent,
                card.ability.extra.threshold - card.ability.extra.buffer,
                card.ability.extra.threshold + card.ability.extra.buffer
            },
            colours = { G.C.MONEY, G.C.FILTER }
        }
    end,
    calculate = function(self, card, context)
        if (context.dollars_modified or context.first_hand_drawn) and not context.blueprint then
            local current_money = G.GAME.dollars + (G.GAME.dollar_buffer or 0)
            local lower_bound = card.ability.extra.threshold - card.ability.extra.buffer
            local upper_bound = card.ability.extra.threshold + card.ability.extra.buffer

            if current_money >= lower_bound and current_money <= upper_bound then
                G.GAME.discount_percent = card.ability.extra.discount_percent
                card:juice_up(0.5, 0.5)
            else
                G.GAME.discount_percent = 0
            end

            G.E_MANAGER:add_event(Event({
                func = function()
                    for _, v in pairs(G.I.CARD) do
                        if v.set_cost then v:set_cost() end
                    end
                    return true
                end
            }))
        end
    end,

    remove_from_deck = function(self, card)
        G.GAME.discount_percent = 0
        for _, v in pairs(G.I.CARD) do
            if v.set_cost then v:set_cost() end
        end
    end
}

SMODS.Joker {
    key = 'kanye',
    loc_txt = {
        name = 'Kanye Gaming',
        text = {
            "This Kanye gains {X:green,C:white}+1!{} Mult for",
            "each time he's {C:attention}gotten{} into a {C:red}controversy{}",
            "{C:inactive}(Currently {X:green,C:white}6!{} {C:inactive}Mult)"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla',
    pos = { x = 1, y = 1 },
    cost = 4,
    unlocked = true,
    discovered = true,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        local factorial_mult = 1
        for i = 1, 6 do
            factorial_mult = factorial_mult * i
        end

        return { vars = { factorial_mult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = 720
            }
        end
    end
}

SMODS.Joker {
    key = 'crash',
    loc_txt = {
        name = '{C:red}Finna Crashout{}',
        text = {
            "{X:mult,C:white}X#1#{} Mult for each {C:red}Crash Logs{}",
            "in your {C:attention}Desktop{}",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla2',
    pos = { x = 1, y = 1 },
    cost = 7,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult * (#NFS.getDirectoryItems(SMODS.MODS_DIR .. "/lovely/log")) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult * #G.deck.cards
            }
        end
    end
}

SMODS.Joker {
    key = 'backshots',
    loc_txt = {
        name = 'who wnats b{f:tngt_emoji}💔{}ckshots {f:tngt_emoji}🥀{}',
        text = {
            "This devious {C:red}backshots{} gains {X:mult,C:white}X#1#{} Mult",
            "for each scored lowest ranked cards {C:inactive}(2 - 5).{}",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult)"
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla',
    pos = { x = 2, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    config = { extra = { mult_per_low_card = 0.8 } },

    loc_vars = function(self, info_queue, card)
        local current_xmult = 1
        if G.play and G.play.cards then
            local low_card_count = 0
            for _, played_card in ipairs(G.play.cards) do
                local rank = played_card:get_id()
                if rank >= 2 and rank <= 5 then
                    low_card_count = low_card_count + 1
                end
            end
            current_xmult = 1 + (card.ability.extra.mult_per_low_card * low_card_count)
        end

        return {
            vars = {
                card.ability.extra.mult_per_low_card,
                current_xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local low_card_count = 0
            for _, played_card in ipairs(context.scoring_hand) do
                local rank = played_card:get_id()
                if rank >= 2 and rank <= 5 then
                    low_card_count = low_card_count + 1
                end
            end

            if low_card_count > 0 then
                return {
                    x_mult = 1 + (card.ability.extra.mult_per_low_card * low_card_count)
                }
            end
        end
    end
}


SMODS.Joker {
    key = 'love',
    loc_txt = {
        name = '{C:hearts}Love{} is in the air?',
        text = {
            "{C:red,s:2}WRONG!{}",
            "If your scoring hand catches on fire, gives {C:money}$#1#",
            "{E:1,C:green}otherwise{}, set your score to {C:dark_edition}false infinite.{}"
        }
    },
    config = { extra = { dollars = 25, odds = 6 } },
    rarity = 2,
    atlas = 'ModdedVanilla2',
    pos = { x = 2, y = 1 },
    cost = 5,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, (G.GAME.probabilities.normal or 6), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if (context.joker_main) then
            local hand = G.GAME.current_round.current_hand
            local hand_score = get_numeric(hand.chips) * get_numeric(hand.mult)
            local blind = get_numeric(G.GAME.blind.chips)
            print("hand_score:", hand_score, "blind:", blind)
            if hand_score >= blind then
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = "$" .. card.ability.extra.dollars,
                    colour = G.C.MONEY,
                }
            elseif pseudorandom("BAZINGA!") < G.GAME.probabilities.normal / 6 then
                return {
                    message = "WRONG!",
                    mult = - -math.huge,
                    colour = G.C.DARK_EDITION,
                }
            end
        end
    end,
}



SMODS.Joker {
    key = 'dingaling',
    loc_txt = {
        name = 'when they touchse yo {C:gold}dingaling{}',
        text = {
            "{X:blue,C:white}X#1#{} Chips and {X:mult,C:white}X#2#{} Mult",
            "if you touched their {C:attention}#3#{} of {C:attention}#4#.{}",
            "{C:inactive}({C:attention}dingalings{} {C:inactive}changes every round.)"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla',
    pos = { x = 3, y = 1 },
    cost = 4,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    config = {
        extra = {
            x_chips = 2,
            x_mult = 1.5
        }
    },

    loc_vars = function(self, info_queue, card)
        local picked_card = G.GAME.current_round.card_picker_selection or { rank = 'Ace', suit = 'Spades' }
        return {
            vars = {
                card.ability.extra.x_chips,
                card.ability.extra.x_mult,
                localize(picked_card.rank, 'ranks'),
                localize(picked_card.suit, 'suits_plural')
            },
            colours = { G.C.SUITS[picked_card.suit] }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            G.GAME.current_round.card_picker_selection then
            if context.other_card:get_id() == G.GAME.current_round.card_picker_selection.id and
                context.other_card:is_suit(G.GAME.current_round.card_picker_selection.suit) then
                return {
                    x_mult = card.ability.extra.x_mult,
                    x_chips = card.ability.extra.x_chips
                }
            end
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

SMODS.Joker {
    key = 'critikal',
    loc_txt = {
        name = 'Card check {f:tngt_emoji}👀{}',
        text = {
            "{X:mult,C:white}X#1#{} Mult for each",
            "card above {C:attention}#4#{}",
            "in your full deck",
            "{C:inactive}Currently {X:mult,C:white}X#3#{} {C:inactive}Mult)"
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla',
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            xmult_per_card = 0.05
        }
    },

    loc_vars = function(self, info_queue, card)
        local extra_cards = math.max(0, G.playing_cards and #G.playing_cards - G.GAME.starting_deck_size or 0)
        local total_xmult = 1 + (extra_cards * card.ability.extra.xmult_per_card)
        return {
            vars = {
                card.ability.extra.xmult_per_card,
                extra_cards,
                total_xmult,
                G.GAME.starting_deck_size
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local extra_cards = math.max(0, #G.playing_cards - G.GAME.starting_deck_size)
            return {
                x_mult = 1 + (extra_cards * card.ability.extra.xmult_per_card),
                card = card
            }
        end
    end
}

--[[
SMODS.Joker {
	key = 'solly',
	loc_txt = {
		name = '{C:green}weed{} joker {C:red}tf{}{C:blue}2{} {C:red}(high af){}',
		text = {
            "If played hand is a {C:attention}#1#{}, retriggers it equal to their rank",
            "fixed {C:green}#2#{} chance to Soldier to {C:red}shoot{} the Blind with {C:dark_edition}Rocket Launcher."
		}
	},
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	atlas = 'ModdedVanilla2',
	pos = { x = 5, y = 0 },
	config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = { "High Card", "50%" } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.repetition and next(context.poker_hands['High Card']) then
            local retriggers = 0
            local highest_rank = 0

            for _, playing_card in ipairs(context.scoring_hand) do
                local rank = playing_card:get_id()
                if rank > highest_rank then
                    highest_rank = rank
                end
            end

            if highest_rank >= 11 and highest_rank <= 14 then
                retriggers = 10
            elseif highest_rank <= 10 then
                retriggers = highest_rank
            end
            if retriggers > 0 then
                return {
                    repetitions = retriggers,
                    message = localize{type='variable', key='a_repetitions', vars={retriggers}},
                    card = card
                }
            end
        end
        if context.after and context.joker_main then
            if pseudorandom('DOMINATED') < 0.5 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tngt_neverforget', 1.2)
                        G.GAME.chips = G.GAME.blind.chips
                        G.STATE = G.STATES.HAND_PLAYED
                        G.STATE_COMPLETE = true
                        end_round()
                        return true
                    end
                }))
                return {
                    message = "DOMINATED, CYCLOPS.",
                    colour = G.C.GOLD,
                    card = card
                }
            end
        end
    end
}
]]

SMODS.Joker {
    key = 'puzzles',
    loc_txt = {
        name = "{C:attention}I'd{} like to solve the {C:green}puzzle{}",
        text = {
            "{X:mult,C:white}X#1#{} Mult per {C:attention}vowel{} in name of card to its {C:attention}left{}",
            "{X:blue,C:white}X#2#{} Chips per {C:attention}consonant{} in name of card to its {C:attention}right{}",
            "{X:mult,C:white}X1.5{} bonus if descriptions match",
            "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult and {X:blue,C:white}X#4#{C:inactive} Chips)"
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla3',
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            mult_per_vowel = 1.5,
            chips_per_consonant = 2.5,
            current_mult = 0,
            current_chips = 0,
            description_bonus = 1.5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_per_vowel,
                card.ability.extra.chips_per_consonant,
                card.ability.extra.current_mult,
                card.ability.extra.current_chips
            }
        }
    end,

    update = function(self, card, dt)
        if G.jokers then
            local self_id = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then self_id = i end
            end

            card.ability.extra.current_mult = 0
            card.ability.extra.current_chips = 0
            local bonus_multiplier = 1

            local left_vowels = 0
            local left_description = nil
            if self_id and self_id > 1 then
                local left_card = G.jokers.cards[self_id - 1]
                local left_name = left_card.config.center.name

                if string.find(left_name, "j_") then
                    left_name = left_card.config.center.loc_txt.name
                    left_description = left_card.config.center.loc_txt.text
                end

                left_vowels = #string.gsub(left_name, "[AEIOUaeiou]", "")
                card.ability.extra.current_mult = left_vowels + card.ability.extra.mult_per_vowel
            end

            local right_consonants = 0
            local right_description = nil
            if self_id and G.jokers.cards[self_id + 1] then
                local right_card = G.jokers.cards[self_id + 1]
                local right_name = right_card.config.center.name

                if string.find(right_name, "j_") then
                    right_name = right_card.config.center.loc_txt.name
                    right_description = right_card.config.center.loc_txt.text
                end

                right_consonants = #string.gsub(right_name, "[^A-Za-z]", "") -
                    #string.gsub(right_name, "[AEIOUaeiou]", "")
                card.ability.extra.current_chips = right_consonants + card.ability.extra.chips_per_consonant
            end

            if left_description and right_description and
                tostring(left_description) == tostring(right_description) then
                bonus_multiplier = card.ability.extra.description_bonus
                card.ability.extra.current_mult = card.ability.extra.current_mult * bonus_multiplier
                card.ability.extra.current_chips = card.ability.extra.current_chips * bonus_multiplier
            end
        end
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local bonus_active = false
            local self_id = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then self_id = i end
            end

            if self_id then
                local left_description = nil
                local right_description = nil

                if self_id > 1 then
                    local left_card = G.jokers.cards[self_id - 1]
                    if left_card.config.center.loc_txt then
                        left_description = left_card.config.center.loc_txt.text
                    end
                end

                if G.jokers.cards[self_id + 1] then
                    local right_card = G.jokers.cards[self_id + 1]
                    if right_card.config.center.loc_txt then
                        right_description = right_card.config.center.loc_txt.text
                    end
                end

                bonus_active = left_description and right_description and
                    tostring(left_description) == tostring(right_description)
            end

            return {
                mult = card.ability.extra.current_mult,
                xchips = card.ability.extra.current_chips,
                card = card,
                colour = bonus_active and G.C.PURPLE or G.C.RED
            }
        end
    end
}

SMODS.Joker {
    key = 'proceed',
    loc_txt = {
        name = "{f:DETERMINATION,C:gold}PROCEED.{}",
        text = {
            "When starting a {C:attention}new round{}, immediately draw",
            "Ace of {C:red}Hearts{} and play it.",
            "{C:inactive}There's no such thing as free will."
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 3,
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = { chips = 0, chip_mod = 3 } },
    atlas = 'ModdedVanilla4',
    pos = { x = 5, y = 0 },
    loc_vars = function(self, info_queue, card)
        return {
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                delay = 0.2,
                func = function()
                    local _card = SMODS.add_card({
                        set = "Playing Card",
                        rank = "Ace",
                        suit = "Hearts"
                    })
                    G.hand:add_to_highlighted(_card)
                    G.FUNCS.play_cards_from_highlighted()
                    return true
                end
            }))
            return {
                message = "P R O C E E D.",
                colour = G.C.SUITS.Hearts
            }
        end
        if context.individual and context.joker_main then
            return {
                sound = "tngt_snowgrave",
                xmult = 99999999999999999999999,
            }
        end
    end
}

SMODS.Joker {
    key = 'dudeperson',
    loc_txt = {
        name = "Joker J. Jimbo",
        text = {
            "{C:red}+#1#?{} Mult"
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            mults = { 4, 44, 444, 4.444 }
        }
    },
    atlas = 'ModdedVanilla5',
    pos = { x = 5, y = 0 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = card.ability.extra.mults
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            local mults = card.ability.extra.mults
            local chosen = pseudorandom_element(mults, pseudoseed("Foursome"))
            return {
                mult = chosen,
                message = "+#1#? Mult",
                colour = G.C.MULT
            }
        end
    end
}

SMODS.Joker {
    key = 'fantastic',
    loc_txt = {
        name = "Joker {C:blue}Four{}",
        text = {
            "If your played hand is a {C:attention}Straight Flush{},",
            "create a {C:gold,E:2}Familiar {C:attention}Spectral{} Card."
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla6',
    pos = { x = 5, y = 0 },
    config = { extra = { spectrals = { "familiar", "grim", "incantation", "talisman", "immolate", "ankh", "trance", "cryptid" } } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_familiar
        info_queue[#info_queue + 1] = G.P_CENTERS.c_grim
        info_queue[#info_queue + 1] = G.P_CENTERS.c_incantation
        info_queue[#info_queue + 1] = G.P_CENTERS.c_talisman
        info_queue[#info_queue + 1] = G.P_CENTERS.c_immolate
        info_queue[#info_queue + 1] = G.P_CENTERS.c_ankh
        info_queue[#info_queue + 1] = G.P_CENTERS.c_trance
        info_queue[#info_queue + 1] = G.P_CENTERS.c_cryptid
        return {}
    end,
    calculate = function(self, card, context)
        if context.scoring_name == 'Straight Flush' and not context.blueprint then
            for _, key in ipairs(card.ability.extra.spectrals) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        SMODS.add_card { set = 'Spectral', key = pseudorandom_element(card.ability.extra.spectrals, "saythatagain") }
                        return true
                    end
                }))
            end
            return {
                message = "..Say that again?",
                colour = G.C.TAROT
            }
        end
    end
}

--[[
SMODS.Joker {
	key = 'waddle',
	loc_txt = {
		name = "Do you got any {C:blue}Venus?{}",
		text = {
			"{s:1.5}And he said 'No, we only have {C:blue,s:1.5}#1#{}'",
			"{C:inactive}-----------------------------------------{}",
			"This Duck {C:red,E:2}self destructs{} and gives {C:gold}$30{} if you {C:attention}use{} {C:blue}#1#{}",
			"{C:inactive}And he waddled away, waddle waddle.."
		}
	},
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	atlas = 'ModdedVanilla7',
	pos = { x = 5, y = 0 },	
		config = { extra = { desired_planet = "c_mercury" } },
		loc_vars = function(self, info_queue, card)
			local planet_name = card.ability.extra.desired_planet
			return { vars = { localize{ type = "name_text", set = "Planet", key = card.ability.extra.desired_planet } } }
		end,
		calculate = function(self, card, context)
			if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
				if context.consumeable.config.center.key == card.ability.extra.desired_planet then
					G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 30

					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tngt_neverforget')
							card.T.r = -0.2
							card:juice_up(0.3, 0.4)
							card.states.drag.is = true
							card.children.center.pinch.x = true
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.3,
								blockable = false,
								func = function()
									card:remove()
									return true
								end
							}))
							return true
						end
					}))
					
					return {
						dollars = 30,
						message = "And he waddle away, waddle waddle!",
						colour = G.C.MONEY,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									G.GAME.dollar_buffer = 0
									return true
								end
							}))
						end
					}
				end
			end

			if context.setting_blind and not context.blueprint then
				local planet_keys = {}
				for k, _ in pairs(G.P_CENTER_POOLS.Planet) do
					if string.match(k, "^c_") then
						table.insert(planet_keys, k)
					end
				end

				local new_planet = card.ability.extra.desired_planet
				while new_planet == card.ability.extra.desired_planet and #planet_keys > 1 do
					new_planet = pseudorandom_element(planet_keys, pseudoseed('andhewaddleaway'..G.GAME.round_resets.ante))
				end
				
				card.ability.extra.desired_planet = new_planet
				return {
					message = localize('k_reset'),
					colour = G.C.BLUE
				}
			end
		end,
		add_to_deck = function(self, card, from_debuff)
			if not card.ability.extra.desired_planet then
				local planet_keys = {}
				for k, _ in pairs(G.P_CENTER_POOLS.Planet) do
					if string.match(k, "^c_") then
						table.insert(planet_keys, k)
					end
				end
				card.ability.extra.desired_planet = pseudorandom_element(planet_keys, pseudoseed('andhewaddleaway'))
			end
		end
	}
]]

SMODS.Joker {
    key = 'ashbaby',
    loc_txt = {
        name = "{C:inactive}AAAAAAAAAAAAA{}",
        text = {
            "{C:attention}Destroyed{} cards has {C:green}1{} in {C:green}#3#{} chance to be {C:attention}duplicated{}",
            "and gains {X:mult,C:white}X#1#{} for each destroyed cards",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult)"
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 3,
    cost = 6,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla8',
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            xmult = 1,
            xmult_gain = 2,
            odds = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult,
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local destroyed_count = 0

            for _, removed_card in ipairs(context.removed) do
                destroyed_count = destroyed_count + 1

                if pseudorandom('wootwoot' .. G.GAME.round_resets.ante) < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local copy = copy_card(removed_card, nil, nil, nil, removed_card.edition)
                    copy:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand:emplace(copy)
                            copy:start_materialize()
                            play_sound('tarot1', 0.9)
                            return true
                        end
                    }))
                end
            end

            if destroyed_count > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + (destroyed_count * card.ability.extra.xmult_gain)
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { card.ability.extra.xmult }
                    },
                    colour = G.C.PURPLE
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker {
    key = 'djkhaled',
    loc_txt = {
        name = "WE THE BEST JOKER.",
        text = {
            "{C:inactive}Does nothing?"
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla9',
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            slots_to_add = 5,
            ante_requirement = 1,
            ante_count = 0,
            activated = false
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.slots_to_add,
                card.ability.extra.ante_requirement,
                card.ability.extra.ante_count
            }
        }
    end,
    calculate = function(self, card, context)
        if G.GAME.blind.boss and context.end_of_round and context.game_over == false and context.main_eval then
            card.ability.extra.ante_count = card.ability.extra.ante_count + 1

            if card.ability.extra.ante_count >= card.ability.extra.ante_requirement then
                card.ability.extra.activated = true
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots_to_add

                card:juice_up(0.8, 0.8)
                play_sound('chips1', 1.4)
                return {
                    message = localize { type = 'variable', key = 'a_joker_slots', vars = { card.ability.extra.slots_to_add } },
                    colour = G.C.BLUE
                }
            else
                card:juice_up(0.2, 0.2)
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.activated then
            G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots_to_add
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.activated then
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots_to_add
        end
    end
}

SMODS.Joker {
    key = 'CHOMIK',
    loc_txt = {
        name = "Chomik",
        text = {
            "This Hampter Gains {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips",
            " per used consumable this run",
            "{C:inactive}(Currently: {C:mult}+#4#{C:inactive} Mult and {C:chips}+#5#{C:inactive} Chips)",
            "{C:inactive}[eaten {C:attention}#3#{C:inactive} consumables]{}"
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla10',
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            mult_gain = 3,
            chip_gain = 25,
            consumed = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_gain,
                card.ability.extra.chip_gain,
                card.ability.extra.consumed,
                card.ability.extra.mult_gain * card.ability.extra.consumed,
                card.ability.extra.chip_gain * card.ability.extra.consumed
            }
        }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            card.ability.extra.consumed = card.ability.extra.consumed + 1

            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.5, 0.5)
                    return true
                end
            }))

            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } } ..
                    " " ..
                    localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chip_gain } },
                colour = G.C.MULT
            }
        end

        if context.joker_main and card.ability.extra.consumed > 0 then
            return {
                mult = card.ability.extra.mult_gain * card.ability.extra.consumed,
                chips = card.ability.extra.chip_gain * card.ability.extra.consumed
            }
        end
    end
}

SMODS.Atlas {
    key = " s",
    path = "tennas.png",
    px = 64,
    py = 64,
}

SMODS.Joker {
    key = "tenna",
    display_size = { w = 64, h = 64 },
    pos = { x = 0, y = 0 },
    frames = 93,
    frame_delay = 0.01,
    atlas = "tennas",
    cost = 5,
    loc_txt = {
        name = "{f:tngt_DETERMINATION}Mr. (Ant) Tenna{}",
        text = {
					"{X:mult,C:white,f:tngt_DETERMINATION}X#1#{} {f:tngt_DETERMINATION}Mult for each time",
					"{f:tngt_DETERMINATION}the words {C:attention}{f:tngt_DETERMINATION}\"I LOVE TV\"{}",
					"{f:tngt_DETERMINATION}have been said in the {C:attention,f:tngt_DETERMINATION}Balatro Discord Server{}",
					"{C:inactive,f:tngt_DETERMINATION}(Currently {X:mult,C:white,f:tngt_DETERMINATION}X#2#{C:inactive,f:tngt_DETERMINATION} Mult)",
					"{C:blue,s:0.7,f:tngt_DETERMINATION}https://discord.gg/balatro{}",
        }
    },
    config = {
		extra = {
			ILOVETV = 27,
			tenna_mult = 1 
		}
	},
    loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.tenna_mult, card.ability.extra.ILOVETV * card.ability.extra.tenna_mult } 
		}
	end,
    rarity = 3,
    cost = 6,
    unlocked = true,
    discovered = true,
    set_ability = function(self, card, initial, delay_sprites)
        add_animated_sprite(card)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
				return {
					x_mult = card.ability.extra.ILOVETV * card.ability.extra.tenna_mult
				}
			end
    end
}

local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.current_round.castle2_card = { suit = 'Spades' }
    return ret
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_card_picker_selection()
end
