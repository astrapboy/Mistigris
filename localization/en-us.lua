return {
	descriptions = {
		--- Decks
		Back = {},
		--- Blinds
		Blind = {
			bl_mstg_journey = {
				name = "The Journey",
				text = {
					"Base hand score",
					"must not be less",
					"than previous",
				},
			}
		},
		Edition = {},
		Enhanced = {},
		--- Jokers
		Joker = {
			--- Temporary Joker! Used for testing code and stuff
			j_mstg_allan = {
				name = "Allan please add details",
				text = {
					"Allan please add details",
				},
			},
			--- Common
			j_mstg_diminishing_returns = {
				name = "Diminishing Returns",
				text = {
					"{X:mult,C:white} X#1# {} Mult minus",
					"{X:mult,C:white} X#2# {} Mult for each",
					"card in played hand",
				},
			},
			j_mstg_peeking = {
				name = "Peeking Joker",
				text = {
					"{C:mult}+#1#{} Mult if chips",
					"scored are less than",
					"{C:attention}#2#%{} of required chips",
				},
			},
			j_mstg_ninja = {
				name = "Ninja Joker",
				text = {
					"{C:chips}+#1#{} Chips if chips",
					"scored are less than",
					"{C:attention}#2#%{} of required chips",
				},
			},
			j_mstg_timesheet = {
				name = "Timesheet",
				text = {
					"Earn {C:money}$#1#{} every time",
					"a playing card is {C:attention}retriggered{}",
				},
			},
			j_mstg_up_to_eleven = {
				name = "Up To 11",
				text = {
					"{C:attention}10{}s and {C:attention}Aces{}",
					"are considered",
					"{C:attention}face{} cards",
				},
			},
			j_mstg_sleepy = {
				name = "Sleepy Joker",
				text = {
					"Stores {X:mult,C:white} X#1# {} Mult",
					"at the end of",
					"the round, sell",
					"to create",
					"{C:attention}#2#{}",
					"{C:inactive}(Will have {X:mult,C:white} X#3# {C:inactive} Mult)",
				},
			},
			j_mstg_awake = {
				name = "Awake Joker",
				text = {
					"{X:mult,C:white} X#1# {} Mult",
				},
			},
			j_mstg_paper_shredder = {
				name = "Paper Shredder",
				text = {
					"If a card is {C:attention}debuffed{},",
					"destroy it after scoring"
				},
			},
			j_mstg_missing_poster = {
				name = "Missing Poster",
				text = {
					"Each {C:attention}face card{} held in hand",
					"gives {C:mult}+#1#{} Mult if its suit",
					"is not part of the",
					"{C:attention}played hand{}"
				},
			},
			j_mstg_jenga = {
				name = "Jenga",
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:green}#2# in #3#{} chance to {C:attention}reset{}",
					"Add {C:mult}+#4#{} Mult and",
					"increase chance by {C:green}#5#{}",
					"before scoring"
				},
			},
			--- Uncommon
			j_mstg_boulder = {
				name = "Boulder",
				text = {
					"{C:attention}+#1#{} free {C:green}Reroll{} every",
					"time you leave a shop",
					"without {C:attention}rerolling{}",
					"{C:inactive}(Max of {C:green}#2#{C:inactive} Rerolls)",
					"{C:inactive}(Currently {C:green}#3#{C:inactive} Rerolls)",
				},
			},
			j_mstg_comedian = {
				name = "Comedian",
				text = {
					"Retrigger",
					"each played",
					"{C:attention}#1#{}, {C:attention}#2#{}, {C:attention}#3#{}, or {C:attention}#4#{}",
				},
			},
			j_mstg_handyman = {
				name = "Handyman",
				text = {
					"{X:mult,C:white} X#1# {} Mult if",
					"{C:attention}played hand{} matches",
					"example in the menu",
					"{C:inactive}(Includes non-scoring cards){}",
				},
			},
			j_mstg_banana_factory = {
				name = "Banana Factory",
				text = {
					"Guarantees a {C:attention}#1#{}",
					"in the next shop",
					"{C:inactive}(If not owned){}",
				},
			},
			j_mstg_medusa = {
				name = "Medusa",
				text = {
					"All played {C:attention}face{} cards",
					"become {C:attention}Stone Cards{}",
					"when scored",
				},
			},
			j_mstg_tortoise = {
				name = "Tortoise",
				text = {
					"Gains {X:mult,C:white} X#1# {} Mult every time",
					"a {C:attention}Blind{} is defeated with",
					"{C:attention}0 hands{} and {C:attention}0 discards{}",
					"remaining",
					"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
				},
			},
			j_mstg_sacrifice = {
				name = "Sacrifice",
				text = {
					"{X:mult,C:white} X#1# {} Mult",
					"{C:attention}Destroys{} another",
					"Joker if sold",
				},
			},
			j_mstg_leaky_soda = {
				name = "Leaky Soda",
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:mult}-#2#{} Mult every hand",
					"played",
					"{C:mult}+#3#{} Mult every hand",
					"remaining by the end",
					"of the round",
				},
			},
			--- Rare
			j_mstg_defaced = {
				name = "Defaced Joker",
				text = {
					"Converts {C:attention}first discarded{}",
					"hand of the round",
					"into {C:hearts}Hearts{}",
				},
			},
			j_mstg_outcast = {
				name = "Outcast",
				text = {
					"{X:mult,C:white} X#1# {} Mult for every",
					"hand played that includes a",
					"{C:attention}non-scoring{} card, resets",
					"if all cards score",
					"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
				},
			},
			j_mstg_power_of_three = {
				name = "Power of Three",
				text = {
					"{X:mult,C:white} X#1# {} Mult for each",
					"scored hand this run",
					"that contains a {C:attention}#2#{}",
					"{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
				},
			},
			j_mstg_plasma = {
				name = "Plasma Joker",
				text = {
					"Up to {X:mult,C:white} X#1# {} Mult",
					"depending on how balanced",
					"{C:chips}Chips{} and {C:mult}Mult{} are",
				},
			},
			j_mstg_weighted_dice = {
				name = "Weighted Dice",
				text = {
					"After {C:attention}Blind{} is selected,",
					"sell this Joker to {C:attention}guarantee",
					"{C:green}all probabilities{} until the",
					"end of the round",
				},
			},
			j_mstg_conscription = {
				name = "Conscription",
				text = {
					"When first hand is played,",
					"{C:attention}destroy{} all {C:attention}unscoring cards{}",
				},
			},
			j_mstg_scythe = {
				name = "Scythe",
				text = {
					"Creates {C:attention}Death{} if final",
					"hand of the round",
					"is a {C:attention}#1#{},",
					"poker hand changes at",
					"end of round",
					"{C:inactive}(Must have room){}",
				},
			},
			j_mstg_travel_miles = {
				name = "Travel Miles",
				text = {
					"{X:mult,C:white} X#1# {} Mult if you have",
					"obtained at least",
					"{C:attention}#2#{} unique Jokers",
					"this run",
					"{C:inactive}(Currently {C:attention}#3#{}){}",
				},
			},
			j_mstg_great_red_spot = {
				name = "Great Red Spot",
				text = {
					"When a {C:attention}#1#{} is played,",
					"remove {C:attention}#2#{} level from it",
					"and add {X:mult,C:white} X#3# {} Mult",
					"to this Joker",
					"{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)",
				}
			},
			j_mstg_unstable_atom = {
				name = "Unstable Atom",
				text = {
					"{C:green}#1# in #2#{} chance for {X:mult,C:white} X#3# {} Mult",
					"{C:green}#1# in #4#{} chance to",
					"{C:attention}self-destruct{}"
				},
			},
			j_mstg_ufo = {
				name = "UFO",
				text = {
					"{X:mult,C:white} X#1# {} Mult for every",
					"{C:attention}hand type{} that has",
					"{C:attention}never been played{}",
					"this run",
					"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
				},
			},
		},
		Other = {},
		Planet = {},
		Spectral = {},
		Stake = {},
		Tag = {},
		Tarot = {},
		Voucher = {},
	},
	misc = {
		achievement_descriptions = {},
		achievement_names = {},
		blind_states = {},
		challenge_names = {},
		collabs = {},
		dictionary = {
			k_mstg_rigged_ex = "Rigged!",
			k_mstg_stone_ex = "Stone!",
			k_mstg_wakeup_ex = "Wake Up!",
			k_mstg_nightmare_ex = "Nightmare!",
			k_mstg_decay_ex = "Decayed!"
		},
		high_scores = {},
		labels = {},
		poker_hand_descriptions = {},
		poker_hands = {},
		ranks = {},
		suits_plural = {},
		suits_singular = {},
		tutorial = {},
		v_dictionary = {},
		v_text = {},
	},
}
