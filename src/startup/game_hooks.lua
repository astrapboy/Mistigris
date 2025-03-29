local mistiutils = require('mistiutils')

-- G Functions
local g_f_rs = G.FUNCS.reroll_shop
function G.FUNCS:reroll_shop(e)
    G.GAME.current_round.caught_reroll = false
    g_f_rs(self, e)
end

local g_f_ep = G.FUNCS.evaluate_play
function G.FUNCS:evaluate_play(e)
    g_f_ep(self, e)
    local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
    if not G.GAME.blind:debuff_hand(G.play.cards, poker_hands, text) then
        G.GAME.current_round.mstg_valid_hands = G.GAME.current_round.mstg_valid_hands + 1
    end
    G.GAME.current_round.mstg_used_hands[text] = G.GAME.current_round.mstg_used_hands[text] + 1
end

-- Game Functions
local gm_igo = Game.init_game_object
function Game:init_game_object()
    local ref = gm_igo(self)

    ref.mstg = {
        unique_jokers = {},
        unique_joker_tally = 0,
        joy_pin = false,
        resurrect = nil,
        valid_hands_played_this_round = 0
    }
    return ref
end

local gm_u = Game.update
function Game:update(dt)
    gm_u(self, dt)

    -- Shoutout to Breezebuilder for this next bit
    local cycle_speed = 1.3
    local sin_time = math.sin(self.TIMERS.REAL * cycle_speed)

    self.C.MISTIGRIS[1] = (sin_time * 0.5 + 0.5) * (1.00 - 0.50) + 0.50  -- r = 0.50 -> 1.00
    self.C.MISTIGRIS[2] = (sin_time * 0.5 + 0.5) * (0.65 - 0.00) + 0.00  -- g = 0.00 -> 0.65
    self.C.MISTIGRIS[3] = (sin_time * -0.5 + 0.5) * (0.50 - 0.00) + 0.00 -- b = 0.50 -> 0.00
end

-- Blind Functions
local bl_sb = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
    if not reset then
        self.mstg = {
            max_score = to_big(-math.huge)
        }
    end
    bl_sb(self, blind, reset, silent)
end

local bl_sv = Blind.save
function Blind:save()
    local blindTable = bl_sv(self)
    blindTable.mstg = self.mstg
    return blindTable
end

local bl_ld = Blind.load
function Blind:load(blindTable)
    self.mstg = blindTable.mstg
    bl_ld(self, blindTable)
end

-- Card Functions
local c_if = Card.is_face
function Card:is_face(from_boss)
    if next(SMODS.find_card("j_mstg_up_to_eleven")) and self:get_id() >= 10 then
        return true
    else
        return c_if(self, from_boss)
    end
end

local c_sd = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.ability.set == "Joker" then G.GAME.mstg.resurrect = self.config.center.key end
    c_sd(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

-- CardArea Functions
local ca_e = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    ca_e(self, card, location, stay_flipped)
    if self == G.jokers and not G.GAME.mstg.unique_jokers[card.config.center.key] then
        G.GAME.mstg.unique_jokers[card.config.center.key] = true
        G.GAME.mstg.unique_joker_tally = G.GAME.mstg.unique_joker_tally + 1
    end
end

local ca_r = CardArea.remove_card
function CardArea:remove_card(card, discarded_only)
    if self == G.jokers and card.config.center then
        G.GAME.mstg.resurrect = card.config.center.key
    else
        if self == G.jokers then
            G.GAME.mstg.resurrect = card.key
        end
    end
    return ca_r(self, card, discarded_only)
end

local ca_ac = CardArea.align_cards
function CardArea:align_cards()
    ca_ac(self)
    if G.GAME.mstg.joy_pin and self.config.type == 'joker' then
        table.sort(self.cards,
            function(a, b)
                if a.config.center.key == b.config.center.key then
                    return a.sort_id < b.sort_id
                else
                    return a.config.center.order < b.config.center.order
                end
            end)
    end
end

-- Global events hooks
local luh = level_up_hand
function level_up_hand(card, hand, instant, amount)
    luh(card, hand, instant, amount)
    if to_big(amount or 1) > to_big(0) then
        SMODS.calculate_context({ mstg_level_up_hand = true, mstg_level_up_hand_name = hand })
    end
end

local nr = new_round
function new_round()
    nr()

    G.GAME.current_round.mstg_valid_hands = 0
    G.GAME.current_round.mstg_used_hands = {}
    for k, v in pairs(G.GAME.hands) do
        G.GAME.current_round.mstg_used_hands[k] = 0
    end
end
