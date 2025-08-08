SMODS.Consumable {
    key = "susiesidea",
    set = "Tarot",
    atlas = "CUM",
    pos = { x = 0, y = 0 },
    cost = 5,
    loc_txt = {
        name = "#",
        text = {
            "{tngt_S:soul,s:2} {}{tngt_S:susie,s:2} {}{f:tngt_DETERMINATION}Susie's Idea"
        }
    },
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                end_round()
                play_sound('tngt_neverforget', 1.1)
                used_tarot:juice_up(0.3, 0.5)
                return true
            end
        }))
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