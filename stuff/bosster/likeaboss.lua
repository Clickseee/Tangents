SMODS.Booster {
    key = "fridge",
    loc_txt = {
        name = "Fridge",
        text = {
            "Will contain something else",
            "If this pack is opened",
            "at {C:attention}2 AM{}"
        }
    },
    config = { extra = 5, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("ff98e2")} } }
    end,
    cost = 4,
    atlas = "boosters",
    weight = 0.75,
    pos = { x = 2, y = 0 },
    kind = "Food",
    group_key = "tngt_booster_fridge",
    create_card = function(self, card, i)
        local current_time = os.date("*t")
        local is_special_time = (current_time.hour == 2)
        if is_special_time then
            return SMODS.create_card({
                set = "Beans",
                skip_materialize = true, 
                area = G.pack_cards
            })
        else
            return SMODS.create_card({
                set = "Food", 
                skip_materialize = true, 
                area = G.pack_cards
            })
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("FFFFFF"))
        ease_background_colour({ new_colour = HEX('FFFFFF'), special_colour = HEX("757575"), contrast = 2 })
    end
}