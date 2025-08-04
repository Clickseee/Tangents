SMODS.Consumable {
    key = "susiesidea",
    set = "Tarot",
    atlas = "CUM",
    pos = { x = 0, y = 0 },
    cost = 5,
    loc_txt = {
        name = "{f:tngt_DETERMINATION}Susie's Idea",
        text = {
            "{tngt_S:j_joker} {}{tngt_I:j_joker} {}{f:tngt_DETERMINATION}Susie's Idea"
        }
    },
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1', 1.1)
                used_tarot:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.cards do
            local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('card1', percent)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = G.hand.cards[i]
                    if pseudorandom('royal_decree_'..i) < 0.5 then
                        assert(SMODS.change_base(_card, nil, "Queen"))
                        card:start_dissolve(nil, true)
                        play_sound('tngt_neverforget', 1.2)
                        return {}
                        end
                    if pseudorandom('royal_decree_'..i) < 0.5 then
                        assert(SMODS.change_base(_card, nil, "King"))
                        _card:set_ability('m_steel')
                        play_sound('tarot1', 1.1, 0.4)
                    end
                    _card.states.visible = true
                    return true
                end
            }))
        end
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end
}

--[[
SMODS.Consumable {
    key = "starwalker",
    set = "Tarot",
    loc_txt = {
        name = "That'll hold em, alwight? hehehehe..",
        text = {
            "Copies ability of last purchased {C:attention}Joker{}"
        }
    },
    config = {
        extra = {
            money = 3,
        }
    },
    atlas = "CUM",
    pos = { x = 1, y = 0 },
    cost = 5,
}

SMODS.Consumable {
    key = "johnpork",
    set = "Spectral",
    config = {
        extra = {
            money = 3,
        }
    },
    atlas = "CUM",
    pos = { x = 0, y = 4 },
    cost = 5,
}

SMODS.Consumable {
    key = "drhouse",
    set = "Spectral",
    config = {
        extra = {
            money = 3,
        }
    },
    atlas = "CUM",
    pos = { x = 1, y = 4 },
    cost = 5,
}
]]