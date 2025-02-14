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
        joker.x_index = joker.rarity-1
        joker.y_index = 0
    end
    
    -- One-indexed positioning
    joker.position = {x = joker.x_index, y = joker.y_index}
    
    -- Soul Sprite
    if joker.rarity == 'L' then
        joker.soul = {x = joker.soul_x_index, y = joker.soul_y_index}
    end

    add_credits(joker)

    -- Auto-generate a key, if the Joker does not already have one assigned
    if joker.key == nil and joker.name ~= nil then
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