--- @class balatro.Localization
--- @field descriptions balatro.Loc.Desc
--- @field misc balatro.Loc.Misc

--- @class balatro.Game.Localization: balatro.Localization
--- @field quips_parsed table<string, balatro.Loc.ParsedEntry>
--- @field tutorial_parsed table<string, balatro.Loc.ParsedEntry>

--- @class balatro.Loc.Desc: { [string]: table<string, balatro.Loc.NameText> }
--- @field Back table<string, balatro.Loc.NameText>
--- @field Blind table<string, balatro.Loc.NameText>
--- @field Edition table<string, balatro.Loc.NameText>
--- @field Enhanced table<string, balatro.Loc.NameText>
--- @field Joker table<string, balatro.Loc.NameText>
--- @field Other table<string, balatro.Loc.NameText>
--- @field Planet table<string, balatro.Loc.NameText>
--- @field Spectral table<string, balatro.Loc.NameText>
--- @field Stake table<string, balatro.Loc.NameText>
--- @field Tag table<string, balatro.Loc.NameText>
--- @field Tarot table<string, balatro.Loc.NameText>
--- @field Voucher table<string, balatro.Loc.NameText>

--- @class balatro.Loc.Misc: { [string]: any }
--- @field achievement_descriptions table<string, string>
--- @field achievement_names table<string, string>
--- @field blind_states table<BlindState, string>
--- @field challenge_names table<string, string>
--- @field collabs CardSuit<table<string, string>>
--- @field dictionary table<string, string | string[]>
--- @field high_scores table<string, string>
--- @field labels table<string, string>
--- @field poker_hand_description table<PokerHandRoyal, string[]>
--- @field poker_hands table<PokerHandRoyal, string>
--- @field quips table<string, string[]>
--- @field ranks table<Rank, string>
--- @field suits_plural table<Suit, string>
--- @field suits_singular table<Suit, string>
--- @field tutorial table<string, string[]>
--- @field v_text table<string, string[]>
--- @field v_dictionary table<string, string | string[]>
--- @field v_text_parsed table<string, balatro.Loc.ParsedEntry>
--- @field v_dictionary_parsed table<string, balatro.Loc.ParsedEntry>

--- @class balatro.Loc.NameText
--- @field name string
--- @field name_parsed balatro.Loc.ParsedEntry
--- @field text string[]
--- @field text_parsed balatro.Loc.ParsedEntry

--- @class balatro.Loc.ParsedEntry: { [number]: balatro.Loc.Parsed[] }

--- @class balatro.Loc.Parsed
--- @field control table<string, string>
--- @field strings string[]

