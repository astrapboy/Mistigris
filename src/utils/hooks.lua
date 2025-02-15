-- Necessary for Weighted Dice
local base_end_round = end_round
end_round = function()
    base_end_round()
    G.GAME.probabilities.normal = G.GAME.probabilities.base_normal
end