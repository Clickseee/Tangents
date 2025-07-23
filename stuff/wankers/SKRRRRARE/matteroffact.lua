SMODS.Joker {
    key = 'coolerdaniel',
    loc_txt = {
        name = 'Cooler Daniel 2',
        text = {
            "Every played {C:attention}face{} cards gives",
            "{X:mult,C:white}X#1#{} Mult when scored"
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    rarity = 3,
    atlas = 'ModdedVanilla13',
    pos = { x = 3, y = 1 },
    cost = 8,
    config = { extra = { xmult_per_face = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_per_face } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local face_count = 0
            for _, played_card in ipairs(context.scoring_hand) do
                if played_card:is_face() then
                    face_count = face_count + 1
                end
            end
            if face_count > 0 then
                local total_xmult = math.pow(card.ability.extra.xmult_per_face, face_count)
                return {
                    xmult = total_xmult,
                    message = localize{
                        type = 'variable', 
                        key = 'a_xmult_per_face', 
                        vars = {face_count, total_xmult}
                    }
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'jojo',
    loc_txt = {
        name = "{C:gold,E:2,s:2}HOLY SHIT",
        text = {
            "{f:tngt_emoji,C:red}‼️‼️‼️‼️{}HOLY FUCKING SHIT{f:tngt_emoji,C:red}‼️‼️‼️‼️{} IS THAT A MOTHERFUCKING JOJO REFERENCE{f:tngt_emoji,C:red}‼️⁉️‼️⁉️⁉️⁉️‼️{}",
            "{f:tngt_emoji,C:attention}😱😱😱😱😱😱😱😱{} JOJO IS THE BEST FUCKING ANIME{f:tngt_emoji,C:gold}🔥🔥🔥🔥🔥{f:tngt_emoji,C:red}💯💯💯💯💯{}",
            "JOSUKE IS SO BADASSSSS{f:tngt_emoji,C:attention}😎😎😎😎{} ORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORAORA",
            "{f:tngt_emoji,C:attention}🫵🫵🫵🫵{} MUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDAMUDA",
            "{f:tngt_emoji,C:red}🤬🤬😡🤬🤬🤬🤬😡😡😡{} WRYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
            "YO ANGELO {f:tngt_emoji}🗿{} YO ANGELO {f:tngt_emoji}🗿{} YO ANGELO {f:tngt_emoji}🗿{} YO ANGELO {f:tngt_emoji}🗿{} YO ANGELO {f:tngt_emoji}🗿{}",
            "YARE YARE DAZE {f:tngt_emoji,C:attention}🤙🤙🤙🤙🤙{}",
            "NIGERUNDAYOOOOO {f:tngt_emoji,C:attention}🏃🏃{}NIGERUNDAYO{f:tngt_emoji,C:attention}🏃{} NIGERUNDAYOOOOOOOOOOOOOOO{f:tngt_emoji,C:attention}🏃🏃🏃{}NIGERUNDAYOOOOO {f:tngt_emoji,C:attention}🏃🏃{}",
            "DORARARARARARARARARARARA {f:tngt_emoji,C:green}🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢{}",
            "SHIZAAAAA{f:tngt_emoji,C:purple}✝️{C:inactive,f:tngt_emoji}🪨🪨{}SHIZAAAAAAAAAAAA{f:tngt_emoji,C:purple}✝️✝️{C:inactive,f:tngt_emoji}🪨🪨🪨🪨{}",
            "KONO GIORNO GIOVANNA YUME GA ARU{f:tngt_emoji}☀️☀️☀️☀️☀️☀️{}",
            "MADE IN HEAVEN{f:tngt_emoji,C:inactive}💿💿💿🌫️🌫️🌫️{} MADE IN HEAVEN{f:tngt_emoji,C:inactive}💿💿💿🌫️🌫️🌫️{}",
            "BREAKDOWN BREAKDOWN{f:tngt_emoji}🪕🪕🪕{} BREAKDOWN BREAKDOWN{f:tngt_emoji}🪕🪕{}",
            "ZA WARUDO{f:tngt_emoji,C:red}⛔⛔{C:inactive,f:tngt_emoji}🕒🕒{} ZA WARUDO{f:tngt_emoji,C:red}⛔⛔⛔{C:attention,f:tngt_emoji}✋✋✋{}",
            "ARIARIARIARIARIARIARIARI ARRIVEDERCI{f:tngt_emoji,C:attention}😎😎👋👋👋{}",
            "VOLAVOLAVOLAVOLAVOLAVOLAVOLAVOLA VOLARE VIA{f:tngt_emoji}🌫️🌫️🛩️🛩️🛩️{}",
            "MY NAME IS KIRA YOSHIKAGE AND I LIVE IN THE NORTHEAST SECTION OF MORIOH{f:tngt_emoji,C:purple}🌇🌇🌇{}",
            "STAR PLATINUM{f:tngt_emoji,C:attention}⭐🌟😫😫😫🤯🤯{}"
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 3,
    cost = 4,
    unlocked = true,
    discovered = true,
    atlas = 'ModdedVanilla11',
    pos = { x = 5, y = 0 },
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tldf', set = 'Other', vars = { 2.5 } }
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = { card.ability.extra.xmult }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, "m_stone") then
                context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) +
                    card.ability.extra.xmult
                play_sound('multhit2', 1.2)
                card:juice_up(0.5, 0.5)
                return {
                    message = localize('k_upgrade_ex'),
                    card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'autocorrect',
    loc_txt = {
        name = 'Jokerly',
        text = {
            "Replace all sorts of {C:red}+Mult{} outcomes to {X:red,C:white}XMult{}",
            "But, {C:green}corrects{} all of the game's {C:attention}text{} to a {C:dark_edition}better{} one."
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    rarity = 3,
    atlas = 'ModdedVanilla12',
    pos = { x = 0, y = 0 },
    cost = 8,
    config = { {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        return nil
    end
}

local original_generate_card_ui = generate_card_ui
local ref = SMODS.calculate_individual_effect

local autocorrect_map = {
    ["boss"] = "HR",
    ["$"] = "mone",
    ["tags"] = "hashtags",
    ["value"] = "lore",
    ["sell"] = "YEET",
    ["random"] = "RNGesus",
    ["selected"] = "picked",
    ["blind"] = "blnd",
    ["booster"] = "lootbox",
    ["pack"] = "box",
    ["destroy"] = "DELETE",
    ["joker"] = "jokr",
    ["mult"] = "multplr",
    ["chips"] = "chps",
    ["X"] = "XxX",
    ["create"] = "mk",
    ["played"] = "used",
    ["to"] = "2",
    ["up"] = "^",
    ["go"] = "->",
    ["hands"] = "hnds",
    ["gives"] = "gibs",
    ["one"] = "1"
}

function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local tab = original_generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    if G.jokers and next(SMODS.find_card("j_tngt_autocorrect")) then
        for i, t in ipairs(tab.main) do
            for j, k in ipairs(tab.main[i]) do
                if k.config and k.config.text then
                    local original_text = k.config.text
                    local changed = false
                    local text = original_text
                    for word, replacement in pairs(autocorrect_map) do
                        local new_text, count = text:gsub("%f[%a]"..word.."%f[%A]", replacement)
                        if count > 0 then
                            text = new_text
                            changed = true
                        end
                        new_text, count = text:gsub("%f[%a]"..word:sub(1,1):upper()..word:sub(2).."%f[%A]", 
                                      replacement:sub(1,1):upper()..replacement:sub(2))
                        if count > 0 then
                            text = new_text
                            changed = true
                        end
                    end
                    if changed then
                        k.config.text = text
                        k.config.colour = G.C.GREEN 
                        k.config.original_colour = k.config.colour 
                    end
                end
            end
        end
    end
    
    return tab
end

function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
  if G.jokers and next(SMODS.find_card("j_tngt_autocorrect")) and (key == "mult" or key == "mult_mod" or key == "h_mult") then
    if key == "mult_mod" then effect.message = nil end
    return ref(effect, scored_card, "xmult", amount, from_edition) --Changing key to xmult. If you want to change how much xmult it should give, change amount, I assume.
  else
    return ref(effect, scored_card, key, amount, from_edition)
  end
end

SMODS.Joker {
    key = 'SCP',
    loc_txt = {
        name = '[REDACTED]',
        text = {
            "Replace all sorts of {C:blue}+Chips{} outcomes to {X:blue,C:white}XChips{}",
            "But, {C:dark_edition}classify{} all of the game's {C:attention}text{}."
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    rarity = 3,
    atlas = 'ModdedVanilla12',
    pos = { x = 2, y = 1 },
    cost = 8,
    config = { {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        return nil
    end
}

local original_generate_card_ui = generate_card_ui
local ref = SMODS.calculate_individual_effect

local hashtag_map = {
    ["boss"] = "[REDACTED]",
    ["$"] = "[REDACTED]",
    ["tags"] = "[REDACTED]",
    ["value"] = "[REDACTED]",
    ["sell"] = "[REDACTED]",
    ["random"] = "[REDACTED]",
    ["selected"] = "[REDACTED]",
    ["blind"] = "[REDACTED]",
    ["booster"] = "[REDACTED]",
    ["pack"] = "[REDACTED]",
    ["destroy"] = "[REDACTED]",
    ["joker"] = "[REDACTED]",
    ["mult"] = "[REDACTED]",
    ["chips"] = "[REDACTED]",
    ["X"] = "[REDACTED]",
    ["create"] = "[REDACTED]",
    ["played"] = "[REDACTED]",
    ["to"] = "[REDACTED]",
    ["up"] = "[REDACTED]",
    ["go"] = "[REDACTED]",
    ["hands"] = "[REDACTED]",
    ["gives"] = "[REDACTED]",
    ["one"] = "[REDACTED]"
}

-- Modified UI generator
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local tab = original_generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    
    if G.jokers and next(SMODS.find_card("j_tngt_roblox")) then
        for i, t in ipairs(tab.main) do
            for j, k in ipairs(tab.main[i]) do
                if k.config and k.config.text then
                    local text = k.config.text
                    for word, replacement in pairs(hashtag_map) do
                        text = text:gsub(word, replacement)
                        text = text:gsub(word:sub(1,1):upper()..word:sub(2), 
                                      replacement:sub(1,1):upper()..replacement:sub(2))
                    end
                    
                    if text ~= k.config.text then
                        k.config.text = text
                        k.config.colour = G.C.DARK_EDITION
                    end
                end
            end
        end
    end
    
    return tab
end

function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
  if G.jokers and next(SMODS.find_card("j_tngt_roblox")) and (key == "chips" or key == "chip_mod" or key == "h_chips") then
    if key == "chip_mod" then effect.message = nil end
    return ref(effect, scored_card, "xchips", amount, from_edition) --Changing key to xmult. If you want to change how much xmult it should give, change amount, I assume.
  else
    return ref(effect, scored_card, key, amount, from_edition)
  end
end

SMODS.Joker {
    key = 'strike',
    loc_txt = {
        name = 'Dear {C:gold}God{}, please {C:red}strike{} this {C:attention}Joker{} down.',
        text = {
            "After #2# {C:attention}Rounds{}, sell this Cat to",
            "add {C:dark_edition}Negative{} to a random Joker",
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
    eternal_compat = true,
    perishable_compat = true,
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


SMODS.Joker {
    key = 'christ',
    loc_txt = {
        name = "But {C:red}Jim{C:blue}bo{} said:",
        text = {
            "All {C:attention}shop items{} are {C:green}free{}",
            "Pay {C:money}$#1#{} when entering {C:attention}Blind{}",
            "{C:inactive}(Self-destructs if {C:money}$#1#{C:inactive} can't be paid){}"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla11',
    pos = { x = 1, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { fee = 15 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.fee },
            colours = { G.C.MONEY }
        }
    end,
    calculate = function(self, card, context)
        if context.starting_shop or context.reroll_shop then
            for _, c in ipairs(G.shop_jokers.cards) do
                c.ability.couponed = true
                c:set_cost()
            end
            for _, c in ipairs(G.shop_booster.cards) do
                c.ability.couponed = true
                c:set_cost()
            end
            for _, c in ipairs(G.shop_vouchers.cards) do
                c.ability.couponed = true
                c:set_cost()
            end
            return {
                message = "For free?",
                colour = G.C.MONEY
            }
        end
        if context.setting_blind and not context.blueprint then
            local fee = card.ability.extra.fee
            if to_big(G.GAME.dollars) >= to_big(card.ability.extra.fee) then
                G.GAME.dollars = G.GAME.dollars - fee
                return {
                    ease_dollars(fee)
                }
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve(nil, true)
                        play_sound('tarot1')
                        return true
                    end
                }))
                return {
                    message = "broke bitch",
                    colour = G.C.RED
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.shop_free = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.shop_free = false
        if G.shop then
            for _, c in ipairs(G.shop_jokers.cards) do
                c.ability.couponed = nil
                c:set_cost()
            end
            for _, c in ipairs(G.shop_booster.cards) do
                c.ability.couponed = nil
                c:set_cost()
            end
            for _, c in ipairs(G.shop_vouchers.cards) do
                c.ability.couponed = nil
                c:set_cost()
            end
            for _, c in ipairs(G.shop_consumables.cards) do
                c.ability.couponed = nil
                c:set_cost()
            end
        end
    end
}

local ease_dollars_ref = ease_dollars
function ease_dollars(amount, instant, silent)
    local ret = ease_dollars_ref(amount, instant, silent)
    if to_big(amount) < to_big(0) and G.GAME.dollars_spent then
        G.GAME.dollars_spent = G.GAME.dollars_spent - amount -- dear god please add an actual spending detection
    end

    return ret
end

SMODS.Joker {
    key = 'college',
    loc_txt = {
        name = "Tuition",
        text = {
            "{X:mult,C:white}X#1#{} Mult and {X:blue,C:white}X#2#{} Chips if you have spent",
            "atleast {C:gold}$#3#{} in this run.",
            "{C:inactive}(Currently Spent: {C:gold}$#4#{}{C:inactive}/{C:gold}$#3#{}{C:inactive})"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla11',
    pos = { x = 4, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    config = { extra = {
        xmult = 6,
        xchips = 3,
        threshold = 400
    } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'jank', set = 'Other' }
        local dollars_spent = G.GAME.dollars_spent or 0
        local meets_threshold = dollars_spent >= card.ability.extra.threshold
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xchips,
                card.ability.extra.threshold,
                dollars_spent
            },
            colours = { meets_threshold and G.C.MONEY or G.C.UI.TEXT_LIGHT }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local dollars_spent = G.GAME.dollars_spent or 0
            if dollars_spent >= card.ability.extra.threshold then
                if not card.ability.activated_this_round then
                    card.ability.activated_this_round = true
                    card:juice_up(0.5, 0.5)
                    play_sound('gold_seal', 1.2)
                end

                return {
                    xmult = card.ability.extra.xmult,
                    xchips = card.ability.extra.xchips
                }
            end
        end
        if context.end_of_round then
            card.ability.activated_this_round = false
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.dollars_spent = G.GAME.dollars_spent or 0
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
    key = 'eggwuh',
    loc_txt = {
        name = 'It comes with {f:tngt_times}eggwah..~{}{f:emoji}👅',
        text = {
            "Has {C:green}1{} in {C:green}#1#{} chance to creates an {C:attention}Egg Joker{}",
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
                if SMODS.pseudorandom_probability(card, 'mustard', 1, card.ability.extra.chance) then
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
    key = 'geo',
    loc_txt = {
        name = 'National Geographic',
        text = {
            "Played {C:attention}Wild{} cards will give you either {C:red}+#1#{} Mult,",
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
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult + atlussy } }
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
                            key_append = 'spawned_by_boss'
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

        if is_fullscreen and not card.ability.extra.is_fucked then
            card.ability.extra.is_fucked = true
            card:juice_up(0.5, 0.5)
            play_sound('tngt_neverforget')
        elseif not is_fullscreen then
            card.ability.extra.is_fucked = false
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
        if context.joker_main then
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
    end
}

local updatehook = Game.update
function Game:update(dt)
    updatehook(self, dt)
    if G.nxkoo_dies.show_image then
        G.nxkoo_dies.image_timer = G.nxkoo_dies.image_timer - dt
        if G.nxkoo_dies.image_timer <= 0 then
            G.nxkoo_dies.show_image = false
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

    if G.nxkoo_dies.show_image then
        if not G.nxkoo_dies.show_image then
            G.nxkoo_dies.show_image = load_image("damnbird.png")
        end
        local alpha = math.min(1, G.nxkoo_dies.image_timer * 2)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(G.nxkoo_dies.damnbird_png, 0, 0, 0, _xscale, _yscale)
    end
end

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
    rarity = 3,
    atlas = 'ModdedVanilla4',
    pos = { x = 2, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
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
    key = 'itstartswith',
    loc_txt = {
        name = "{C:attention}One{} thing, i {C:red}don't{} know {C:attention}why{}..",
        text = {
            "Gains {X:mult,C:white}X#2#{} for each {C:attention}played{} cards.",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult.)",
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
    config = { extra = { Xmult = 1, Xmult_mod = 0.1 } }, -- From Cryptid, but i did tweak some shit to make it work here
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.extra.Xmult),
                number_format(center.ability.extra.Xmult_mod),
            },
        }
    end,
    calculate = function(self, card, context)
        if
            not context.blueprint
            and (
                (context.post_trigger and context.other_joker ~= card)
                or (context.individual and context.cardarea == G.play)
            )
        then
            card.ability.extra.Xmult = (card.ability.extra.Xmult) + (card.ability.extra.Xmult_mod)
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex") })
        end
        if context.joker_main and card.ability.extra.Xmult then
            return {
                message = localize({
                    type = "variable",
                    key = "a_xmult",
                    vars = {
                        number_format(card.ability.extra.Xmult),
                    },
                }),
                Xmult_mod = (card.ability.extra.Xmult),
                colour = G.C.MULT,
            }
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
    key = 'jesus',
    loc_txt = {
        name = "{C:gold}He{} has rizzen.",
        text = {
            "This Jesus gains {X:mult,C:white}X#2#{} Mult",
            "for each {X:dark_edition,C:white}Divine{} {X:dark_edition,C:white}Intervention{} happened in this run.",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
        }
    },
    rarity = 3,
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
    key = 'donpollo',
    loc_txt = {
        name = "El que quiera perder el tiempo- {f:tngt_emoji}📞📞📞📞{}",
        text = {
            "Upon {C:attention}selecting a blind{} or {C:attention}exiting a shop{},",
            "create a {C:attention}Food{} Joker."
        }
    },
    rarity = 3,
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
                if shop_card.config.center.key == self.key and to_big(G.GAME.dollars) >= shop_card.cost then
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

local updatehook = Game.update
function Game:update(dt)
    updatehook(self, dt)
    if G.nxkoo_dies.show_flashbang then
        G.nxkoo_dies.flashbang_timer = G.nxkoo_dies.flashbang_timer - dt
        if G.nxkoo_dies.flashbang_timer <= 0 then
            G.nxkoo_dies.show_flashbang = false
            G.nxkoo_dies.current_flashbang = nil
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()

    function load_flashbang(fn)
        local full_path = (G.nxkoo_dies.path .. "assets/customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempflashbangdata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempflashbangdata)))
    end

    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080

    if G.nxkoo_dies.show_flashbang and G.nxkoo_dies.current_flashbang then
        local alpha = math.min(1, G.nxkoo_dies.flashbang_timer * 2)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(G.nxkoo_dies.current_flashbang, 0, 0, 0, _xscale, _yscale)
    end
end

local updatehook = Game.update
function Game:update(dt)
    updatehook(self, dt)
    if G.nxkoo_dies.show_flashbang then
        G.nxkoo_dies.flashbang_timer = G.nxkoo_dies.flashbang_timer - dt
        if G.nxkoo_dies.flashbang_timer <= 0 then
            G.nxkoo_dies.show_flashbang = false
            G.nxkoo_dies.current_flashbang = nil
        end
    end
end

local drawhook = love.draw
function love.draw()
    drawhook()

    function load_flashbang(fn)
        local full_path = (G.nxkoo_dies.path .. "assets/customimages/" .. fn)
        local file_data = assert(NFS.newFileData(full_path))
        local tempflashbangdata = assert(love.image.newImageData(file_data))
        return (assert(love.graphics.newImage(tempflashbangdata)))
    end

    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080

    if G.nxkoo_dies.show_flashbang and G.nxkoo_dies.current_flashbang then
        local alpha = math.min(1, G.nxkoo_dies.flashbang_timer * 2)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(G.nxkoo_dies.current_flashbang, 0, 0, 0, _xscale, _yscale)
    end
end

SMODS.Joker {
    key = "flasbangout",
    loc_txt = {
        name = "Think fast, {C:dark_edition}Chucklenuts",
        text = {
            "Throws a {C:attention}flashbangs{} for ALL interactions",
            "Gains {C:chips}+#1#{} Chips and {X:mult,C:white}X#2#{} Mult per unique flashbang",
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
        if not G.nxkoo_dies.flashbangs_loaded then
            for k, v in pairs(G.nxkoo_dies.flashbangs) do
                G.nxkoo_dies.flashbangs[k] = load_flashbang(v)
            end
            G.nxkoo_dies.flashbangs_loaded = true
        end

        G.nxkoo_dies.current_flashbang = G.nxkoo_dies.flashbangs[flashbang_key]
        G.nxkoo_dies.show_flashbang = true
        G.nxkoo_dies.flashbang_timer = 0.75

        if not card.ability.extra.shown_flashbangs then
            card.ability.extra.shown_flashbangs = {}
        end

        if not card.ability.extra.shown_flashbangs[flashbang_key] then
            card.ability.extra.shown_flashbangs[flashbang_key] = true
            card.ability.extra.flashbangs_shown = card.ability.extra.flashbangs_shown + 1

            -- Spawn Ash Baby after 5 unique flashbangs
            if card.ability.extra.flashbangs_shown >= 5 and not card.ability.extra.ashbaby_spawned then
                if #G.jokers.cards < G.jokers.config.card_limit then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({
                                set = "Joker",
                                key = "j_tngt_ashbaby",
                                key_append = "from_flasbangout"
                            })
                            card.ability.extra.ashbaby_spawned = true
                            play_sound('tarot1', 1.4, 0.3)
                            return true
                        end
                    }))
                end
            end

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

        if context.pre_discard and context.main_evail then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'discard')
        end

        if context.end_of_round and not context.blueprint then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'round_start')
        end

        if context.pseudorandom_result and not context.result then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'blind')
        end

        if context.pseudorandom_result and context.result then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'blind')
        end

        if context.initial_scoring_step then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'blind')
        end

        if context.joker_type_destroyed then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'blind')
        end

        if context.post_trigger then
            play_sound("tngt_flashbang")
            self:show_omnipotent_flashbang(card, 'joker_trigger')
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
    config = { extra = { xmult = 2, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local c = context.other_card
            local is_last_card = c == G.play.cards[#G.play.cards]
            local sound = "tngt_birdthatihate"
            return {
                focus = context.other_card,
                xmult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.xmult } },
                sound = sound,
                extra = {
                    sound = is_last_card and "tngt_thatFUCKINbirdthatihate" or "tngt_birdthatihate",
                    message = is_last_card and "T H A T  F U C K I N '  B I R D  T H A T  I  H A T E." or nil
                },
                colour = G.C.RED
            }
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
    rarity = 3,
    atlas = 'ModdedVanilla9',
    pos = { x = 2, y = 1 },
    cost = 8,
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
    key = 'ashbaby',
    loc_txt = {
        name = "{C:inactive}AAAAAAAAAAAAA{}",
        text = {
            "{C:attention}Destroyed{} card have a {C:green}1{} in {C:green}#3#{} chance to be {C:attention}duplicated{}",
            "and gains {X:mult,C:white}X#1#{} for each destroyed card",
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
    end,
    in_pool = function(self, args)
        return false
    end

}

SMODS.Joker {
    key = 'allegations',
    loc_txt = {
        name = "Allegations",
        text = {
            "If total chips of {C:attention}scoring{} cards are below {C:attention}18{},",
            "this {C:attention}Video{} gains {X:mult,C:white}X#3#{} Mult.",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult)"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla12',
    pos = { x = 1, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = {
        extra = {
            threshold = 18,      
            base_xmult = 1,       
            xmult_gain = 0.5,     
            current_xmult = 1     
        }
    },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "artist2", set = "Other" }
        return {
            vars = {
                card.ability.extra.threshold,
                card.ability.extra.current_xmult,
                card.ability.extra.xmult_gain
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_chips = 0
            for _, c in ipairs(context.scoring_hand) do
                total_chips = total_chips + (c.chips or 0)
            end
            if total_chips < card.ability.extra.threshold then
                card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.xmult_gain
                
                return {
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.current_xmult}},
                    colour = G.C.MULT,
                    card = card,
                    xmult = card.ability.extra.current_xmult
                }
            else
                return {
                    xmult = card.ability.extra.current_xmult
                }
            end
        end
    end
}

local function block_input_randomly()
    if pseudorandom('input_blocker') <= 0.5 then
        local original_isDown = love.mouse.isDown
        local original_getPosition = love.mouse.getPosition
        local original_isVisible = love.mouse.isVisible
        love.mouse.isDown = function() return false end
        love.mouse.getPosition = function() return 0, 0 end
        love.mouse.isVisible = function() return false end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1,
            blockable = false,
            blocking = true,
            no_delete = true,
            timer = 'REAL',
            func = function()
                love.mouse.isDown = original_isDown
                love.mouse.getPosition = original_getPosition
                love.mouse.isVisible = original_isVisible
                return true
            end
        }))
        
        return true
    end
    return false
end

SMODS.Joker {
    key = 'notliekthis',
    loc_txt = {
        name = "NotLikeThis",
        text = {
            "{X:mult,C:white}X#1#{} Mult,",
            "fixed {C:green}50%{} chance to lags",
            "your mouse inputs for a second"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla14',
    pos = { x = 1, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    config = { extra = { xmult = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.starting_shop and not context.blind then
            block_input_randomly()
        end

        if context.ending_shop and not context.blind then
            block_input_randomly()
        end

        if context.buying_card then
            block_input_randomly()
        end

        if context.selling_card then
            block_input_randomly()
        end

        if context.reroll_shop then
            block_input_randomly()
        end

        if G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER then
            block_input_randomly()
        end

        if context.setting_blind and context.blind then
            block_input_randomly()
        end

        if context.skip_blind then
            block_input_randomly()
        end

        if G.GAME.blind and G.GAME.blind.boss and context.end_of_round and not context.game_over then
            block_input_randomly()
        end

        if context.pre_discard and context.main_eval then
            block_input_randomly()
        end

        if context.pseudorandom_result and not context.result then
            block_input_randomly()
        end

        if context.pseudorandom_result and context.result then
            block_input_randomly()
        end

        if context.initial_scoring_step then
            block_input_randomly()
        end

        if context.joker_type_destroyed then
            block_input_randomly()
        end

        if context.post_trigger then
            block_input_randomly()
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker {
    key = "obamaprism",
    loc_txt = {
        name = "Let me be clear.",
        text = {
            "If first played hand of the round is",
            "a {C:attention}Three Of A Kind{}, destroy all played cards and creates",
            "up to {C:attention}2{} {C:spectral}Spectral{} cards"
        }
    },
    rarity = 3,
    atlas = 'ModdedVanilla13',
    pos = { x = 1, y = 1 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {}
    },
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and 
           G.GAME.current_round.hands_played == 0 and
           next(context.poker_hands['Three of a Kind']) then
            local spectral_space = G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
            local spectral_count = math.min(2, spectral_space)
            
            if spectral_count > 0 then
                for _, played_card in ipairs(context.scoring_hand) do
                    played_card:start_dissolve()
                end
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + spectral_count
                return {
                    message = localize('k_plus_spectral').." x"..spectral_count,
                    colour = G.C.SECONDARY_SET.Spectral,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                for _ = 1, spectral_count do
                                    SMODS.add_card {
                                        set = 'Spectral',
                                        key_append = 'three_of_a_kind_spectral'
                                    }
                                end
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            else
                return {
                    message = localize('k_no_room_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
}

local last_purchased_joker = nil
local original_buy_card = buy_card
function buy_card(self, card, area, skip_check)
    local ret = original_buy_card(self, card, area, skip_check)
    if ret and card and card.ability and card.ability.set == 'Joker' then
        last_purchased_joker = card.config.center.key
    end
    return ret
end

SMODS.Joker {
    key = 'bigchungus',
    loc_txt = {
        name = "That'll hold em, alwight? hehehehe..",
        text = {
            "Copies ability of last purchased {C:attention}Joker{}"
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    rarity = 3,
    atlas = 'ModdedVanilla14',
    pos = { x = 2, y = 1 },
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local main_end = nil
        if last_purchased_joker then
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", minh = 0.4, padding = 0.1 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { align = "cm", minw = 2.5, minh = 0.4, r = 0.1, padding = 0.1, colour = G.C.JOKER_GREY },
                            nodes = {
                                { n = G.UIT.T, config = { text = localize(last_purchased_joker, 'jokers'), scale = 0.3, colour = G.C.UI.TEXT_LIGHT } }
                            }
                        }
                    }
                }
            }
        end
        return { main_end = main_end }
    end,
    calculate = function(self, card, context)
        if not last_purchased_joker then return end
        local target_joker = nil
        for _, j in ipairs(G.jokers.cards) do
            if j.config.center.key == last_purchased_joker and j ~= card then
                target_joker = j
                break
            end
        end
        
        if target_joker then
            local original_joker = SMODS.find_joker(last_purchased_joker)
            if original_joker and original_joker.calculate then
                local original_context = context or {}
                original_context.echo_source = card
                local ret = original_joker.calculate(target_joker, original_context)
                if ret then
                    ret.colour = ret.colour or G.C.BLUE
                    ret.message = (ret.message or "") .. " (Echo)"
                    return ret
                end
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if not last_purchased_joker then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and i > 1 then
                    last_purchased_joker = G.jokers.cards[i-1].config.center.key
                    break
                end
            end
        end
    end
}