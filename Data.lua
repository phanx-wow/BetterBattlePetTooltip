--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	A World of Warcraft user interface addon
	Copyright (c) 2012 Phanx

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included README and LICENSE files for more information!
----------------------------------------------------------------------]]

local ADDON, private = ...

private.speciesFromItem = {
	---------------------------
	--	Bind-On-Equip Items  --
	---------------------------
	[29901] = 138, -- Blue Moth Egg -> Blue Moth
	[29364] = 137, -- Brown Rabbit Crate -> Brown Rabbit
	[23083] = 128, -- Captured Flame -> Spirit of Summer
	[29960] = 146, -- Captured Firefly -> Firefly
	[8491]  = 42,  -- Cat Carrier (Black Tabby) -> Black Tabby Cat
	[9485]  = 40,  -- Cat Carrier (Bombay) -> Bombay Cat
	[46398] = 224, -- Cat Carrier (Calico Cat) -> Calico Cat
	[8486]  = 41,  -- Cat Carrier (Cornish Rex) -> Cornish Rex Cat
	[8487]  = 43,  -- Cat Carrier (Orange Tabby) -> Orange Tabby Cat
	[8490]  = 44,  -- Cat Carrier (Siamese) -> Siamese Cat
	[8488]  = 45,  -- Cat Carrier (Silver Tabby) -> Silver Tabby Cat
	[8489]  = 46,  -- Cat Carrier (White Kitten) -> White Kitten
	[21301] = 119, -- Green Helper Box -> Father Winter's Helper
	[21308] = 118, -- Jingling Bell -> Winter Reindeer
	[4401]  = 39,  -- Mechanical Squirrel Box -> Mechanical Squirrel
	[8496]  = 47,  -- Parrot Cage (Cockatiel) -> Cockatiel
	[8492]  = 50,  -- Parrot Cage (Green Wing Macaw) -> Green Wing Macaw
	[8494]  = 49,  -- Parrot Cage (Hyacinth Macaw) -> Hyacinth Macaw
	[8495]  = 51,  -- Parrot Cage (Senegal) -> Senegal
	[10394] = 70,  -- Prairie Dog Whislte -> Brown Prairie Dog
	[8492]  = 72,  -- Rabbit Crate (Snowshoe) -> Snowshoe Rabbit
	[21305] = 120, -- Red Helper Box -> Winter's Little Helper
	[29902] = 139, -- Red Moth Egg -> Red Moth
	[21309] = 117, -- Snowman Kit -> Tiny Snowman
	[88147] = 820, -- Singing Cricket Cage -> Singing Cricket
	[44794] = 200, -- Spring Rabbit's Foot -> Spring Rabbit
	[8499]  = 58,  -- Tiny Crimson Whelpling -> Crimson Whelpling
	[8498]  = 59,  -- Tiny Emerald Whelpling -> Emerald Whelpling
	[11026] = 65,  -- Tree Frog Box -> Tree Frog
	[22236] = 122, -- Truesilver Shafted Arrow -> Peddlefeet
	[29904] = 141, -- White Moth Egg -> White Moth
	[11027] = 64,  -- Wood Frog Box -> Wood Frog
	[29903] = 140, -- Yellow Moth Egg -> Yellow Moth
}