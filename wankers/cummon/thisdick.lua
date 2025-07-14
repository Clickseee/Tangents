
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
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
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
            "{C:red}+#1#{} Mult for each {C:attention}Joker{} in this run."
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
            "{C:red}+#1#{} Mult, {C:green}otherwise{} {X:mult,C:white}X#3#{} Mult."
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
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.xmult}},
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