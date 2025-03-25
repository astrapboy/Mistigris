-- #region Pre-Loading

-- Initialize mod object
MistigrisMod = SMODS.find_mod("mistigris")[1]
MistigrisMod.badge_colour = G.C.MISTIGRIS
MistigrisMod.optional_features = {
    retrigger_joker = true,
    post_trigger = true,
}

MistigrisMod.reset_game_globals = function(run_start)
    if run_start then
        G.GAME.probabilities.mstg_base_normal = 1
    end
end
MistigrisMod.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2 }
end

-- Talisman functions
to_big = to_big or function(x)
    return x
end
to_number = to_number or function(x)
    return x
end

-- #endregion
-- #region Non-Content loading
local loaded = {}

local function load_folder(path, include_subfolders)
    local full_path = MistigrisMod.path .. path
    local files = NFS.getDirectoryItemsInfo(full_path)
    for i = 1, #files do
        local info = files[i]
        local file = path .. "/" .. info.name
        if info.type == "file" then
            if not loaded[file] then
                loaded[file] = true
                sendInfoMessage("Successfully loaded " .. file .. "!", MistigrisMod.name)
                assert(SMODS.load_file(file), "Failed to load " .. file .. "!")()
            else
                sendInfoMessage("Tried to load " .. file .. " but file was already loaded!", MistigrisMod.name)
            end
        elseif info.type == "directory" and include_subfolders then
            load_folder(file, true)
        end
    end
end

-- Load up the startup functions
load_folder("src/startup", true)

-- Then literally everything else
load_folder("src", false)

-- #endregion
-- #region Content loading
local smods_content_path = "src/content/smods/"
local function load_smods_type(type, load_order, name_field, items_field)
    table.sort(load_order, function(a, b) return a.key < b.key end)
    for key, items in pairs(load_order) do
        local search = items[items_field] or items
        local path = smods_content_path .. string.lower(type) .. "/" .. (items[name_field] or "")
        for i = 1, #search do
            local item = search[i]
            local loaded_item = assert(SMODS.load_file(path .. "/" .. item .. ".lua"),
                "Failed to load " .. type .. " " .. item .. "!")()
            if loaded_item then assert(SMODS[type](loaded_item), "Failed to create SMODS " .. type .. " " .. item .. "!") end
        end
    end
end

local function load_smods_fieldless_type(type, load_order, name_field)
    for _, item in pairs(load_order) do
        local path = smods_content_path .. string.lower(type) .. "/" .. (name_field or "")
        local loaded_item = assert(SMODS.load_file(path .. "/" .. item .. ".lua"),
            "Failed to load " .. type .. " " .. item .. "!")()
        if loaded_item then assert(SMODS[type](loaded_item), "Failed to create SMODS " .. type .. " " .. item .. "!") end
    end
end


-- Comment out any Jokers you don't want
-- #region Joker Loading
local joker_load_order = {
    -- #region Common
    {
        key = 1,
        rarity = "common",
        jokers = {
            "diminishing_returns",
            "peeking",
            "timesheet",
            "up_to_eleven",
            "paper_shredder",
            "losing_ticket",
            "feral",
            "jenga",
            "sacrifice",
            "emergency",
            "wallflower",
            "diverse_portfolio",
            "aiko",
            "aiko_fu"
        }
    },
    -- #endregion
    -- #region Uncommon
    {
        key = 2,
        rarity = "uncommon",
        jokers = {
            "sleepy",
            "awake",
            "boulder",
            "comedian",
            "banana_factory",
            "medusa",
            "tortoise",
            "leaky_soda",
            "scythe",
            "cupid",
            "vortex",
            "rover",
            "briefcase",
            "ufo",
            "great_red_spot",
            "defaced",
            "missing_poster",
            "benign",
            "gauss",
            "plasma",
            "outcast",
            "sunk_cost",
            "know_your_worth",
            "hot_potato",
            "encore"
        }
    },
    -- #endregion
    -- #region Rare
    {
        key = 3,
        rarity = "rare",
        jokers = {
            "power_of_three",
            "weighted_dice",
            "conscription",
            "travel_miles",
            "augment",
            "unstable_atom",
            "invitation_letter",
            "resurrection"
        }
    },
    -- #endregion
    -- #region Legendary
    {
        key = 4,
        rarity = "legendary",
        jokers = {
            "archibald",
        }
    }
    -- #endregion
}

load_smods_type("Joker", joker_load_order, "rarity", "jokers")
--#endregion
-- #region Blind Loading
local blind_load_order = {
    "journey",
    "joy",
    "day",
    "yew",
    "elk",
    "birch"
}

load_smods_fieldless_type("Blind", blind_load_order)
-- #endregion
-- #region Deck Loading
local back_load_order = {
    "tribute",
    "zany",
    "plaid"
}

load_smods_fieldless_type("Back", back_load_order)
-- #endregion
-- #region Cross-Mod Content Loading
load_folder("src/content/sleeve", false)
-- #endregion
