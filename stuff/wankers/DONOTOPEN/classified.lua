SMODS.Joker {
    key = 'nxkoo',
    loc_txt = {
        name = 'Nxkoo'
    },
    rarity = "tngt_fourwall",
    atlas = 'DEVS',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            lines_mult = 0.1,
            lines_count = 8528,
            joker_chips = 5,
            joker_count = 105
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.lines_mult,
                card.ability.extra.lines_count,
                card.ability.extra.lines_mult * card.ability.extra.lines_count,
                card.ability.extra.joker_chips,
                card.ability.extra.joker_count,
                card.ability.extra.joker_chips * card.ability.extra.joker_count
            }
        }
    end,
    set_badges = function(self, card, badges)
        badges[#badges + 1] = create_badge('DEAD', G.C.RED, G.C.BLACK, 1.2)
    end,
    in_pool = function(self, args)
        return false
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.lines_mult * card.ability.extra.lines_count,
                xchips = card.ability.extra.joker_chips * card.ability.extra.joker_count
            }
        end
    end
}

SMODS.Joker {
    key = 'ssecun',
    loc_txt = {
        name = 'ssecun'
    },
    rarity = "tngt_fourwall",
    atlas = 'DEVS',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            ideas_mult = 1.5,
            ideas_count = 6,
            credits_chips = 2,
            credits_count = 14
        }
    },
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.ideas_mult,
                card.ability.extra.ideas_count,
                card.ability.extra.ideas_mult * card.ability.extra.ideas_count,
                card.ability.extra.credits_chips,
                card.ability.extra.credits_count,
                card.ability.extra.credits_chips * card.ability.extra.credits_count
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.ideas_mult * card.ability.extra.ideas_count,
                xchips = card.ability.extra.credits_chips * card.ability.extra.credits_count
            }
        end
    end
}

SMODS.Joker {
    key = 'incognito',
    loc_txt = {
        name = 'Incognito'
    },
    rarity = "tngt_fourwall",
    atlas = 'DEVS',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            ideas_mult = 1.5,
            ideas_count = 6,
            credits_chips = 2,
            credits_count = 14
        }
    },
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.ideas_mult,
                card.ability.extra.ideas_count,
                card.ability.extra.ideas_mult * card.ability.extra.ideas_count,
                card.ability.extra.credits_chips,
                card.ability.extra.credits_count,
                card.ability.extra.credits_chips * card.ability.extra.credits_count
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.ideas_mult * card.ability.extra.ideas_count,
                xchips = card.ability.extra.credits_chips * card.ability.extra.credits_count
            }
        end
    end
}

SMODS.Joker {
    key = 'crazydave',
    loc_txt = {
        name = 'crazy_dave_aka_crazy_dave'
    },
    rarity = "tngt_fourwall",
    atlas = 'DEVS',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            ideas_mult = 1.5,
            ideas_count = 6,
            credits_chips = 2,
            credits_count = 14
        }
    },
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.ideas_mult,
                card.ability.extra.ideas_count,
                card.ability.extra.ideas_mult * card.ability.extra.ideas_count,
                card.ability.extra.credits_chips,
                card.ability.extra.credits_count,
                card.ability.extra.credits_chips * card.ability.extra.credits_count
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.ideas_mult * card.ability.extra.ideas_count,
                xchips = card.ability.extra.credits_chips * card.ability.extra.credits_count
            }
        end
    end
}

SMODS.Joker {
    key = 'you',
    loc_txt = {
        name = '{f:tngt_DETERMINATION}You{}',
        text = {
            "{f:tngt_DETERMINATION,}* Despite everything, it's still you.{}"
        }
    },
    config = { extra = {} },
    rarity = "tngt_fourwall",
    atlas = 'ModdedVanilla3',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
    in_pool = function(self, args)
        return false
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
    end
}
