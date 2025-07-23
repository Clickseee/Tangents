--- @meta

--- @type boolean?
_RELEASE_MODE = nil
--- @type boolean?
_DEMO = nil

--- @class WidthHeight
--- @field w number
--- @field h number

--- @class Position
--- @field x number
--- @field y number

--- @class MinMax
--- @field min number
--- @field max number

--- @class PositionAndSize: Position, WidthHeight

--- @class CardSuit<T>: { Spades: T, Hearts: T, Clubs: T, Diamonds: T}

--- @alias ColorHex [number, number, number, number]
--- @alias ColorHexRgb [number, number, number]

--- @alias Rank string | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' | '10' | 'Ace' | 'Jack' | 'King' | 'Queen'
--- @alias RankChar string | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' | 'T' | 'A' | 'J' | 'Q' | 'K'
--- @alias Suit string | 'Hearts' | 'Clubs' | 'Diamonds' | 'Spades'
--- @alias SuitChar string | 'H' | 'C' | 'D' | 'S'
--- @alias SpecialEdition string | 'foil' | 'holo' | 'polychrome' | 'negative'
--- @alias PokerHand string | 'Flush Five' | 'Flush House' | 'Five of a Kind' | 'Straight Flush' | 'Four of a Kind' | 'Full House' | 'Flush' | 'Straight' | 'Three of a Kind' | 'Two Pair' | 'Pair' | 'High Card'
--- @alias PokerHandRoyal string | PokerHand | 'Royal Flush'
--- @alias BlindType string | 'Small' | 'Big' | 'Boss'
--- @alias BlindState string | 'Current'  | 'Defeated'  | 'Select'  | 'Selected'  | 'Skipped'  | 'Upcoming'
--- @alias Sticker string | 'White' | 'Red' | 'Green' | 'Black' | 'Blue' | 'Purple' | 'Orange' | 'Gold'
--- @alias Seal string | 'Gold' | 'Red' | 'Blue' | 'Purple'

