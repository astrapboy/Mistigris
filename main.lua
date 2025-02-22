-- Required for unscoring cards
SMODS.optional_features.cardareas.unscored = true

local mod_name = SMODS.current_mod.name
local mod_path = SMODS.current_mod.path

-- Initialize table to store loaded files
local loaded = {}

-- Loads all files in a particular folder
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

-- Dependencies need to be loaded first as they contain essential functions
load_folder("src/lib/deps", false)

-- Then we can load the rest of the code all at once
load_folder("src", true)
