-- Required for unscoring cards
SMODS.optional_features.cardareas.unscored = true

-- Where the mod is on disk
mod_path = SMODS.current_mod.path

-- Loads all files in a particular folder
function load_folder(path, include_subfolders)
    local full_path = mod_path..path
    local files = NFS.getDirectoryItemsInfo(full_path)
    for i = 1, #files do
        local info = files[i]
        local file = path.."/"..info.name
        if info.type == "file" then
            assert(SMODS.load_file(file))()
        elseif info.type == "directory" and include_subfolders then
            load_folder(file, true)
        end
    end
end

load_folder("src", true)