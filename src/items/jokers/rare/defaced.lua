-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "defaced",
	config = { extra = { suit = "Hearts", converted = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { localize(card.ability.extra.suit, "suits_plural") } }
	end,
	blueprint_compat = false,
	rarity = 3,
	cost = 9,
	calculate = function(self, card, context)
		if context.setting_blind then card.ability.extra.converted = false end
		if context.pre_discard and not context.blueprint and G.GAME.current_round.discards_used <= 0 and not context.hook and not card.ability.extra.converted then
			play_sound('tarot1')
			card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_active_ex") })

			card.ability.extra.converted = true
			for index = 1, #context.full_hand do
				local percent = 1.15 - (index - 0.999) / (#context.full_hand - 0.998) * 0.3
				local other_card = context.full_hand[index]

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

			for index = 1, #context.full_hand do
				local percent = 0.85 + (index - 0.999) / (#context.full_hand - 0.998) * 0.3
				local other_card = context.full_hand[index]

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
