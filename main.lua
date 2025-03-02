-- #region Pre-Loading

-- Required for unscoring cards
SMODS.optional_features.cardareas.unscored = true

local mod_name = SMODS.current_mod.name
local mod_path = SMODS.current_mod.path

-- Custom badge
SMODS.current_mod.badge_colour = G.C.MISTIGRIS

-- Make description not white
SMODS.current_mod.description_loc_vars = function()
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
-- #region Content loading
local function load_smods_type(type, load_order, name_field, items_field)
	for _, items in pairs(load_order) do
		local path = "src/items/" .. string.lower(type) .. "/" .. (items[name_field] or "")
		for i = 1, #items[items_field] do
			local item = items[items_field][i]
			local loaded_item = assert(SMODS.load_file(path .. "/" .. item .. ".lua"),
				"Failed to load " .. type .. " " .. item .. "!")()
			if loaded_item then assert(SMODS[type](loaded_item), "Failed to create SMODS " .. type .. " " .. item .. "!") end
		end
	end
end

-- #region Joker Loading
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
			"losing_ticket",
			"feral",
			"missing_poster",
			"jenga",
			"sacrifice",
		}
	},
	-- #endregion
	-- #region Uncommon
	[2] = {
		rarity = "uncommon",
		jokers = {
			"boulder",
			"comedian",
			"banana_factory",
			"medusa",
			"tortoise",
			"leaky_soda",
			"scythe",
			"cupid",
			"vortex",
			"ufo",
			"great_red_spot",
			"defaced",
			"plasma",
			"outcast",
		}
	},
	-- #endregion
	-- #region Rare
	[3] = {
		rarity = "rare",
		jokers = {
			"power_of_three",
			"weighted_dice",
			"conscription",
			"travel_miles",
			"augment",
			"unstable_atom",
			"invitation_letter"
		}
	}
	-- #endregion
}

load_smods_type("Joker", joker_load_order, "rarity", "jokers")
--#endregion
-- #region Blind Loading
local blind_load_order = {
	[0] = {
		blinds = {
			"journey"
		}
	}
}

load_smods_type("Blind", blind_load_order, _, "blinds")
-- #endregion
-- #endregion
