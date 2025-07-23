--- @class balatro.Game
--- @field CHALLENGES balatro.Challenge[]

--- @class balatro.Challenge
--- Challenge name
--- @field name string
--- Challenge identifier
--- @field id string
--- Restrictions / modifications
--- @field rules balatro.Challenge.Rule
--- Staarting jokers for this challenge
--- @field jokers balatro.Challenge.Joker[]
--- Starting consumables for this challenge
--- @field consumeables balatro.Challenge.IdField[]
--- Starting vouchers for this challenge
--- @field vouchers balatro.Challenge.IdField[]
--- Deck to use for this challenge
--- @field deck balatro.Challenge.Deck
--- Bans cards, tags, or other
--- @field restrictions balatro.Challenge.Resrictions

--- @class balatro.Challenge.Joker
--- @field id string
--- @field eternal? boolean
--- @field edition SpecialEdition | nil
--- @field pinned? boolean

--- @class balatro.Challenge.Rule
--- @field custom balatro.Challenge.RuleCustom[]
--- @field modifiers balatro.Challenge.RuleModifier[]

--- @class balatro.Challenge.Deck
--- @field type 'Challenge Deck' | string
--- @field cards? balatro.Challenge.DeckCard[]

--- @class balatro.Challenge.DeckCard
--- @field s SuitChar
--- @field r RankChar
--- @field e? string Edition key

--- @class balatro.Challenge.Resrictions
--- @field banned_cards balatro.Challenge.IdField[]
--- @field banned_tags balatro.Challenge.IdField[]
--- @field banned_other balatro.Challenge.IdField[] Can be used to ban blinds

--- @class balatro.Challenge.IdField: table
--- @field id string

--- @class balatro.Challenge.RuleCustom
--- @field id balatro.Challenge.CustomRuleId
--- @field value? any

--- @class balatro.Challenge.RuleModifier
--- @field id balatro.Challenge.ModifierRuleId
--- @field value? any

--- @alias balatro.Challenge.CustomRuleId
--- All jokers are eternal
--- | "all_eternal"
--- Limits number of chips to current dollars
--- | "chips_dollar_cap"
--- Permanently debuff played card
--- | "debuff_played_cards"
--- Discarding reduces number of dollars.
--- Value must be number (dollars cost)
--- | "discard_cost"
--- Chance for the cards to be flipped when drawn.
--- Value must be number (`1/chance`), e.g.
--- specifying 4 will have 25% chance for drawn card to be flipped
--- | "flipped_cards"
--- Permanently increases price by 1 adter each card purchase
--- | "inflation"
--- Reduces hand size for every specified dollars.
--- Value must be number (dollars / reduced hand size), e.g.
--- specifying `5` will reduce handsize by 1 for every 5 dollars
--- | "minus_hand_size_per_X_dollar"
--- Does not gain extra dollars during cash out from hands remaining
--- | "no_extra_hand_money"
--- Does not gain interest for owned dollars
--- | "no_interest"
--- Blinds does not give reward
--- | "no_reward"
--- Disables reward for specific Blind.
--- Value must be "Small", "Big", or "Boss"
--- | "no_reward_specific"
--- Disables jokers in shop (sets rate to 0)
--- | "no_shop_jokers"
--- Sets all jokers to eternal after specific ante.
--- Value must be number (ante)
--- | "set_eternal_ante"
--- Sets joker size to 0 after specific ante.
--- Value must be number (ante)
--- | "set_joker_slots_ante"
--- | string

--- @alias balatro.Challenge.ModifierRuleId
--- | "dollars"
--- | "hand_size"
--- | "hands"
--- | "discards"
--- | "joker_slots"