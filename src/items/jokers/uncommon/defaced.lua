-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "defaced",
	config = { extra = { converted = false } },
	blueprint_compat = false,
	rarity = 2,
	cost = 7,
	calculate = function(self, card, context)
		if context.setting_blind then card.ability.extra.converted = false end
		if context.end_of_round and not context.blueprint and context.cardarea == G.hand and G.GAME.current_round.hands_played <= 1 and not card.ability.extra.converted then
			play_sound('tarot1')
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_active_ex") })

			card.ability.extra.converted = true
			for index = 1, #G.hand.cards do
				local percent = 1.15 - (index - 0.999) / (#G.hand.cards - 0.998) * 0.3
				local other_card = G.hand.cards[index]

				mistiutils.add_event(function()
					other_card:flip()
					play_sound('card1', percent)
					other_card:juice_up(0.3, 0.3)
					return true
				end, 0.15, nil, "after")

				mistiutils.add_event(function()
					other_card:change_suit("Hearts")
					return true
				end, 0.1, nil, "after")
			end

			for index = 1, #G.hand.cards do
				local percent = 0.85 + (index - 0.999) / (#G.hand.cards - 0.998) * 0.3
				local other_card = G.hand.cards[index]

				mistiutils.add_event(function()
					other_card:flip()
					play_sound('tarot2', percent, 0.6)
					other_card:juice_up(0.3, 0.3)
					return true
				end, 0.15, nil, "after")
			end
		end
	end
}

return enable and j or nil
