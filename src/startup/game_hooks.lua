local mistiutils = require('mistiutils')

-- G Functions
local G_FUNCS_rerollshopRef = G.FUNCS.reroll_shop
G.FUNCS.reroll_shop = function(self, e)
	G.GAME.current_round.caught_reroll = false
	G_FUNCS_rerollshopRef(self, e)
end

-- Game Functions
local Game_igoRef = Game.init_game_object
Game.init_game_object = function(self)
	local ref = Game_igoRef(self)
	ref.probabilities.mstg_base_normal = 1
	ref.mstg = {
		unique_jokers = {},
		joy_pin = false,
		joker_pindexes = {},
	}
	return ref
end

local Game_updateRef = Game.update
Game.update = function(self, dt)
	Game_updateRef(self, dt)

	-- Shoutout to Breezebuilder for this next bit
	local cycle_speed = 1.3
	local sin_time = math.sin(self.TIMERS.REAL * cycle_speed)

	self.C.MISTIGRIS[1] = (sin_time * 0.5 + 0.5) * (1.00 - 0.50) + 0.50 -- r = 0.50 -> 1.00
	self.C.MISTIGRIS[2] = (sin_time * 0.5 + 0.5) * (0.65 - 0.00) + 0.00 -- g = 0.00 -> 0.65
	self.C.MISTIGRIS[3] = (sin_time * -0.5 + 0.5) * (0.50 - 0.00) + 0.00 -- b = 0.50 -> 0.00
end

local Card_isfaceRef = Card.is_face
Card.is_face = function(self, from_boss)
	if next(SMODS.find_card("j_mstg_up_to_eleven")) and self:get_id() >= 10 then
		return true
	else
		return Card_isfaceRef(self, from_boss)
	end
end

-- CardArea Functions
local CardArea_emplaceRef = CardArea.emplace
CardArea.emplace = function(self, card, location, stay_flipped)
	CardArea_emplaceRef(self, card, location, stay_flipped)
	if self == G.jokers then
		local k = card.config.center.key
		local o = card.config.center.order
		if G.GAME.mstg.unique_jokers[k] == nil then
			G.GAME.mstg.unique_jokers[k] = true
		end
		if G.GAME.mstg.joker_pindexes[k] == nil then
			G.GAME.mstg.joker_pindexes[k] = o
		end
	end
end

local CardArea_aligncardsRef = CardArea.align_cards
CardArea.align_cards = function(self)
	CardArea_aligncardsRef(self)
	if G.GAME.mstg.joy_pin and self.config.type == 'joker' then
		table.sort(self.cards,
			function(a, b)
				if a.config.center.key == b.config.center.key then
					return a.sort_id < b.sort_id
				else
					return (G.GAME.mstg.joker_pindexes[a.config.center.key] < G.GAME.mstg.joker_pindexes[b.config.center.key])
				end
			end)
	end
end
