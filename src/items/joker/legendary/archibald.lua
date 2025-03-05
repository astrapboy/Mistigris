-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

-- BASED ON https://en.wikipedia.org/wiki/Archibald_Armstrong

local enable = true

--- @type SMODS.Joker
local j = {
	key = "archibald",
	config = { extra = { ante = 1 } },
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return { vars = { stg.ante } }
	end,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	rarity = 4,
	in_pool = function()
		return false
	end,
	cost = 6,
	remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            local diff = card.ability.extra.ante - G.GAME.round_resets.blind_ante
            ease_ante(diff)
            print(diff)

            attention_text({
                scale = 1.4, text = localize('k_again_ex'), hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
            })

            if G.GAME.blind and G.GAME.blind.chips > to_big(1) then -- trashy code
                G.GAME.chips = G.GAME.blind.chips
                G.STATE = G.STATES.HAND_PLAYED
                G.STATE_COMPLETE = true
                end_round()
            end
        end
    end
}

return enable and j or nil
