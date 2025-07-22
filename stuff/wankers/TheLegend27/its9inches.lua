
SMODS.Joker {
    key = "tenna",
    display_size = { w = 64, h = 64 },
    pos = { x = 0, y = 0 },
    frames = 93,
    frame_delay = 0.01,
    atlas = "tennas",
    display_size = { w = 71 * 1.1, h = 95 * 1.1 },
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
            ILOVETV = 76,
            tenna_mult = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'ilovetv', set = 'Other' }
        info_queue[#info_queue + 1] = { key = 'manually', set = 'Other' }
        return {
            vars = { card.ability.extra.tenna_mult, card.ability.extra.ILOVETV * card.ability.extra.tenna_mult }
        }
    end,
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    set_ability = function(self, card, initial, delay_sprites)
        remove_all_running_animation(card)
        add_animated_sprite(card)
    end,
    add_to_deck = function()
        play_sound('tngt_sayitwithmefolks')
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            play_sound("tngt_fromyourhouse")
            return {
                message = "CUMMING STRAIGHT FROM YOUR HOUSE.",
                x_mult = card.ability.extra.ILOVETV * card.ability.extra.tenna_mult
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


SMODS.Joker {
	key = 'you',
	loc_txt = {
		name = '{f:tngt_DETERMINATION}You{}',
		text = {
			"{f:tngt_DETERMINATION,}* Despite everything, it's still you.{}"
		}
	},
	config = { extra = {} },
	rarity = "tngt_4TH WALL",
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
    blueprint_compat = true,
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
    blueprint_compat = true,
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
    blueprint_compat = true,
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
    key = 'f1forhelp',
    loc_txt = {
        name = "{f:tngt_DETERMINATION,s:2,C:attention}PRESS {f:tngt_DETERMINATION,s:2}[[{C:attention,f:tngt_DETERMINATION,s:2}F1{}{f:tngt_DETERMINATION,s:2}]] FOR [[{C:green,f:tngt_DETERMINATION,s:2}Help{}{f:tngt_DETERMINATION,s:2}]]",
        text = {
            "If you're in a {X:green,C:white,E:2}pickle{} or in the verge of {C:red}losing{} this run",
            "{f:tngt_DETERMINATION,s:1.5,C:attention}PRESS{} {f:tngt_DETERMINATION,s:1.5}[[{C:attention,f:tngt_DETERMINATION,s:1.5}F1{}{f:tngt_DETERMINATION,s:1.5}]] FOR [[{C:green,f:tngt_DETERMINATION,s:1.5}Help{}{f:tngt_DETERMINATION,s:1.5}]]"
        }
    },
    rarity = 4,
    atlas = 'ModdedVanilla11',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    config = {
        extra = {
            uses_remaining = 2,
            hands_given = 2,
            discards_given = 2,
            key_cooldown = 0 -- spam
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.uses_remaining } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.uses_remaining = 2
            return {
                message = localize('k_reset'),
                colour = G.C.BLUE
            }
        end
        if G.STATE == G.STATES.PLAY_TAROT and
            card.ability.extra.uses_remaining > 0 and
            love.keyboard.isDown("f1") and
            card.ability.extra.key_cooldown <= 0 then
            card.ability.extra.key_cooldown = 10
            card.ability.extra.uses_remaining = card.ability.extra.uses_remaining - 1
            ease_hands_played(card.ability.extra.hands_given)
            ease_discard(card.ability.extra.discards_given)
            card:juice_up(0.5, 0.5)
            play_sound('chips2', 1.1, 0.8)
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = string.format("+%d Hands\n+%d Discards",
                            card.ability.extra.hands_given,
                            card.ability.extra.discards_given),
                        colour = G.C.BLUE,
                        delay = 0.4
                    })
                    return true
                end
            }))

            return {
                sound = "tngt_recruit",
                message = ":3",
                colour = G.C.BLUE
            }
        end
        if card.ability.extra.key_cooldown > 0 then
            card.ability.extra.key_cooldown = card.ability.extra.key_cooldown - 1
        end
    end
}