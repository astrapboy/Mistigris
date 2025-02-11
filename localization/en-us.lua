return {
    descriptions = {
        --- Decks
        Back={
            b_mstg_phdeck = {
                name="Placeholder Deck",
                text={
                    "Not for production! This deck is just",
                    "to test new features early on"
                }
            },
            b_mstg_root = {
                name="Root Deck",
                text={
                    "Before scoring, chips and mult",
                    "become their square roots"
                }
            }
        },
        --- Blinds
        Blind={
            bl_mstg_journey = {
                name = "The Journey",
                text = {
                    "Base hand score",
                    "must not be less",
                    "than previous"
                }
            }
        },
        Edition={},
        Enhanced={},
        --- Jokers
        Joker={
            --- Temporary Joker! Used for testing code and stuff
            j_mstg_allan = {
                name = 'Allan please add details',
                text = {
                    'Allan please add details'
                }
            },
            --- Common
            j_mstg_diminishingreturns = {
                name = 'Diminishing Returns',
                text = {
                    '{X:mult,C:white} X#1# {} Mult minus',
                    '{X:mult,C:white} X#2# {} Mult for each',
                    'card in played hand',
                }
            },
            j_mstg_peekingjoker = {
                name = 'Peeking Joker',
                text = {
                    '{C:mult}+#1#{} Mult if chips',
                    'scored are at least',
                    '{C:attention}#2#%{} of required chips',
                }
            },
            j_mstg_ninjajoker = {
                name = 'Ninja Joker',
                text = {
                    '{C:chips}+#1#{} Chips if chips',
                    'scored are less than',
                    '{C:attention}#2#%{} of required chips',
                }
            },
            j_mstg_timesheet = {
                name = 'Timesheet',
                text = {
                    'Earn {C:money}$#1#{} every time',
                    'a playing card is {C:attention}retriggered{}',
                }
            },
            --- Uncommon
            j_mstg_powerofthree= {
                name = 'Power of Three',
                text = {
                    '{X:mult,C:white} X#1# {} Mult for each',
                    'scored hand this run that',
                    'contains a multiple of {C:attention}#2#{}',
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
                }
            },
            j_mstg_boulder= {
                name = 'Boulder',
                text = {
                    '{C:attention}+#1#{} free {C:green}Reroll{} every',
                    'time you leave a shop',
                    'without {C:attention}rerolling.{}',
                    "{C:inactive}(Max of {C:green}#2#{C:inactive} Rerolls)",
                    "{C:inactive}(Currently {C:green}#3#{C:inactive} Rerolls)",
                }
            },
            j_mstg_comedian= {
                name = 'Comedian',
                text = {                   
                    "Retrigger",
                    "each played",
                    "{C:attention}#1#{}, {C:attention}#2#{}, {C:attention}#3#{}, or {C:attention}#4#{}",                }
            },
            --- Rare
            j_mstg_outcast = {
                name = 'Outcast',
                text = {
                    '{X:mult,C:white} X#1# {} Mult for every',
                    'hand played that includes a',
                    '{C:attention}non-scoring{} card, resets',
                    'if all cards score.',
                    '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)',
                }
            },
        },
        Other={},
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
        },
        high_scores={},
        labels={},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            k_mstg_credit_idea = {"Idea: #1#{}"},
            k_mstg_credit_art = {"Art: #1#{}"},
            k_mstg_credit_code = {"Code: #1#{}"}
        },
        v_text={},
    },
}