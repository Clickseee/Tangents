SMODS.Joker {
    key = "whysoserious",
    loc_txt = {
        name = "Jonkler",
        text = {
            "{X:green,C:white}4!{} Mult"
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla15',
    pos = { x = 1, y = 1 },
    cost = math.huge,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
        return {
          Xmult_mod = mult ^ 24,
          message = "4! Mult",
          sound = "tngt_neverforget",
          colour = G.C.GREEN
        }
    end
end
}

SMODS.Joker {
    key = 'watericesalt',
    loc_txt = {
        name = 'A waterballoon?',
        text = {
            "This kid will give you {X:mult,C:white}X1e308{} Mult, {X:blue,C:white}X1e308{} Chips",
            "{C:gold}$1e308{}, and Infinite {C:blue}Hands{}",
            "{C:inactive}(Only works if you hit the Game Over screen.)"
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
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
local ranks = {}
for k, v in pairs(G.playing_cards) do
    ranks[v:get_id()] = (ranks[v:get_id()] or 0) + v.base.times_played
end
table.sort(ranks, function(a, b) return a > b end)
local mostplayed = ranks[1]

SMODS.Joker {
    key = 'hoodirony',
    loc_txt = {
        name = 'Hood irony {f:tngt_emoji}😂🚶‍➡️',
        text = {
            'Gains {X:mult,C:white}X0.8{} Mult',
            'per consecutive hand containing your',
            'most played rank(s): {C:attention}#3#{}',
            '{s:0.8}Resets when none are played',
            '{C:inactive}(Current: {X:mult,C:white}X#1#{} {C:inactive}Mult)'
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    rarity = 1,
    atlas = 'ModdedVanilla11',
    pos = { x = 0, y = 0 },
    cost = 1,
    config = {
        extra = {
            xmult = 1,
            streak = 0,
            current_rank = nil
        }
    },
    loc_vars = function(self, info_queue, card)
        -- Get most played ranks
        local ranks = {}
        for k, v in pairs(G.playing_cards) do
            if not SMODS.has_no_rank(v) then
                local id = v:get_id()
                ranks[id] = (ranks[id] or 0) + (v.base.times_played or 0)
            end
        end

        -- Convert to sortable table
        local sortable = {}
        for id, count in pairs(ranks) do
            table.insert(sortable, {id = id, count = count})
        end
        table.sort(sortable, function(a, b) return a.count > b.count end)

        -- Display current tracking info
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.streak,
                card.ability.extra.current_rank and localize(G.P_RANKS[card.ability.extra.current_rank], 'ranks') or "None"
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            -- Get most played ranks at start of round
            local ranks = {}
            for k, v in pairs(G.playing_cards) do
                if not SMODS.has_no_rank(v) then
                    local id = v:get_id()
                    ranks[id] = (ranks[id] or 0) + (v.base.times_played or 0)
                end
            end

            -- Convert to sortable table
            local sortable = {}
            for id, count in pairs(ranks) do
                table.insert(sortable, {id = id, count = count})
            end
            table.sort(sortable, function(a, b) return a.count > b.count end)

            -- Check if current hand contains any of the most played ranks
            local contains_rank = false
            if #sortable > 0 then
                local most_played_rank = sortable[1].id
                card.ability.extra.current_rank = most_played_rank

                if context.full_hand then
                    for _, c in ipairs(context.full_hand) do
                        if not SMODS.has_no_rank(c) and c:get_id() == most_played_rank then
                            contains_rank = true
                            break
                        end
                    end
                end

                if contains_rank then
                    card.ability.extra.streak = card.ability.extra.streak + 1
                    card.ability.extra.xmult = card.ability.extra.xmult + 1
                    return {
                        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.xmult}},
                        colour = G.C.MULT
                    }
                else
                    card.ability.extra.streak = 0
                    return {
                        message = localize('k_reset'),
                        colour = G.C.RED
                    }
                end
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
]]

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
    config = { extra = { mult = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and not context.repetition and
            not context.end_of_round and context.cardarea == G.play then
            local sound = "tngt_pingas"
            return {
                focus = context.other_card,
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                sound = sound,
                colour = G.C.RED
            }
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
        if context.end_of_round and context.main_eval and not context.blueprint then
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
    key = 'fish',
    loc_txt = {
        name = 'You know what that mean? :D',
        text = {
            "{C:attention}Played{} cards gives {C:blue}+#1#{} Chips",
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
            blind_dollars = 5
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
                card = card
            }
        end
    end
}

SMODS.Joker {
    key = 'melvin',
    loc_txt = {
        name = "Melvin {C:red}Mult{}",
        text = {
            "{C:red}+#1#{} Mult for each {C:attention}Joker{} card"
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla6',
    pos = { x = 2, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = { mult = 15 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult * (G.jokers and #G.jokers.cards or 0) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult * #G.jokers.cards
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
    soul_pos = {
        x = 3,
        y = 1,

        set_sprites = function(self, card, front)
            if self.discovered or card.bypass_discovery_center then
                card.children.floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h,
                    G.ASSET_ATLAS[card.config.center.atlas], {
                        x = 3,
                        y = 1
                    })
                card.children.floating_sprite.role.draw_major = card
                card.children.floating_sprite.states.hover.can = false
                card.children.floating_sprite.states.click.can = false
            end
        end,

        draw = function(card, scale_mod, rotate_mod)
            --if not (card.hovered and card.states.hover) or not card.children.floating_sprite then
            if card.children.floating_sprite then
                card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center,
                    0.2, 0, nil, 0, nil, 0.6)
            end
            --return
            --end
            local anim_timer = ((G.TIMERS.REAL / 90) % 1)
            local growth_phase = anim_timer < 0.9
            local scale_ease = growth_phase and
                (anim_timer < 0.5 and 2 * (anim_timer / 0.9) ^ 2 or 1 - 2 * (1 - (anim_timer / 0.9)) ^ 2) or
                0
            local min_scale = 0.1
            local max_scale = 1.5
            local current_scale = min_scale + (max_scale - min_scale) * scale_ease
            local rotation = current_scale * 0.15 * math.sin(anim_timer * 2 * math.pi)
            local y_offset = -0.2 * current_scale
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center,
                current_scale, rotation, nil, y_offset, nil, 0.6)
        end
    },
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
    key = 'markimoo',
    loc_txt = {
        name = "Hello {C:attention}everybody{}, my name is {X:mult,C:white}Mult{}{C:red}iplier.{}",
        text = {
            "{C:red}+#1#{} Mult, {C:green}otherwise{} {X:mult,C:white}X#2#{} Mult."
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
            xmult_chance = 6,
            huge_xmult = 87
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_chance, card.ability.extra.huge_xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'mustard', 1, card.ability.extra.xmult_chance) then
                play_sound('tngt_neverforget', 1.2, 0.4)
                card:juice_up(1.2, 0.8)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    blockable = false,
                    func = function()
                        card:juice_up(0.8, 0.8)
                        return true
                    end
                }))

                return {
                    xmult = card.ability.extra.huge_xmult,
                    card_eval_status = 'jokers'
                }
            else
                return {
                    mult = card.ability.extra.base_mult,
                    card_eval_status = 'jokers'
                }
            end
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
    config = { extra = { xmult_gain = 0.8 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult or 1 },
            colours = { G.C.RED, G.C.MULT }
        }
    end,
    calculate = function(self, card, context)
        card.ability.extra.xmult = card.ability.extra.xmult or 1
        if context.cardarea == G.play and context.individual and not context.blueprint then
            local card_id = context.other_card:get_id()
            if card_id >= 2 and card_id <= 5 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    colour = G.C.MULT
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
                card.ability.extra.mult_gain *
                (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0),
                card.ability.extra.chip_gain *
                (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0)
            }
        }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
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

        if context.joker_main and (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0) > 0 then
            return {
                mult = card.ability.extra.mult_gain *
                    (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0),
                chips = card.ability.extra.chip_gain *
                    (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0)
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
    key = 'barcode',
    loc_txt = {
        name = "[||||  ||| || | | | |||]",
        text = {
            "If played hand contains an {C:attention}Ace{} or a {C:attention}10{},",
            "gives either {C:red}+10{} or {C:red}+11{} Mult."
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla12',
    pos = { x = 4, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = {
        base_mult = 10,
        bonus_mult = 11,
        ace_id = 14,
        ten_id = 10
    } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base_mult,
                card.ability.extra.bonus_mult
            },
            colours = { G.C.MULT, G.C.MULT, G.C.FILTER, G.C.FILTER }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_ace = false
            local has_ten = false

            for _, playing_card in ipairs(context.scoring_hand) do
                local card_id = playing_card:get_id()
                if card_id == card.ability.extra.ace_id then
                    has_ace = true
                elseif card_id == card.ability.extra.ten_id then
                    has_ten = true
                end

                if has_ace and has_ten then break end
            end

            if has_ace or has_ten then
                local mult = pseudorandom('ace_ten_joker_' .. G.GAME.round_resets.ante) > 0.5 and
                    card.ability.extra.bonus_mult or card.ability.extra.base_mult

                return {
                    mult = mult,
                    card = card,
                    extra = (mult == card.ability.extra.bonus_mult) and {
                        message = localize { type = 'variable', key = 'a_mult', vars = { mult } },
                        colour = G.C.MULT,
                        sound = 'chips1',
                        delay = 0.4
                    } or nil
                }
            end
        end
    end,
}

SMODS.Joker {
    key = 'eggman',
    loc_txt = {
        name = "I've come to make an announcement",
        text = {
            "I've come to make an announcement {f:tngt_emoji,C:gold}📣{f:tngt_emoji}",
            "Shadow the Hedgehog is a bitch ass motherfucker {f:tngt_emoji,C:blue}🦔{f:tngt_emoji}",
            "he pissed on my fucking wife {f:tngt_emoji,C:blue}💦{f:tngt_emoji}",
            "he took his hedgehog fucking quill-y dick out {f:tngt_emoji,C:purple}🍆{f:tngt_emoji}",
            "and he pissed on my fucking wife {f:tngt_emoji,C:blue}💧{f:tngt_emoji}",
            "and he said his dick was THIS BIG {f:tngt_emoji}📏{f:tngt_emoji}",
            "and I said 'That's disgusting.' {f:tngt_emoji,C:green}🤢{f:tngt_emoji}",
            "so I'm making a call-out post on my Twitter dot com {f:tngt_emoji,C:blue}🐦{f:tngt_emoji}",
            "Shadow the Hedgehog you got a small dick {f:tngt_emoji}🥜{f:tngt_emoji}",
            "it's the size of this walnut except way smaller {f:tngt_emoji}🌰{f:tngt_emoji}",
            "and guess what? Here's what my dong looks like {f:tngt_emoji,C:yellow}😎{f:tngt_emoji}",
            "That's right baby, all points, no quills, no pillows {f:tngt_emoji}🛏️{f:tngt_emoji}",
            "look at that it looks like two balls and a bong! {f:tngt_emoji,C:purple}🔮{f:tngt_emoji}",
            "He fucked my wife {f:tngt_emoji,C:hearts}💔{f:tngt_emoji}",
            "so guess what? I'm gonna fuck the Earth! {f:tngt_emoji,C:green}🌍{f:tngt_emoji}",
            "That's right, this is what you get! {f:tngt_emoji,C:yellow}⚠️{f:tngt_emoji}",
            "My super laser piss! {f:tngt_emoji,C:red}🔫{f:tngt_emoji}",
            "Except I'm not gonna piss on the Earth {f:tngt_emoji,C:green}🌎{f:tngt_emoji}",
            "I'm gonna go higher {f:tngt_emoji}🚀{f:tngt_emoji}",
            "I'm pissing on THE MOON! {f:tngt_emoji,C:yellow}🌕{f:tngt_emoji}",
            "How do you like that Obama? {f:tngt_emoji,C:blue}🇺🇸{f:tngt_emoji}",
            "I PISSED ON THE MOON YOU IDIOT! {f:tngt_emoji,C:yellow}🌝{f:tngt_emoji}",
            "You have 23 hours until the piss droplets hit the fucking Earth {f:tngt_emoji,C:yellow}⏳{f:tngt_emoji}",
            "now get out of my fucking sight before I piss on you too {f:tngt_emoji,C:yellow}👊{f:tngt_emoji}"
        }

    },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    rarity = 1,
    atlas = 'ModdedVanilla16',
    pos = { x = 0, y = 0 },
    cost = 4,
    config = { extra = { price = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}

--[[
SMODS.Joker {
    key = 'spongemanicecone',
    loc_txt = {
        text = {
            "This fucker gains",
            "{C:chips}+#1#{} Chips if adjacent",
            "{C:attention}Joker{} doesn't {C:attention}trigger{}",
            "{C:inactive}(Currently {C:chips}+#2#{}{C:inactive} Chips)"
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla15',
    pos = { x = 5, y = 0 },
    config = { extra = { base_chips = 25, total_chips = 0 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base_chips,
                card.ability.extra.total_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos then
                local adjacent_triggered = false
                local adjacent_indices = {my_pos - 1, my_pos + 1}
                for _, adj_pos in ipairs(adjacent_indices) do
                    if adj_pos >= 1 and adj_pos <= #G.jokers.cards then
                        local adj_joker = G.jokers.cards[adj_pos]
                        if adj_joker and adj_joker ~= card and context.other_joker_effects then
                            for _, effect in ipairs(context.other_joker_effects) do
                                if effect.card == adj_joker then
                                    adjacent_triggered = true
                                    break
                                end
                            end
                        end
                        if adjacent_triggered then break end
                    end
                end
                if not adjacent_triggered and not context.blueprint then
                    local previous_total = card.ability.extra.total_chips
                    card.ability.extra.total_chips = card.ability.extra.total_chips + card.ability.extra.base_chips
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up(0.5, 0.5)
                            return true
                        end
                    }))
                    
                    return {
                        chips = card.ability.extra.total_chips,
                        colour = G.C.CHIPS
                    }
                else
                    return {
                        chips = card.ability.extra.total_chips
                    }
                end
            end
        end
    end
}
]]

SMODS.Joker {
    key = 'dinnerbone',
    loc_txt = {
        name = "#",
        text = {
            "Dinnerbone"
        }
    },
    rarity = 1,
    atlas = 'ModdedVanilla16',
    pos = { x = 2, y = 1 },
    cost = 3,
    unlocked = true,
    discovered = true,
    config = { extra = { extra_slots_used = -1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.inverted_joker_active = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.inverted_joker_active = nil
        if G.jokers then
            for k, joker_card in ipairs(G.jokers.cards) do
                if joker_card ~= card then
                    joker_card.T.r = 0
                end
            end
        end
    end
}

local cardarea_align_cards_ref = CardArea.align_cards
function CardArea:align_cards()
    cardarea_align_cards_ref(self)
    if self.config.type == 'joker' and G.GAME.inverted_joker_active then
        for k, card in ipairs(self.cards) do
            if not card.states.drag.is and card.config.center.key ~= "inverted" then
                card.T.r = math.pi
            end
        end
    end
end