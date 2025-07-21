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
                            { string = ' Upd ati nng..',                         colour = G.C.JOKER_GREY },
                            { string = ' Missi ng..',                            colour = G.C.JOKER_GREY },
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

-- HUGE shoutout to Somethingcom525 for helping me code this
local oldsetcost = Card.set_cost
function Card:set_cost()
    local g = oldsetcost(self)
    if next(SMODS.find_card("j_tngt_dealmaker")) then self.cost = pseudorandom('dealmaker_cost_' .. self.sort_id, 0.001,
            100) end
    return g
end

local cost_dt = 0
local oldgameupdate = Game.update
function Game:update(dt)
    local g = oldgameupdate(self, dt)
    if G.shop and G.jokers and next(SMODS.find_card("j_tngt_dealmaker")) then
        cost_dt = cost_dt + dt
        if cost_dt > 0.2 then
            cost_dt = cost_dt - 0.2
            for i, v in ipairs({ G.shop_jokers, G.shop_vouchers, G.shop_booster }) do
                for ii, vv in ipairs(v.cards) do
                    vv:set_cost()
                end
            end
        end
    end
    return g
end

SMODS.Joker {
    key = 'dealmaker',
    loc_txt = {
        name = '{f:tngt_DETERMINATION}DealMaker',
        text = {
            "Free {X:gold,C:white,f:tngt_DETERMINATION,s:1.5}[[KROMER]]{} for every played {C:attention}Face{} cards",
            "{C:inactive}({C:attention}Shop's{} {C:money}pricing{} {C:inactive}will be {C:dark_edition}unstable{} {C:inactive}by this {C:attention}Joker's appearance{}{C:inactive})",
            "{C:inactive,s:0.7}WHAT THE [[FIFTY DOLLARS SPECIAL.]]{}"
        }
    },
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "artist", set = "Other" }
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
            return {
                message = "DEALS SO GOOD I'LL [$!$$] MYSELF",
                sound = "tngt_dealsogood",
                colour = G.C.YELLOW
            }
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
    blueprint_compat = false,
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
                card.ability.extra.reward_dollars
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
            if SMODS.pseudorandom_probability(card, 'meth', 1, card.ability.extra.odds) then
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
    if G.nxkoo_dies.show_mustard then
        G.nxkoo_dies.mustard_timer = G.nxkoo_dies.mustard_timer - dt
        if G.nxkoo_dies.mustard_timer <= 0 then
            G.nxkoo_dies.show_mustard = false
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()

    function load_image(fn)
        local full_path = (G.nxkoo_dies.path .. "assets/customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempimagedata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempimagedata)))
    end

    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080

    if G.nxkoo_dies.show_mustard then
        if not G.nxkoo_dies.mustard_png then
            G.nxkoo_dies.mustard_png = load_image("mustard.png")
        end
        local alpha = math.min(1, G.nxkoo_dies.mustard_timer * 2)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(G.nxkoo_dies.mustard_png, 0, 0, 0, _xscale, _yscale)
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
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'mustard', 1, card.ability.extra.chance) then
                local multard = card.ability.extra.xmult +
                    pseudorandom('mustard') % card.ability.extra.variance

                if not G.nxkoo_dies.mustard_png then
                    G.nxkoo_dies.mustard_png = load_image("mustard.png")
                end
                G.nxkoo_dies.show_mustard = true
                G.nxkoo_dies.mustard_timer = 0.5

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
            if to_big(hand_chips) > to_big(mult) then
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
            xchips = 3,
            clubs_required = 4
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
                card_eval_status = (club_batches > 1) and 'active' or nil
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
    config = { extra = { repetitions = 1, chance = 6 } },
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
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'twintowers', 1, card.ability.extra.chance) then
                return {
                    remove = true,
                    message = "THEY HIT THE SECOND TOWER!",
                    play_sound = "tngt_neverforget",
                    colour = G.C.RED
                }
            end
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

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                xchips = card.ability.extra.xchips
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
    if G.nxkoo_dies.show_mustard then
        G.nxkoo_dies.mustard_timer = G.nxkoo_dies.mustard_timer - dt
        if G.nxkoo_dies.mustard_timer <= 0 then
            G.nxkoo_dies.show_mustard = false
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()

    function load_image(fn)
        local full_path = (G.nxkoo_dies.path .. "assets/customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempimagedata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempimagedata)))
    end

    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080

    if G.nxkoo_dies.show_mustard then
        if not G.nxkoo_dies.mustard_png then
            G.nxkoo_dies.mustard_png = load_image("mustard.png")
        end
        local alpha = math.min(1, G.nxkoo_dies.mustard_timer * 2)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(G.nxkoo_dies.mustard_png, 0, 0, 0, _xscale, _yscale)
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

            if not G.nxkoo_dies.mustard_png then
                G.nxkoo_dies.mustard_png = load_image("mustard.png")
            end
            G.nxkoo_dies.show_mustard = true
            G.nxkoo_dies.mustard_timer = 0.5

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

        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                xchips = card.ability.extra.xchips
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
    blueprint_compat = false,
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
                    message = tostring(card.ability.extra.slots_to_add),
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
    key = 'kanye',
    loc_txt = {
        name = 'Kanye Gaming',
        text = {
            "This Kanye gains {X:green,C:white}+1!{} Mult for",
            "each time he's {C:attention}gotten{} into a {C:red}controversy{}",
            "{C:inactive}(Currently {X:green,C:white}6!{} {C:inactive}Mult)",
            "{C:inactive,s:2}(there's no factorial mult context for this game, so have a +Mult)"
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
                mult = 7.2
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


local click_ref = Card.click
function Card:click()
    local ret = click_ref(self)
    if G.jokers then
        SMODS.calculate_context { clicked_card = self }
    end
end

SMODS.Joker {
    key = "danger",
    loc_txt = {
        name = "I am {X:mult,C:white}NOT{} in {C:red}danger{}, Jimbo",
        text = {
            "Knocking on this door will gain you {C:red}+25{} Mult.",
            "{C:inactive}(Only knock {C:attention}once{} {C:inactive}per {C:attention}Ante{}{C:inactive}, he's {C:red}busy{}{C:inactive}){}",
            "{C:inactive}(Currently {C:red}#2# Knocks{}{C:inactive}, you are the one who knocks.)"
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
                message = total_mult > 0 and
                    ("Knocks: " .. card.ability.extra.knock_count .. " (+" .. total_mult .. " Mult)") or
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
                { n = G.UIT.T, config = { text = " | Current Mult: +" .. (card.ability.extra.knock_count or 0) * (card.ability.extra.mult_per_knock or 25), scale = 0.35, colour = G.C.MULT } }
            }
        }
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
    blueprint_compat = false,
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
            if SMODS.pseudorandom_probability(card, 'fuck', 1, card.ability.extra.quit_chance) then
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
    config = { extra = { multiplier = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.multiplier } }
    end,

    calculate = function(self, card, context)
        if (context.buying_card or context.open_booster) and card.ability.active then
            card.ability.active = false
            return {
                message = localize("k_disabled_ex"),
                colour = G.C.RED
            }
        end
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            card.ability.active = true
            return {
                message = localize("k_reset")
            }
        end
        if context.ending_shop and card.ability.active and not context.blueprint then
            local current_dollars = G.GAME.dollars
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + current_dollars * (card.ability.extra.multiplier - 1)
            return {
                dollars = current_dollars * (card.ability.extra.multiplier - 1),

                message = "LOCK THE FUCK IN!",
                colour = G.C.MONEY,
                message_card = card,
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
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.active = true
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
            hands_needed = math.random(2, 3)
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
    key = "gdamn",
    loc_txt = {
        name = "{C:red}DAMN..",
        text = {
            "{C:red}+#1#{} Mult,",
            "{C:green}1{} in {C:green}#3#{} chance for someone to laugh at this Joker",
            "and gives {X:mult,C:white}X#2#{} Mult for scoring."
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla11',
    pos = { x = 2, y = 1 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            base_mult = 10,
            temp_joker_xmult = 2.5,
            chance = 2,
            last_trigger_hand = -1,
            temp_joker_key = "j_tngt_gdaniel"
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base_mult,
                card.ability.extra.temp_joker_xmult,
                card.ability.extra.chance,
                localize { type = 'name_text', key = card.ability.extra.temp_joker_key, set = 'Joker' }
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                sound = "tngt_damndaniel",
                message = "DAMN DANIEL.",
                mult = card.ability.extra.base_mult
            }
        end

        if context.before and not context.blueprint then
            local daniel_exists = false
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.key == card.ability.extra.temp_joker_key and j.ability.temporary then
                    daniel_exists = true
                    break
                end
            end

            if not daniel_exists and SMODS.pseudorandom_probability(card, 'mustard', 1, card.ability.extra.chance) then
                if G.GAME.hands_played ~= card.ability.extra.last_trigger_hand then
                    G.GAME.joker_buffer = (G.GAME.joker_buffer or 0) + 1
                    return {
                        message = localize('k_active_ex'),
                        colour = G.C.MULT,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.add_card({
                                        key = card.ability.extra.temp_joker_key,
                                        set = 'Joker',
                                        temporary = true,
                                        from_gdamn = true
                                    })
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                    }
                end
            end
        end
    end
}

SMODS.Joker {
    key = 'gdaniel',
    loc_txt = {
        name = "DANIEL",
        text = {
            "He's here for Daniel."
        }
    },
    rarity = 2,
    cost = 4,
    discovered = true,
    unlocked = true,
    blueprint_compat = false,
    perishable_compat = true,
    atlas = 'ModdedVanilla11',
    pos = { x = 3, y = 1 },
    config = { extra = { xmult = 2.5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                sound = "tngt_ararararar",
                message = "ER ER ER ER ER ER ER.",
                xmult = card.ability.extra.xmult
            }
        end

        if context.after then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound(tngt_neverforget, 1, 1)
                    card:start_dissolve()
                    return true
                end
            }))
            return {
                message = "damn",
                colour = G.C.RED
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}


SMODS.Joker {
    key = 'apple',
    loc_txt = {
        name = "An {C:red}Apple{} keeps the {C:attention}Boss Blinds{} away!",
        text = {
            "If you have any {C:attention}Food Jokers{},",
            "{C:green}1{} in {C:green}#1#{} chance to scare every {C:attention}Boss Blinds{} away"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla11',
    pos = { x = 2, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { chance = 4 } },
    loc_vars = function(self, info_queue, card)
        local food_jokers = 0
        if G.jokers then
            for _, j in ipairs(G.jokers.cards) do
                if (j.config.center.pools or {}).Food then
                    food_jokers = food_jokers + 1
                end
            end
        end

        return {
            vars = { card.ability.extra.chance, food_jokers },
            colours = { food_jokers > 0 and G.C.FILTER or G.C.UI.TEXT_LIGHT }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss then
            local has_food_jokers = false
            if G.jokers then
                for _, j in ipairs(G.jokers.cards) do
                    if j ~= card and (j.config.center.pools or {}).Food then
                        has_food_jokers = true
                        break
                    end
                end
            end

            if has_food_jokers and SMODS.pseudorandom_probability(card, 'mustard', 1, card.ability.extra.chance) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            blocking = false,
                            func     = function()
                                if G.STATE == G.STATES.SELECTING_HAND then
                                    G.GAME.chips     = G.GAME.blind.chips
                                    G.STATE          = G.STATES.HAND_PLAYED
                                    G.STATE_COMPLETE = true
                                    end_round()
                                    return true
                                end
                            end
                        }))
                        SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                        return true
                    end
                }))
                return nil, true -- For Joker retrigger purposes
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
            local has_food_jokers = false
            if G.jokers then
                for _, j in ipairs(G.jokers.cards) do
                    if j ~= card and (j.config.center.pools or {}).Food then
                        has_food_jokers = true
                        break
                    end
                end
            end

            if has_food_jokers and SMODS.pseudorandom_probability(card, 'mustard_init', 1, card.ability.extra.chance) then
                G.GAME.blind:disable()
                play_sound('tngt_neverforget')
                SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
            end
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
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
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
    key = "spaghet",
    loc_txt = {
        name = "SOMEBODY TOUCHA MY {C:attention}SPAGHET",
        text = {
            "{C:attention}Food Jokers{} now have",
            "{X:green,C:white}X2{} denominators, with",
            "{C:green}1{} in {C:green}#1#{} chance to {C:red}halve{} them",
            "{C:inactive}(Affects probability odds){}"
        }
    },
    rarity = 2,
    atlas = 'ModdedVanilla11',
    pos = { x = 1, y = 1 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chance = 4 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chance }
        }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and context.trigger_obj and
            (context.trigger_obj.config.center.pools or {}).Food then
            local negative_effect = SMODS.pseudorandom_probability(card, 'food_critic', 1, card.ability.extra.chance)

            if negative_effect then
                return {
                    message = "SOMEBODY TOUCHA MY SPAGHET",
                    colour = G.C.RED,
                    denominator = math.max(1, math.floor(context.denominator / 2))
                }
            else
                return {
                    message = "Spaghet untouched.",
                    colour = G.C.GREEN,
                    denominator = context.denominator * 2
                }
            end
        end
    end
}


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
    config = { extra = { chance = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { "High Card", "50%" } }
    end,
    calculate = function(self, card, context)
        if context.repetition then
            if context.scoring_name ~= "High Card" then
                print(context.scoring_name)
                return
            end
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
                    message = tostring(retriggers),
                    card = card
                }
            end
        end
        if context.after and context.joker_main then
            if SMODS.pseudorandom_probability(card, 'mustard', 1, card.ability.extra.chance) then
                G.E_MANAGER:add_event(Event({
                    blocking = false,
                    func     = function()
                        if G.STATE == G.STATES.SELECTING_HAND then
                            G.GAME.chips     = G.GAME.blind.chips
                            G.STATE          = G.STATES.HAND_PLAYED
                            G.STATE_COMPLETE = true
                            play_sound(tngt_neverforget)
                            end_round()
                            return true
                        end
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
        local current_mult = math.floor((G.GAME.dollars or 0) / 2) + card.ability.extra.mult_per_2_dollars
        return { vars = { card.ability.extra.mult_per_2_dollars, current_mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local dollars = G.GAME.dollars or 0
            local multiplier = math.floor(dollars / 4) * card.ability.extra.mult_per_2_dollars

            G.nxkoo_dies.damnbird_png = load_image("damnbird.png")

            G.nxkoo_dies.show_image = true
            G.nxkoo_dies.image_timer = 0.5

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
                message = "I NEED A MEDIC BAG"
            }
        end
    end
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
        return { vars = { localize { type = "name_text", set = "Planet", key = card.ability.extra.desired_planet } } }
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
                new_planet = pseudorandom_element(planet_keys, pseudoseed('andhewaddleaway' .. G.GAME.round_resets.ante))
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
