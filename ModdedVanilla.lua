SMODS.Sound {
	key = "mvan_neverforget",
	path = "neverforget.ogg"
}

SMODS.Sound {
	key = "mvan_birdthatihate",
	path = "birdthatihate.ogg"
}

SMODS.Sound {
	key = "mvan_thatFUCKINbirdthatihate",
	path = "thatFUCKINbirdthatihate.ogg"
}

SMODS.Sound {
	key = "mvan_snowgrave",
	path = "snowgrave.ogg"
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
	prefix_config = {key = false}
}:register()


function Card:resize(mod, force_save)
    self:hard_set_T(self.T.x, self.T.y, self.T.w * mod, self.T.h * mod)
    remove_all(self.children)
    self.children = {}
    self.children.shadow = Moveable(0, 0, 0, 0)
    self:set_sprites(self.config.center, self.base.id and self.config.card)
end

local mainmenuref2 = Game.main_menu
Game.main_menu = function(change_context)

    local ret = mainmenuref2(change_context)

        --Replace j_unik_unik with 'j_perkeo' or any other card
    local newcard = SMODS.create_card({key='j_mvan_starwalker',area = G.title_top})
    G.title_top.T.w = G.title_top.T.w * 1.7675
    G.title_top.T.x = G.title_top.T.x - 0.8
    G.title_top:emplace(newcard)
    newcard:start_materialize()
    newcard:resize(1.1 * 1.2)
    newcard.no_ui = true
    return ret
end

SMODS.Sound{
	key = 'THX',
	path = 'introPad1.wav',
	replace = 'introPad1'
}

SMODS.Sound{
	key = 'watchyojet',
	path = 'magic_crumple.wav',
	replace = 'magic_crumple'
}

SMODS.Sound{
	key = 'PS2',
	path = 'magic_crumple2.wav',
	replace = 'magic_crumple2'
}

SMODS.Sound{
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


SMODS.Font {
	key = "DETERMINATION",
	path = "PixelOperator-Bold.ttf",
	render_scale = 128,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = {x=0,y=0},
	FONTSCALE = 0.23,
	squish = 1,
	DESCSCALE = 1
}

SMODS.Font {
	key = "gross",
	path = "DJGROSS.ttf",
	render_scale = 128,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = {x=0,y=0},
	FONTSCALE = 0.11,
	squish = 1,
	DESCSCALE = 1
}

SMODS.Font {
	key = "papyrus",
	path = "PAPYRUS.TTF",
	render_scale = 86,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = {x=0,y=0},
	FONTSCALE = 0.2,
	squish = 1,
	DESCSCALE = 1
}

SMODS.Font {
	key = "omori",
	path = "OMORI_GAME2.ttf",
	render_scale = 128,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = {x=0,y=0},
	FONTSCALE = 0.23,
	squish = 1,
	DESCSCALE = 1
}

SMODS.Font {
	key = "emoji",
	path = "NotoEmoji-Regular.ttf",
	render_scale = 95,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = {x=0,y=0},
	FONTSCALE = 0.23,
	squish = 1,
	DESCSCALE = 1
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
					return {repetitions = 2}
				end
			end
	end
}

SMODS.Joker {
	key = 'error',
	loc_txt = {
		name = 'joker.mdl',
		text = {
		"{C:red}ERR{}{C:dark_edition}O{}{C:red}R{}"
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
	atlas = 'ModdedVanilla2',
	pos = { x = 0, y = 0 },
	cost = 4,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
		if context.other_card:get_id() == 7 or context.other_card:get_id() == 4 then
					return {repetitions = 2}
				end
			end
	end
}

SMODS.Joker {
	key = 'error',
	loc_txt = {
		name = 'joker.mdl',
		text = {
		"{C:red}ERR{}{C:dark_edition}O{}{C:red}R{}"
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
	atlas = 'ModdedVanilla2',
	pos = { x = 0, y = 0 },
	cost = 4,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
		if context.other_card:get_id() == 7 or context.other_card:get_id() == 4 then
					return {repetitions = 2}
				end
			end
	end
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
	config = { },
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
			"After #2# {C:attention}Rounds{}, sell this Cat to make",
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
	rarity = 2,
	atlas = 'ModdedVanilla5',
	pos = { x = 0, y = 0 },
	cost = 4,
	calculate = function(self, card, context)
		-- Count rounds passed
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
	
		-- If selling after threshold reached, turn random joker into Negative edition
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
			"{C:red,s:2}or else.",
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
        card.ability.time = string.gsub(string.format("%.2f", 20 - (G.TIMERS.REAL - card.ability.start) * card.ability.inblind), "%.", ":")
    end,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	rarity = 2,
	atlas = 'ModdedVanilla6',
	pos = { x = 0, y = 0 },
	cost = 4,
	calculate = function(self, card, context)
        if context.blueprint then return end

        if context.setting_blind then
            card.ability.start = G.TIMERS.REAL
            card.ability.inblind = 1
            return {

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

SMODS.Joker {
	key = 'geo',
	loc_txt = {
		name = 'National Geographic',
		text = {
			"Played {C:attention}Wild{} cards will gives you either {C:red}+#1#{} Mult,",
			"{X:mult,C:white}X#2#{} Mult, {C:blue}+#3#{} Chips, or {C:gold}$#4#{} Dollars."
		}
	},
	rarity = 2,
	atlas = 'ModdedVanilla2',
	pos = { x = 1, y = 0 },
	cost = 3,
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
	rarity = 2,
	atlas = 'ModdedVanilla3',
	pos = { x = 1, y = 0 },
	cost = 3,
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
			"Attempt to summon a random {C:attention}Jokers{} upon",
			"defeating the {C:attention}Boss Blind.{}",
			"{C:inactive}(Cannot overflow, maybe..){}"
		}
	},
	rarity = 2,
	atlas = 'ModdedVanilla4',
	pos = { x = 1, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
    config = { },
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
			"{f:mvan_papyrus,X:dark_edition,C:white}Head..{} given by {C:attention}Radio{} in this run.",
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
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.mult}},
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
	cost = 3,
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
                    message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips_per_consumable * consumable_count}},
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
	key = 'fish',
	loc_txt = {
		name = 'You know what that mean? :D',
		text = {
			"{C:attention,s:3}fish.{}",
			"Gains {C:blue}+15{} Chips for each played cards."
		}
	},
	config = { extra = { chips = 15 } },
	rarity = 1,
	atlas = 'ModdedVanilla',
	pos = { x = 2, y = 0 },
	cost = 6,
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
	key = 'hallucinations',
	loc_txt = {
		name = 'This Joker',
		text = {
			"{C:attention}This Joker tricks you into thinking",
			"{C:attention}the squares are different color!{}",
			"{X:mult,C:white}Stick your finger in your ass{}"
		}
	},
	config = { extra = { chips = 15 } },
	rarity = 1,
	atlas = 'ModdedVanilla2',
	pos = { x = 2, y = 0 },
	cost = 6,
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
	key = 'starwalker',
	loc_txt = {
		name = 'The original  {C:attention}starwalker{}',
		text = {
			"{s:2}* This sprite is {C:attention,s:2}pissing{} {s:2}me off...{}",
			"Gives a random amount of {C:red}+Mult{} for each {C:attention}Diamonds{} played."
		}
	},
	config = { extra = { mult = 15 } },
	rarity = 1,
	atlas = 'ModdedVanilla3',
	pos = { x = 2, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
    loc_vars = function(self, info_queue, card)
        return {}
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
	config = { extra = { chips = 15 } },
	rarity = 1,
	atlas = 'ModdedVanilla4',
	pos = { x = 2, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = true,
    loc_vars = function(self, info_queue, card)
        return {}
    end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.other_card:is_face() then
			return {
				chips = card.ability.extra.chips
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
			"{C:inactive})Currently {C:attention}#{} {C:inactive}out of {C:attention}#{}{C:inactive})"
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
    config = { extra = { base_xmult = 2.5 } },
    loc_vars = function(self, info_queue, card)
        local gem_alert = 0
        if G.jokers then
            for _, j in ipairs(G.jokers.cards) do
                if j ~= card and j.config.center.rarity > 1 then
                    gem_alert = gem_alert + 1
                end
            end
        end
        return { vars = { card.ability.extra.base_xmult, gem_alert } }
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
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.base_xmult * gem_alert}},
                    xmult = card.ability.extra.base_xmult * gem_alert
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
	key = 'freak',
	loc_txt = {
		name = '{f:mvan_papyrus}jofreak{}',
		text = {
			"{f:mvan_papyrus}i'm fr a {f:mvan_papyrus,X:dark_edition,C:white}freak{}, {f:mvan_papyrus}just {f:mvan_papyrus,C:attention,E:1}lmk...{}",
			"{f:mvan_papyrus}Played {f:mvan_papyrus,C:attention}6{} and {f:mvan_papyrus,C:attention}9{} has {f:mvan_papyrus,C:green}#1# in #2#{} chance to give {f:mvan_papyrus,X:mult,C:white}X6.9{} Mult."
		}
	},
	config = { extra = { odds = 2, xmult = 6.9 } },
	rarity = 2,
	atlas = 'ModdedVanilla',
	pos = { x = 3, y = 0 },
	cost = 7,
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
	rarity = 3,
	atlas = 'ModdedVanilla2',
	pos = { x = 3, y = 0 },
	cost = 7,
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
	cost = 7,
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
		name = "{f:mvan_omori}Junny{}"
	},
	rarity = 3,
	atlas = 'ModdedVanilla4',
	pos = { x = 3, y = 0 },
	cost = 7,
	unlocked = true,
	discovered = true,
    config = { extra = { xmult = 0.2 } },
    loc_vars = function(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "Dark", set = "Other", vars = {colour = {G.C.SUITS.Spades, G.C.SUITS.Hearts, G.C.SUITS.Clubs, G.C.SUITS.Diamonds}}}
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
	rarity = 3,
	atlas = 'ModdedVanilla5',
	pos = { x = 3, y = 0 },
	cost = 7,
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
    config = { extra = {x = 5} },
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            return {
                dollars = G.GAME.dollars * card.ability.extra.x-1,
                message = "HECK.",
                message_card = card
            }
        end
    end
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
				play_sound = "mvan_neverforget",
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
            pseudoseed((card.area and card.area.config.type == 'title') and 'mvan_chud' or 'mvan_chud'))
    end
}

SMODS.Joker {
	key = 'dependencies',
	loc_txt = {
		name = '{C:red}Missing Dependencies!{}',
	},
	config = { extra = { repetitions = 1 } },
	rarity = 2,
	atlas = 'ModdedVanilla3',
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
            pseudoseed((card.area and card.area.config.type == 'title') and 'mvan_chud' or 'mvan_chud'))
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
            pseudoseed((card.area and card.area.config.type == 'title') and 'mvan_chud' or 'mvan_chud'))
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
		return {
			vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.chips_gain, card.ability.extra.mult_gain }
		}	
    end,
	calculate = function(self, card, context)
		-- Track retriggers per card
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card.scored then
				context.other_card.retriggered = true
			else
				context.other_card.scored = true
			end
		end
	
		-- After scoring: upgrade if no retriggers
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
					message = "Clean Hand!",
					colour = G.C.FILTER
				}
			end
		end
	
		-- During scoring, apply bonus
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult
			}
		end
	end		
}

SMODS.Joker {
	key = 'approach',
	loc_txt = {
		name = '1. {C:attention}Approach{} the child.',
		text = {
			"{s:3,C:red}AGGRESIVELY.{}"
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = {} },
	rarity = 4,
	atlas = 'ModdedVanilla',
	pos = { x = 0, y = 1 },
	-- soul_pos sets the soul sprite, only used in vanilla for legendary jokers and Hologram.
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

SMODS.Joker {
	key = 'gangsta',
	loc_txt = {
		name = 'Gangsta Paradise',
		text = {
			"{C:attention,s:2}AAAAAAAAAAAAAAAAAAAAAAA{}"
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = {} },
	rarity = 4,
	atlas = 'ModdedVanilla2',
	pos = { x = 0, y = 1 },
	-- soul_pos sets the soul sprite, only used in vanilla for legendary jokers and Hologram.
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

SMODS.Joker {
	key = 'you',
	loc_txt = {
		name = '{f:mvan_DETERMINATION}You{}',
		text = {
			"{f:mvan_DETERMINATION,}* Despite everything, it's still you.{}"
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = {} },
	rarity = 4,
	atlas = 'ModdedVanilla3',
	pos = { x = 0, y = 1 },
	-- soul_pos sets the soul sprite, only used in vanilla for legendary jokers and Hologram.
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
		return { vars = { } }
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

SMODS.Joker {
	key = 'kingvon',
	loc_txt = {
		name = "{C:attention}King{} {C:red}Von{}",
		text = {
			"Upgrade the level of the first {C:attention}played",
			"and {C:attention}discarded{} poker hand each round."
		}
	},
	config = { extra = {} },
	rarity = 4,
	atlas = 'ModdedVanilla5',
	pos = { x = 0, y = 1 },
	cost = 20,
	unlocked = true,
	discovered = true,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play and not card.ability._played_upgraded then
            local text = context.scoring_name
            if text then
                card.ability._played_upgraded = true
                return {
                    level_up = true,
                    level_up_hand = text,
                    message = "Tutored!",
                    colour = G.C.BLUE
                }
            end
        end

        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not card.ability._discarded_upgraded then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if text then
                card.ability._discarded_upgraded = true
                return {
                    level_up = true,
                    level_up_hand = text,
                    message = "Tutored!",
                    colour = G.C.BLUE
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    update = function(self, card)
        if G.GAME.round_resets and G.GAME.round_resets.blind then
            card.ability._played_upgraded = false
            card.ability._discarded_upgraded = false
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
					context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) +
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
	rarity = 2,
	atlas = 'ModdedVanilla4',
	pos = { x = 1, y = 1 },
	cost = 5,
	unlocked = true,
	discovered = true,
	config = { extra = { mult_bonus = 20, xmult_bonus = 11, chip_bonus = 20.12, dollar_bonus = 14 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "teto", set = "Other"}
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
	key = 'virtual',
	loc_txt = {
		name = "Jokeroquai",
		text = {
			"aye dab me up"
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = {} },
	rarity = 4,
	atlas = 'ModdedVanilla3',
	pos = { x = 2, y = 1 },
	-- soul_pos sets the soul sprite, only used in vanilla for legendary jokers and Hologram.
	soul_pos = { x = 3, y = 1 },
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
				{ message = "KYS!" })
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
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
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
		name = "broski tweakin{f:mvan_emoji}🙏🔥💀{}",
		text = {
			"After playing {C:attention}5 Big Booms{}",
			"{C:inactive}5 Big Booms = 5 played cards with ranks above 5{}",
			"Spawn {C:tarot}Justice{}"
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = { xmult = 1, xmult_gain = 0.5 } },
	rarity = 2,
	atlas = 'ModdedVanilla5',
	pos = { x = 3, y = 1 },
	cost = 5,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_justice
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
				func = function()
					play_sound('mvan_birdthatihate', 1, 1)
					replace = 'multhit2'
					return true
				end,
				sound = is_last_card and "mvan_thatFUCKINbirdthatihate" or "mvan_birdthatihate",
				message = is_last_card and "T H A T  F U C K I N '  B I R D  T H A T  I  H A T E." or nil
			}
		end
	end
}

SMODS.Joker {
	key = 'car',
	loc_txt = {
		name = 'Car',
		text = {
			"This Joker gains {C:blue}+#25#{} Chips and {C:red}+#10#{} Mult",
			"whenever any odds aren't triggered.",
			"{C:inactive}(Currently +#0# Chips and +#0# Mult.)"
		}
	},
	config = { extra = { chips = 25, mult = 10 } },
	rarity = 1,
	atlas = 'ModdedVanilla',
	pos = { x = 1, y = 1 },
	cost = 4,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			-- :get_id tests for the rank of the card. Other than 2-10, Jack is 11, Queen is 12, King is 13, and Ace is 14.
			if context.other_card:get_id() == 10 or context.other_card:get_id() == 4 then
				-- Specifically returning to context.other_card is fine with multiple values in a single return value, chips/mult are different from chip_mod and mult_mod, and automatically come with a message which plays in order of return.
				return {
					chips = card.ability.extra.chips,
					mult = card.ability.extra.mult,
					card = context.other_card
				}
			end
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
	key = 'stickman',
	loc_txt = {
		name = 'CAUTION',
		text = {
			"{C:attention,s:3}WET FUCKING FLOOR{}"
		}
	},
	-- This searches G.GAME.pool_flags to see if Gros Michel went extinct. If so, no longer shows up in the shop.
	no_pool_flag = 'gros_michel_extinct2',
	config = { extra = { mult = 15, odds = 6 } },
	rarity = 1,
	atlas = 'ModdedVanilla',
	pos = { x = 2, y = 1 },
	cost = 5,
	unlocked = true,
	discovered = true,
	-- Gros Michel is incompatible with the eternal sticker, so this makes sure it can't be eternal.
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end

		-- Checks to see if it's end of round, and if context.game_over is false.
		-- Also, not context.repetition ensures it doesn't get called during repetitions.
		if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			-- Another pseudorandom thing, randomly generates a decimal between 0 and 1, so effectively a random percentage.
			if pseudorandom('gros_michel2') < G.GAME.probabilities.normal / card.ability.extra.odds then
				-- This part plays the animation.
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				-- Sets the pool flag to true, meaning Gros Michel 2 doesn't spawn, and Cavendish 2 does.
				G.GAME.pool_flags.gros_michel_extinct2 = true
				return {
					message = 'Extinct!'
				}
			else
				return {
					message = 'Safe!'
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
						mult = - math.huge,
						colour = G.C.DARK_EDITION,
					}
				end
			end
		end,
	}



SMODS.Joker {
	key = 'breaking',
	loc_txt = {
		name = 'Breaking Banana',
		text = {
			"{X:mult,C:white} X#1# {} Mult",
			"{C:green}#2# in #3#{} chance this",
			"card is destroyed",
			"at end of round"
		}
	},
	-- This also searches G.GAME.pool_flags to see if Gros Michel went extinct. If so, enables the ability to show up in shop.
	yes_pool_flag = 'gros_michel_extinct2',
	config = { extra = { Xmult = 3, odds = 1000 } },
	rarity = 1,
	atlas = 'ModdedVanilla',
	pos = { x = 3, y = 1 },
	cost = 4,
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
				Xmult_mod = card.ability.extra.Xmult
			}
		end
		if context.end_of_round and context.game_over == false and not context.repetition and not context.blueprint then
			if pseudorandom('cavendish2') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = 'Extinct!'
				}
			else
				return {
					message = 'Safe!'
				}
			end
		end
	end
}

-- This joker needs a few extra functions to work as well, so keep reading after this joker too.
-- Thanks go to Aurewritten, John SMODS himself, for writing out this joker.
SMODS.Joker {
	key = 'deadcards',
	loc_txt = {
		name = 'PROPAGANDA',
		text = {
			"{C:attention,s:2}BORN TO DIE{}",
			"{X:mult,C:white}WORLD IS A FUCK{}",
			"{C:red,s:2}KILL EM ALL{}",
			"{X:dark_edition,C:white,s:1}I am trash man{}",
			"{s:3}129,428,256,212 DEAD COPS{}"
		}
	},
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	config = { extra = { chips = 0, chip_mod = 3 } },
	atlas = 'ModdedVanilla',
	pos = { x = 5, y = 0 },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chip_mod,
				localize(G.GAME.current_round.castle2_card.suit, 'suits_singular'), -- gets the localized name of the suit
				card.ability.extra.chips,
				colours = { G.C.SUITS[G.GAME.current_round.castle2_card.suit] } -- sets the colour of the text affected by `{V:1}`
			}
		}
	end,
	calculate = function(self, card, context)
		if
			context.discard and
			not context.other_card.debuff and
			context.other_card:is_suit(G.GAME.current_round.castle2_card.suit) and
			not context.blueprint
		then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.CHIPS,
				card = card
			}
		end
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
				chip_mod = card.ability.extra.chips,
				colour = G.C.CHIPS
			}
		end
	end
}

SMODS.Joker {
	key = 'fsociety',
	loc_txt = {
		name = 'MR. JOKER',
		text = {
			"{s:1}Are {C:attention,s:1}you{} a {C:green,s:1}1{} or a {C:green,s:1}0{}?",
			"{C:inactive}(Halves all of the prices of the items in the shop){}"
		}
	},
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	config = { extra = { chips = 0, chip_mod = 3 } },
	atlas = 'ModdedVanilla2',
	pos = { x = 5, y = 0 },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chip_mod,
				localize(G.GAME.current_round.castle2_card.suit, 'suits_singular'), -- gets the localized name of the suit
				card.ability.extra.chips,
				colours = { G.C.SUITS[G.GAME.current_round.castle2_card.suit] } -- sets the colour of the text affected by `{V:1}`
			}
		}
	end,
	calculate = function(self, card, context)
		if
			context.discard and
			not context.other_card.debuff and
			context.other_card:is_suit(G.GAME.current_round.castle2_card.suit) and
			not context.blueprint
		then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.CHIPS,
				card = card
			}
		end
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
				chip_mod = card.ability.extra.chips,
				colour = G.C.CHIPS
			}
		end
	end
}

SMODS.Joker {
	key = 'puzzles',
	loc_txt = {
		name = "{C:attention}I'd{} like to solve the {C:green}puzzle{}",
	},
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	config = { extra = { chips = 0, chip_mod = 3 } },
	atlas = 'ModdedVanilla3',
	pos = { x = 5, y = 0 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "ahead", set = "Other"}
		return {
			vars = {
				card.ability.extra.chip_mod,
				localize(G.GAME.current_round.castle2_card.suit, 'suits_singular'), -- gets the localized name of the suit
				card.ability.extra.chips,
				colours = { G.C.SUITS[G.GAME.current_round.castle2_card.suit] } -- sets the colour of the text affected by `{V:1}`
			}
		}
	end,
	calculate = function(self, card, context)
		if
			context.discard and
			not context.other_card.debuff and
			context.other_card:is_suit(G.GAME.current_round.castle2_card.suit) and
			not context.blueprint
		then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.CHIPS,
				card = card
			}
		end
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
				chip_mod = card.ability.extra.chips,
				colour = G.C.CHIPS
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
			"{C:inactive}There's no such thing as free will, {C:red}Kris.{}"
		}
	},
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	rarity = 2,
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
				sound = "mvan_snowgrave",
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
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			mults = {4, 44, 444, 4.444}
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

local igo = Game.init_game_object
function Game:init_game_object()
	local ret = igo(self)
	ret.current_round.castle2_card = { suit = 'Spades' }
	return ret
end

-- This is a part 2 of the above thing, to make the custom G.GAME variable change every round.
function SMODS.current_mod.reset_game_globals(run_start)
	-- The suit changes every round, so we use reset_game_globals to choose a suit.
	G.GAME.current_round.castle2_card = { suit = 'Spades' }
	local valid_castle_cards = {}
	for _, v in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(v) then -- Abstracted enhancement check for jokers being able to give cards additional enhancements
			valid_castle_cards[#valid_castle_cards + 1] = v
		end
	end
	if valid_castle_cards[1] then
		local castle_card = pseudorandom_element(valid_castle_cards, pseudoseed('2cas' .. G.GAME.round_resets.ante))
		G.GAME.current_round.castle2_card.suit = castle_card.base.suit
	end
end
