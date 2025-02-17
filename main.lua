-- Required for unscoring cards
SMODS.optional_features.cardareas.unscored = true

-- Info about the mod (where it is on disk, what the prefix is, what the name is)
mod_path = SMODS.current_mod.path
mod_prefix = SMODS.current_mod.prefix
mod_name = SMODS.current_mod.name

-- Initialize table to store loaded files
loaded = {}

-- Loads all files in a particular folder
function load_folder(path, include_subfolders)
    local full_path = mod_path..path
    local files = NFS.getDirectoryItemsInfo(full_path)
    for i = 1, #files do
        local info = files[i]
        local file = path.."/"..info.name
        if info.type == "file" then
            if not loaded[file] then
                loaded[file] = true
                sendInfoMessage(mod_name..": Successfully loaded "..file.."!")
                assert(SMODS.load_file(file))()
            else
                sendInfoMessage(mod_name..": Tried to load "..file.." but file was already loaded!")
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