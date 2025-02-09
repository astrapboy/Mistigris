-- All the atlases!
atlas_collection = {
    -- Placeholder Atlas
    ["placeholder"] = {
        -- Width (in Jokers)
        width = 5,
        path = "placeholders.png",
        px = 71,
        py = 95
    }
}

for key, atlas in pairs(atlas_collection) do
    SMODS.Atlas {
        key = key,
        path = atlas.path,
        px = atlas.px,
        py = atlas.py
    }
end