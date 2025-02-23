local igo = Game.init_game_object
Game.init_game_object = function(self)
	local ref = igo(self)
	ref.probabilities.mstg_base_normal = 1
	ref.mstg = {
		unique_jokers = {},
		first_joker = nil
	}
	return ref
end
