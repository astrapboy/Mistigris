-- Required for unscoring cards
SMODS.optional_features.cardareas.unscored = true

local mod_name = SMODS.current_mod.name
local mod_path = SMODS.current_mod.path

SMODS.current_mod.badge_colour = G.C.MISTIGRIS

-- Talisman functions
to_big = to_big or function(x)
	return x
end
to_number = to_number or function(x)
	return x
end

-- #region Non-Joker loading
local loaded = {}

local function load_folder(path, include_subfolders)
	local full_path = mod_path .. path
	local files = NFS.getDirectoryItemsInfo(full_path)
	for i = 1, #files do
		local info = files[i]
		local file = path .. "/" .. info.name
		if info.type == "file" then
			if not loaded[file] then
				loaded[file] = true
				sendInfoMessage("Successfully loaded " .. file .. "!", mod_name)
				assert(SMODS.load_file(file), "Failed to load " .. file .. "!")()
			else
				sendInfoMessage("Tried to load " .. file .. " but file was already loaded!", mod_name)
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
load_folder("src/items", false)

-- #endregion

-- #region Joker loading
local joker_load_order = {
	-- #region Common
	[1] = {
		rarity = "common",
		jokers = {
			"diminishing_returns",
			"peeking",
			"ninja",
			"timesheet",
			"up_to_eleven",
			"sleepy",
			"awake",
			"paper_shredder",
			"jenga",
			"missing_poster"
		}
	},
	-- #endregion
	-- #region Uncommon
	[2] = {
		rarity = "uncommon",
		jokers = {
			"boulder",
			"comedian",
			"handyman",
			"banana_factory",
			"medusa",
			"tortoise",
			"sacrifice",
			"leaky_soda"
		}
	},
	-- #endregion
	-- #region Rare
	[3] = {
		rarity = "rare",
		jokers = {
			"outcast",
			"power_of_three",
			"plasma",
			"weighted_dice",
			"conscription",
			"scythe",
			"travel_miles",
			"great_red_spot",
			"unstable_atom",
			"ufo"
		}
	}
	-- #endregion
}

-- Loads all the jokers
local function load_jokers()
	for _, jokers in pairs(joker_load_order) do
		local jokers_path = "src/items/jokers/" .. jokers.rarity
		for i = 1, #jokers.jokers do
			local jonk = jokers.jokers[i]
			local j = assert(SMODS.load_file(jokers_path .. "/" .. jonk .. ".lua"), "Failed to load Joker " .. jonk .. "!")()
			if j then assert(SMODS.Joker(j), "Failed to create SMODS Joker " .. jonk .. "!") end
		end
	end
end

-- Now we load the Jonklers
load_jokers()
-- #endregion
