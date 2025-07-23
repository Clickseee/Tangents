--- This assumed the profile is already initialized. If not, returns {}
--- @class balatro.Profile: { [string]: any }
--- @field name string
--- @field stake number
--- @field challenges_unlocked number
--- @field deck_stakes balatro.Profile.Tally
--- @field MEMORY balatro.Profile.Memory
---
--- @field career_stats balatro.Profile.CareerStats
--- @field progress balatro.Profile.Progress
--- @field voucher_usage table<string, balatro.Profile.Usage>
--- @field consumeable_usage table<string, balatro.Profile.Usage>
--- @field deck_usage table<string, balatro.Profile.UsageWinLoss>
--- @field joker_usage table<string, balatro.Profile.UsageWinLoss>
--- @field hand_usage table<string, balatro.Profile.Usage>
--- @field high_scores balatro.Profile.HighScores
--- @field challenge_progress balatro.Profile.ChallengeProgress

--- @class balatro.Profile.CareerStats: { [string]: number }
--- @field c_shop_dollars_spent number
--- @field c_playing_cards_bought number
--- @field c_losses number
--- @field c_shop_rerolls number
--- @field c_dollars_earned number
--- @field c_vouchers_bought number
--- @field c_tarot_reading_used number
--- @field c_rounds number
--- @field c_face_cards_played number
--- @field c_planetarium_used number
--- @field c_cards_sold number
--- @field c_cards_played number
--- @field c_round_interest_cap_streak number
--- @field c_cards_discarded number
--- @field c_hands_played number
--- @field c_single_hand_round_streak number
--- @field c_tarots_bought number
--- @field c_wins number
--- @field c_jokers_sold number
--- @field c_planets_bought number

--- @class balatro.Profile.Usage
--- @field count number
--- @field order number

--- @class balatro.Profile.HighScores: { [string]: balatro.Profile.HighScore }
--- @field furthest_round balatro.Profile.HighScore
--- @field furthest_ante balatro.Profile.HighScore
--- @field most_money balatro.Profile.HighScore
--- @field boss_streak balatro.Profile.HighScore
--- @field poker_hand balatro.Profile.HighScore
--- @field win_streak balatro.Profile.HighScore
--- @field collection balatro.Profile.HighScore
--- @field current_streak balatro.Profile.HighScore
--- @field hand balatro.Profile.HighScore

--- @class balatro.Profile.HighScore
--- @field amt number
--- @field tot? number
--- @field label string

--- @class balatro.Profile.UsageWinLoss: balatro.Profile.Usage
--- @field wins table<number, number> nth stake
--- @field losses table<number, number> nth stake

--- @class balatro.Profile.Progress: { [string]: any }
--- @field overall_tally number
--- @field overall_of number
--- @field challenges balatro.Profile.Tally
--- @field joker_stickers balatro.Profile.Tally
--- @field deck_stakes balatro.Profile.Tally
--- @field discovered balatro.Profile.Tally

--- @class balatro.Profile.Tally
--- @field count number
--- @field order number

--- @class balatro.Profile.Memory
--- @field deck string
--- @field stake number

--- @class balatro.Profile.ChallengeProgress
--- @field unlocked table<string, boolean> Unused
--- @field completed table<string, boolean>

--- @alias balatro.Profile.KnownHighScore string | "furthest_round" | "furthest_ante" | "most_money" | "boss_streak" | "poker_hand" | "win_streak" | "collection" | "current_streak" | "hand"
--- @alias balatro.Profile.KnownCareerStat string | "c_shop_dollars_spent" | "c_playing_cards_bought" | "c_losses" | "c_shop_rerolls" | "c_dollars_earned" | "c_vouchers_bought" | "c_tarot_reading_used" | "c_rounds" | "c_face_cards_played" | "c_planetarium_used" | "c_cards_sold" | "c_cards_played" | "c_round_interest_cap_streak" | "c_cards_discarded" | "c_hands_played" | "c_single_hand_round_streak" | "c_tarots_bought" | "c_wins" | "c_jokers_sold" | "c_planets_bought"