-- Dependencies are files that contain functions re-used across multiple files, so we want to grab them...
local dependencies = {
    'general_deps',
    'joker_deps'
}

-- ...and then load them before we do anything else.
for _, dep_file in ipairs(dependencies) do
    assert(SMODS.load_file('src/utils/dependencies/'..dep_file..'.lua'))()
end

-- Now that we have our dependencies, we can load whatever we want! Yay!
local preload = {
    --- Files in the base src directory
    [""] = {
        "decks",
        "atlas",
        "blinds"
    },
    
    --- Utilities (do not put dependencies here!)
    ["utils"] = {
        "hooks"
    },

    --- Joker Files
    ["jokers"] = {
        "common",
        "uncommon",
        "rare"
    },
}

-- Load all the prepared files
for type, collection in pairs(preload) do
    for _, file in ipairs(collection) do
        if type == "" then
            assert(SMODS.load_file('src/'..file..'.lua'))()
        else
            assert(SMODS.load_file('src/'..type..'/'..file..'.lua'))()
        end
    end
end

