--[[
SELF-DESTRUCT CODE

add_event(function()
    play_sound("tarot1")
    card.T.r = -0.2
    card:juice_up(0.3, 0.4)
    card.states.drag.is = true
    card.children.center.pinch.x = true
    add_event(function() G.jokers:remove_card(self) card:remove() card = nil return true end, 0.3, nil, "after", false) end)
]]

-- Joker creation wrapper
--- Taken from Bunco and rewritten + simplified
create_joker = function(joker)
    -- Rarity conversion
    local rarities = {
        ['C'] = 1,
        ['U'] = 2,
        ['R'] = 3,
        ['L'] = 4,
    }
    
    joker.rarity = rarities[joker.rarity]
    
    -- Placeholder atlas
    if joker.atlas == nil then
        joker.atlas = "placeholder"
        joker.index = joker.rarity - 1
    end
    
    -- Get width of atlas (in Jokers)
    local width = atlas_collection[joker.atlas].width or 10

    -- Soul Sprite
    if joker.rarity == 'L' then
        -- Soul index is a separate variable used for Legendary jokers and Hologram
        joker.soul = get_coordinates(joker.soul_index, width)
    end

    if joker.credits ~= nil then
        joker.set_badges = function(self, card, badges)
            if joker.credits.idea ~= nil then
                badges[#badges+1] = create_badge(localize({type = "variable", key = "k_mstg_credit_idea", vars = {joker.credits.idea}}), HEX("867100FF"), G.C.WHITE, 0.8 )
            end

            if joker.credits.art ~= nil then
                badges[#badges+1] = create_badge(localize({type = "variable", key = "k_mstg_credit_art", vars = {joker.credits.art}}), HEX("860000FF"), G.C.WHITE, 0.8 )
            end

            if joker.credits.code ~= nil then
                badges[#badges+1] = create_badge(localize({type = "variable", key = "k_mstg_credit_code", vars = {joker.credits.code}}), HEX("00862eFF"), G.C.WHITE, 0.8 )
            end
        end
    end

    -- Index = where the Joker is on the atlas (from 0)
    joker.position = get_coordinates(joker.index, width)

    -- Auto-generate a key, if the Joker does not already have one assigned
    if joker.key == nil then
        joker.key = string.gsub(string.lower(joker.name), '%s', '_') -- Removes spaces and uppercase letters
    end
    
    -- Dependencies for mod-specific Jokers, i.e. Cryptid
    if joker.dependencies ~= nil then
        for _, v in ipairs(joker.dependencies) do
            -- If we can't find a dependency, don't make the Joker
            if next(SMODS.find_mod(v)) == nil then
                do return end
            end
        end
    end
    
    -- Create Joker
    SMODS.Joker {
        key = joker.key,

        atlas = joker.atlas,
        pos = joker.position,
        soul_pos = joker.soul,

        rarity = joker.rarity,
        cost = joker.cost,

        unlocked = joker.unlocked,
        check_for_unlock = joker.check_for_unlock,
        unlock_condition = joker.unlock_condition,
        discovered = false,

        blueprint_compat = joker.blueprint or false,
        eternal_compat = (joker.eternal == nil) or joker.eternal,
        perishable_compat = (joker.perishable == nil) or joker.perishable,

        process_loc_text = joker.process_loc_text,

        config = joker.config,
        loc_vars = joker.loc_vars,
        locked_loc_vars = joker.locked_vars,

        calculate = joker.calculate,
        update = joker.update,
        remove_from_deck = joker.remove,
        add_to_deck = joker.add,
        set_ability = joker.set_ability,
        set_sprites = joker.set_sprites,
        load = joker.load,
        in_pool = joker.custom_in_pool or pool,

        effect = joker.effect,
        set_badges = joker.set_badges
    }
end