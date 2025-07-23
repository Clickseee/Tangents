--- @meta

function win_game() end
function end_round() end
function new_round() end

--- @class balatro.Global.Functions: balatro.Functions.StateEvents

--- @class balatro.Functions.StateEvents
--- Draws cards from `G.deck` to `G.hand`.
--- @field draw_from_deck_to_hand fun(count: number)
--- Discard cards from highlighted cards.
--- @field discard_cards_from_highlighted fun(_, hook)
--- Play cards from highlighted cards.
--- This will also evaluate playing cards.
--- @field play_cards_from_highlighted fun()
--- UNDOCUMENTED
--- @field evaluate_play fun()
--- Draws card from `G.play` to `G.discard`.
--- @field draw_from_play_to_discard fun()
--- Draws card from `G.play` to `G.hand`.
--- @field draw_from_play_to_hand fun(cards: balatro.Card[])
--- Draws cards from `G.discard` to `G.deck`.
--- @field draw_from_discard_to_deck fun()
--- Draws cards from `G.hand` to `G.deck`.
--- @field draw_from_hand_to_deck fun()
--- Draws cards from `G.hand` to `G.discard`.
--- @field draw_from_hand_to_discard fun()
--- Evaluates current round, triggers at the end of round.
--- Used for calculating cashouts.
--- @field evaluate_round fun()
--- UNDOCUMENTED
--- @field tutorial_controller fun()
--- UNDOCUMENTED
--- @field tutorial_part fun(_part)
local x = {}

--- Gets poker hands info from given card
--- @param cards balatro.Card[]
--- @return PokerHand|'NULL' pokerHand Poker hand string
--- @return string|'NULL' pokerHandText Localization text string for poker hand
--- @return balatro.PokerHandsEvalInfo pokerHandsTable
--- @return balatro.Card[] playingCards Card yo play
--- @return PokerHandRoyal|'NULL' displayHand Display hand. May be different from given string (e.g. Royal Flush)
function x.get_poker_hand_info(cards) end

--- @alias balatro.PokerHandsEvalInfo table<PokerHand, balatro.Card[][]> | { top: balatro.Card[][] }