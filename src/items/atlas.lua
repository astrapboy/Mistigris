-- All the atlases!
atlas_collection = {
	-- Placeholder Atlas
	["placeholder"] = {
		path = "placeholders.png",
		px = 71,
		py = 95,
	},
	-- Main Joker atlas
	["jokers"] = {
		path = "jokers.png",
		px = 71,
		py = 95,
	},
	-- Main Blind atlas
	["blinds"] = {
		path = "blinds.png",
		px = 34,
		py = 34,
		atlas_table = 'ANIMATION_ATLAS',
		frames = 20
	},
}

for key, atlas in pairs(atlas_collection) do
	SMODS.Atlas({
		key = key,
		path = atlas.path,
		px = atlas.px,
		py = atlas.py,
	})
end