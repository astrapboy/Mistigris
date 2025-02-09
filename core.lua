-- What files should be preloaded?
local preload = {
    --- Files in the base src directory
    [""] = {
        "decks",
        "atlas"
    },
    
    --- Joker Files
    ["jokers"] = {
        "common_jokers",
        "uncommon_jokers",
        "rare_jokers"
    },
}

-- Load all the prepared files
for type, collection in pairs(preload) do
    for _, file in ipairs(collection) do
        -- Certain functions are required by many files (including Jokers and including Not Jokers)
        -- so I store them all in one giant dependencies file
        SMODS.load_file('src/utils/general_dependencies.lua')()
        if type == "" then
            SMODS.load_file('src/'..file..'.lua')()
        else
            -- Load file with all Joker dependencies
            if type == "jokers" then
                SMODS.load_file('src/utils/joker_dependencies.lua')()
            end
            -- Now we can load all the other files
            SMODS.load_file('src/'..type..'/'..file..'.lua')()
        end
    end
end 