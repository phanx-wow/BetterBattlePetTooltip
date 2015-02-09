local _, private = ...

--	This table maps item IDs to species IDs for items that teach battle
-- pets. Blizzard obviously has some more efficient way to figure this
--	out since they show the collected count in the item tooltips, but
--	that info isn't exposed to the API, so a hardcoded map is required.

-- The contents of this file are released into the public domain.
-- Feel free to use this file, or the data it contains, in your addons!
-- Data compiled by Phanx. Credits appreciated but not required.

private.PetItemToSpecies = {
	[119434] = 1385, -- Albino Chimaeraling
	[119148] = 1571, -- Albino River Calf <= Indentured Albino River Calf
	[ 44822] =   74, -- Albino Snake
	[ 72042] =  331, -- Alliance Balloon
	[106240] = 1363, -- Alterac Brew-Pup <= Alterac Brandy
	[ 44984] =  212, -- Ammen Vale Lashling
	[117354] = 1531, -- Ancient Nest Guardian
	[ 11023] =   52, -- Ancona Chicken
	[ 93040] = 1155, -- Anubisath Idol
	[ 86563] =  836, -- Aqua Strider <= Hollow Reed
	[ 45022] =  216, -- Argent Gruntling
	[ 44998] =  214, -- Argent Squire
	[118516] = 1603, -- Argi
	[ 63398] =  272, -- Armadillo Pup
	[104156] = 1323, -- Ashleaf Spriteling
	[ 93035] = 1150, -- Ashstone Core <= Core of Hardened Ash
	[104157] = 1321, -- Azure Crane Chick
	[ 34535] =   57, -- Azure Whelpling
	[ 44819] =  202, -- Baby Blizzard Bear
	[ 32588] =  156, -- Bananas <= Banana Charm
	[ 90177] =  903, -- Baneling
	[ 10360] =   75, -- Black Kingsnake
	[  8491] =   42, -- Black Tabby Cat <= Cat Carrier (Black Tabby)
	[104158] = 1322, -- Blackfuse Bombling
	[116439] = 1517, -- Blazing Cindercrawler
	[ 98550] = 1248, -- Blossoming Ancient
	[ 54436] =  254, -- Blue Clockwork Rocket Bot
	[ 29958] =  145, -- Blue Dragonhawk Hatchling
	[ 65661] =  259, -- Blue Mini Jouster
	[ 29901] =  138, -- Blue Moth <= Blue Moth Egg
	[  8485] =   40, -- Bombay Cat <= Cat Carrier (Bombay)
	[119146] = 1458, -- Bone Wasp
	[104202] = 1343, -- Bonkers
	[ 71387] =  325, -- Brilliant Kaliri
	[118107] = 1540, -- Brilliant Spore
	[118675] = 1563, -- Bronze Whelpling <= Time-Locked Box
	[ 10394] =   70, -- Brown Prairie Dog <= Prairie Dog Whistle
	[ 29364] =  137, -- Brown Rabbit <= Brown Rabbit Crate
	[ 10361] =   77, -- Brown Snake
	[116403] = 1516, -- Bush Chicken <= Frightened Bush Chicken
	[ 46398] =  224, -- Calico Cat <= Cat Carrier (Calico Cat)
	[ 54810] =  255, -- Celestial Dragon
	[ 70099] =  316, -- Cenarion Hatchling
	[102145] = 1303, -- Chi-Chi, Hatchling of Chi-Ji
	[ 11110] =  646, -- Chicken <= Chicken Egg
	[ 89368] =  849, -- Chi-ji Kite
	[ 93038] = 1152, -- Chrominius <= Whistle of Chromatic Bone
	[ 35350] =  174, -- Chuck <= Chuck's Bucket
	[ 92707] = 1117, -- Cinder Kitten
	[ 93025] = 1142, -- Clock'em
	[ 64372] =  277, -- Clockwork Gnome
	[ 34425] =  191, -- Clockwork Rocket Bot
	[ 39898] =  197, -- Cobra Hatchling
	[  8496] =   47, -- Cockatiel <= Parrot Cage (Cockatiel)
	[ 97554] = 1232, -- Coilfang Stalker <= Dripping Strider Egg
	[ 49646] =  244, -- Core Hound Pup
	[ 93034] = 1149, -- Corefire Imp <= Blazing Rune
	[  8486] =   41, -- Cornish Rex Cat <= Cat Carrier (Cornish Rex)
	[ 60847] =  264, -- Crawling Claw
	[110721] = 1396, -- Crazy Carrot
	[ 71076] =  321, -- Creepy Crate
	[ 70160] =  318, -- Crimson Lasher
	[ 10392] =   78, -- Crimson Snake
	[118106] = 1537, -- Crimson Spore
	[  8499] =   58, -- Crimson Whelpling <= Tiny Crimson Whelpling
	[ 46545] =  225, -- Curious Oracle Hatchling
	[ 46544] =  226, -- Curious Wolvar Pup
	[116801] = 1521, -- Cursed Birman
	[104160] = 1329, -- Dandelion Frolicker
	[ 63138] =  270, -- Dark Phoenix Hatchling
	[ 10822] =   56, -- Dark Whelpling
	[ 73762] =  336, -- Darkmoon Balloon
	[ 74981] =  343, -- Darkmoon Cub
	[ 91040] = 1063, -- Darkmoon Eye
	[ 91031] = 1062, -- Darkmoon Glowfly
	[ 91003] = 1061, -- Darkmoon Hatchling
	[ 73764] =  330, -- Darkmoon Monkey
	[ 80008] =  848, -- Darkmoon Rabbit
	[ 73903] =  338, -- Darkmoon Tonk
	[ 73765] =  335, -- Darkmoon Turtle
	[ 73905] =  339, -- Darkmoon Zeppelin
	[ 48112] =  232, -- Darting Hatchling
	[104161] = 1330, -- Death Adder Hatchling
	[ 93037] = 1153, -- Death Talon Whelpguard <= Blackwing Banner
	[114968] = 1449, -- Deathwatch Hatchling
	[ 67418] =  294, -- Deathy <= Smoldering Murloc Egg
	[ 48114] =  233, -- Deviate Hatchling
	[ 60216] =  262, -- De-Weaponized Mechanical Companion
	[ 94573] = 1205, -- Direhorn Runt
	[ 20769] =  114, -- Disgusting Oozeling
	[118709] = 1564, -- Doom Bloom
	[119142] = 1450, -- Draenei Micro Defender
	[ 34493] =  169, -- Dragon Kite
	[109014] = 1386, -- Dread Hatchling
	[104162] = 1331, -- Droplet of Y'Shaarj
	[ 44970] =  205, -- Dun Morogh Cub
	[ 44973] =  207, -- Durotar Scorpion
	[ 32616] =  158, -- Egbert <= Egbert's Egg
	[113216] = 1426, -- Elekk Plushie
	[ 67282] =  293, -- Elementium Geode
	[ 44974] =  209, -- Elwynn Lamb
	[  8498] =   59, -- Emerald Whelpling <= Tiny Emerald Whelpling
	[ 44982] =  213, -- Enchanted Broom
	[ 67274] =  267, -- Enchanted Lantern
	[ 67308] =  267, -- Enchanted Lantern <= Formula: Enchanted Lantern
	[ 37298] =  180, -- Essence of Competition <= Competitor's Souvenir
	[ 38050] =  183, -- Ethereal Soul-Trader <= Soul-Trader Beacon
	[118921] = 1566, -- Everbloom Peachick
	[119170] = 1576, -- Eye of Observation
	[ 79744] =  348, -- Eye of the Legion
	[ 21301] =  119, -- Father Winter's Helper <= Green Helper Box
	[ 70908] =  319, -- Feline Familiar
	[ 85578] =  821, -- Feral Vermling
	[ 74611] =  342, -- Festival Lantern
	[ 76062] =  346, -- Fetish Shaman <= Fetish Shaman's Spear
	[ 97961] = 1245, -- Filthling <= Half-Empty Food Container
	[ 29960] =  146, -- Firefly <= Captured Firefly
	[118578] = 1545, -- Firewing
	[ 84105] =  847, -- Fishy
	[119149] = 1430, -- Forest Sproutling <= Captured Forest Sproutling
	[ 60955] =  266, -- Fossilized Hatchling
	[ 90898] =  278, -- Fox Kit [Alliance]
	[ 64403] =  278, -- Fox Kit [Drop]
	[ 90897] =  278, -- Fox Kit [Horde]
	[ 53641] =  253, -- Frigid Frostling <= Ice Chip
	[117380] = 1530, -- Frostwolf Ghostpup
	[119141] = 1542, -- Frostwolf Pup
	[ 39286] =  188, -- Frosty <= Frosty's Collar
	[117564] = 1471, -- Fruit Hunter
	[ 93032] = 1144, -- Fungal Abomination <= Blighted Spore
	[ 97821] = 1237, -- Gahz'rooki <= Gahz'rooki's Summoning Stone
	[113623] = 1442, -- Ghastly Kid <= Spectral Bell
	[ 39973] =  190, -- Ghostly Skull
	[ 93030] = 1143, -- Giant Bone Spider <= Dusty Clutch of Eggs
	[ 43698] =  193, -- Giant Sewer Rat
	[ 65662] =  260, -- Gold Mini Jouster
	[ 29953] =  142, -- Golden Dragonhawk Hatchling
	[ 34518] =  170, -- Golden Pig <= Golden Pig Coin
	[104163] = 1332, -- Gooey Sha-ling
	[  8500] =   68, -- Great Horned Owl
	[  8492] =   50, -- Green Wing Macaw <= Parrot Cage (Green Wing Macaw)
	[ 72134] =  333, -- Gregarious Grell <= Grell Moss
	[ 86564] =  834, -- Grinder <= Imbued Jade Fragment
	[118517] = 1602, -- Grommloc
	[ 46802] =  228, -- Grunty <= Heavy Murloc Egg
	[ 49662] =  245, -- Gryphon Hatchling
	[ 72068] =  311, -- Guardian Cub [BoE]
	[ 69847] =  311, -- Guardian Cub [BoP]
	[104291] = 1345, -- Gu'chi Swarmling <= Swarmling of Gu'chi
	[ 65364] =  282, -- Guild Herald [Alliance]
	[ 65363] =  283, -- Guild Herald [Horde]
	[ 65361] =  280, -- Guild Page [Alliance]
	[ 65362] =  281, -- Guild Page [Horde]
	[104169] = 1338, -- Gulp Froglet
	[ 48116] =  234, -- Gundrak Hatchling
	[ 22114] =  121, -- Gurky <= Pink Murloc Egg
	[ 93669] = 1174, -- Gusting Grimoire
	[ 93033] = 1147, -- Harbinger of Flame <= Mark of Flame
	[104295] = 1346, -- Harmonious Porcupette
	[118574] = 1544, -- Hatespark the Tiny
	[  8501] =   67, -- Hawk Owl
	[ 23713] =  130, -- Hippogryph Hatchling
	[ 86562] =  835, -- Hopling
	[ 72045] =  332, -- Horde Balloon
	[  8494] =   49, -- Hyacinth Macaw <= Parrot Cage (Hyacinth Macaw)
	[118207] = 1541, -- Hydraling
	[ 70140] =  317, -- Hyjal Bear Cub
	[ 90900] = 1039, -- Imperial Moth
	[ 90902] = 1040, -- Imperial Silkworm
	[111660] = 1387, -- Iron Starlette
	[ 88148] =  792, -- Jade Crane Chick
	[ 82774] =  845, -- Jade Owl
	[ 90470] =  845, -- Jade Owl <= Design: Jade Owl
	[ 89686] =  856, -- Jade Tentacle
	[104307] = 1348, -- Jadefire Spirit
	[104164] = 1333, -- Jademist Dancer
	[ 94835] = 1202, -- Ji-Kun Hatchling
	[ 19450] =  106, -- Jubling <= A Jubling's Tiny Home
	[120051] = 1597, -- Kaliri Hatchling
	[ 44738] =  199, -- Kirin Tor Familiar
	[104165] = 1334, -- Kovok
	[117404] =  115, -- Land Shark
	[ 68840] =  302, -- Landro's Lichling
	[ 67128] =  285, -- Landro's Lil' XT
	[117528] = 1533, -- Lanticore Spawnling
	[ 69251] =  307, -- Lashtail Hatchling
	[ 48118] =  235, -- Leaping Hatchling
	[ 69648] =  308, -- Legs
	[ 97556] = 1234, -- Lesser Voidcaller <= Crystal of the Void
	[112057] = 1412, -- Lifelike Mechanical Frostboar
	[118485] = 1412, -- Lifelike Mechanical Frostboar <= Schematic: Lifelike Mechanical Frostboar
	[ 15996] =   95, -- Lifelike Toad <= Lifelike Mechanical Toad
	[ 16044] =   95, -- Lifelike Toad <= Schematic: Lifelike Mechanical Toad
	[ 97548] = 1226, -- Lil' Bad Wolf <= Spiky Collar
	[103670] = 1320, -- Lil' Bling
	[ 62540] =  268, -- Lil' Deathwing
	[ 49693] =  249, -- Lil' K.T. <= Lil' Phylactery
	[110684] = 1395, -- Lil' Leftovers <= Leftovers
	[ 68385] =  297, -- Lil' Ragnaros
	[ 11826] =   86, -- Lil' Smoky
	[ 11827] =   86, -- Lil' Smoky <= Schematic: Lil' Smoky
	[ 71033] =  320, -- Lil' Tarecgosa
	[ 54847] =  256, -- Lil' XT
	[ 44841] =  203, -- Little Fawn <= Little Fawn's Salt Lick
	[ 97959] = 1243, -- Living Fluid <= Quivering Blob
	[ 94125] = 1177, -- Living Sandling
	[116155] = 1511, -- Lovebird Hatchling
	[ 32498] =  155, -- Lucky <= Fortune Coin
	[ 85871] =  671, -- Lucky Quilen Cub
	[ 73797] =  337, -- Lumpy <= Lump of Coal
	[ 74610] =  341, -- Lunar Lantern
	[ 30360] =  111, -- Lurky <= Lurky's Egg
	[ 46831] = 1351, -- Macabre Marionette
	[ 67275] =  292, -- Magic Lamp
	[ 67312] =  292, -- Magic Lamp <= Formula: Magic Lamp
	[ 27445] =  132, -- Magical Crawdad <= Magical Crawdad Box
	[ 29363] =  136, -- Mana Wyrmling
	[114834] = 1446, -- Meadowstomper Calf
	[111402] = 1403, -- Mechanical Axebeak
	[118484] = 1403, -- Mechanical Axebeak <= Schematic: Mechanical Axebeak
	[ 10398] =   83, -- Mechanical Chicken
	[ 87526] =  844, -- Mechanical Pandaren Dragonling
	[118741] = 1565, -- Mechanical Scorpid
	[119177] = 1565, -- Mechanical Scorpid <= Schematic: Mechanical Scorpid
	[  4401] =   39, -- Mechanical Squirrel <= Mechanical Squirrel Box
	[  4408] =   39, -- Mechanical Squirrel <= Schematic: Mechanical Squirrel Box
	[ 45002] =  215, -- Mechanopeep
	[ 97549] = 1227, -- Menagerie Custodian <= Instant Arcane Sanctum Security Kit
	[ 13584] =   93, -- Mini Diablo <= Diablo Stone
	[ 93041] = 1156, -- Mini Mindslayer <= Jewel of Maddening Whispers
	[ 56806] =  258, -- Mini Thor
	[ 39656] =  189, -- Mini Tyrael <= Tyrael's Hilt
	[ 31760] =  149, -- Miniwing
	[ 33993] =  165, -- Mojo
	[115301] = 1451, -- Molten Corgi
	[101570] = 1276, -- Moon Moon
	[108438] =  296, -- Moonkin Hatchling [Alliance]
	[ 68618] =  296, -- Moonkin Hatchling [Alliance]
	[108438] =  298, -- Moonkin Hatchling [Horde]
	[ 68619] =  298, -- Moonkin Hatchling [Horde]
	[ 94210] = 1198, -- Mountain Panda
	[ 93031] = 1145, -- Mr. Bigglesworth
	[ 41133] =  192, -- Mr. Chilly <= Unhatched Mr. Chilly
	[ 66076] =  286, -- Mr. Grubbs
	[ 23007] =  126, -- Mr. Wiggles <= Piglet's Collar
	[ 33818] =  164, -- Muckbreath <= Muckbreath's Bucket
	[ 44980] =  210, -- Mulgore Hatchling
	[ 71726] =  329, -- Murkablo <= Murky's Little Soulstone
	[106244] = 1364, -- Murkalot <= Murkalot's Flail
	[ 20651] = 1168, -- Murki <= Orange Murloc Egg
	[ 45180] =  217, -- Murkimus the Gladiator <= Murkimus' Little Spear
	[ 46892] =  217, -- Murkimus the Gladiator <= Murkimus' Tiny Spear
	[ 20371] =  107, -- Murky <= Blue Murloc Egg
	[116258] = 1514, -- Mystical Spring Bouquet
	[ 38628] =  186, -- Nether Ray Fry
	[ 97550] = 1228, -- Netherspace Abyssal <= Netherspace Portal-Stone
	[116815] = 1524, -- Netherspawn, Spawn of Netherspawn
	[ 25535] =  131, -- Netherwhelp <= Netherwhelp's Collar
	[ 68841] =  303, -- Nightsaber Cub
	[118595] = 1432, -- Nightshade Sproutling
	[ 71140] =  323, -- Nuts <= Nuts' Acorn
	[ 48120] =  236, -- Obsidian Hatchling
	[104166] = 1335, -- Ominous Flame
	[ 48527] =  240, -- Onyx Panther <= Enchanted Onyx
	[ 49362] =  243, -- Onyxian Whelpling
	[  8487] =   43, -- Orange Tabby Cat <= Cat Carrier (Orange Tabby)
	[118919] = 1495, -- Ore Eater <= Red Goren Egg
	[ 13583] =   92, -- Panda Cub <= Panda Collar
	[ 92799] = 1125, -- Pandaren Air Spirit
	[ 92800] = 1126, -- Pandaren Earth Spirit
	[ 92798] = 1124, -- Pandaren Fire Spirit
	[ 49665] =  248, -- Pandaren Monk
	[ 90173] =  868, -- Pandaren Water Spirit
	[ 68833] =  301, -- Panther Cub
	[ 32622] =  159, -- Peanut <= Elekk Training Collar
	[ 60869] =  265, -- Pebble
	[ 22235] =  122, -- Peddlefeet <= Truesilver Shafted Arrow
	[ 44723] =  198, -- Pengu <= Nurtured Penguin Egg
	[ 49912] =  250, -- Perky Pug
	[ 59597] =  261, -- Personal World Destroyer
	[ 11825] =   85, -- Pet Bombling
	[ 11828] =   85, -- Pet Bombling <= Schematic: Pet Bombling
	[ 35504] =  175, -- Phoenix Hatchling
	[ 97557] = 1235, -- Phoenix Hawk Hatchling <= Brilliant Phoenix Hawk Feather
	[ 94903] = 1204, -- Pierre
	[ 46707] =  166, -- Pint-Sized Pink Pachyderm
	[ 97555] = 1233, -- Pocket Reaver <= Tiny Fel Engine Key
	[ 22781] =  124, -- Poley <= Polar Bear Collar
	[ 89587] =  381, -- Porcupette
	[ 10394] =  386, -- Prairie Dog <= Prairie Dog Whistle
	[ 44721] =  196, -- Proto-Drake Whelp
	[ 69821] =  309, -- Pterrordax Hatchling
	[119467] = 1568, -- Puddle Terror
	[ 71624] =  328, -- Purple Puffer
	[120309] = 1543, -- Pygmy Cow <= Glass of Warm Milk
	[ 94574] = 1200, -- Pygmy Direhorn
	[100905] = 1256, -- Rascal-Bot
	[ 48122] =  237, -- Ravasaur Hatchling
	[ 48124] =  238, -- Razormaw Hatchling
	[ 48126] =  239, -- Razzashi Hatchling
	[ 85222] = 1042, -- Red Cricket
	[ 29956] =  143, -- Red Dragonhawk Hatchling
	[ 29902] =  139, -- Red Moth <= Red Moth Egg
	[ 94025] = 1176, -- Red Panda
	[ 34492] =  168, -- Rocket Chicken
	[104317] = 1349, -- Rotten Little Helper <= Rotten Helper Box
	[111866] = 1411, -- Royal Peacock
	[104159] = 1328, -- Ruby Droplet
	[ 63355] =  271, -- Rustberg Gull [Alliance]
	[ 64996] =  271, -- Rustberg Gull [Horde]
	[ 72153] =  665, -- Sand Scarab
	[ 82775] =  846, -- Sapphire Cub
	[ 90471] =  846, -- Sapphire Cub <= Design: Sapphire Cub
	[ 66073] =  289, -- Scooter the Snail <= Snail Shell
	[114919] = 1448, -- Sea Calf
	[ 73953] =  340, -- Sea Pony
	[ 34955] =  172, -- Searing Scorchling <= Scorched Stone
	[  8495] =   51, -- Senegal <= Parrot Cage (Senegal)
	[ 45606] =  218, -- Sen'jin Fetish
	[118923] = 1567, -- Sentinel's Companion
	[119431] = 1601, -- Servant of Demidos
	[ 46820] =  229, -- Shimmering Wyrmling
	[ 46821] =  229, -- Shimmering Wyrmling
	[ 69992] =  229, -- Shimmering Wyrmling
	[  8490] =   44, -- Siamese Cat <= Cat Carrier (Siamese)
	[ 29957] =  144, -- Silver Dragonhawk Hatchling
	[ 34519] =  171, -- Silver Pig <= Silver Pig Coin
	[  8488] =   45, -- Silver Tabby Cat <= Cat Carrier (Silver Tabby)
	[ 88147] =  820, -- Singing Cricket <= Singing Cricket Cage
	[ 66067] =  291, -- Singing Sunflower <= Brazie's Sunflower Seeds
	[ 33154] =  162, -- Sinister Squashling
	[104167] = 1336, -- Skunky Alemental
	[119150] = 1575, -- Sky Fry
	[104332] = 1350, -- Sky Lantern
	[115483] = 1467, -- Sky-Bo
	[ 12529] =   90, -- Smolderweb Hatchling <= Smolderweb Carrier
	[ 68673] =   90, -- Smolderweb Hatchling <= Smolderweb Egg
	[ 35349] =  173, -- Snarly <= Snarly's Bucket
	[  8497] =   72, -- Snowshoe Rabbit <= Rabbit Crate (Snowshoe)
	[ 94209] = 1197, -- Snowy Panda
	[ 94152] = 1183, -- Son of Animus
	[119143] = 1574, -- Son of Sethe <= the
	[ 78916] =  347, -- Soul of the Aspects
	[119328] = 1569, -- Soul of the Forge
	[119329] = 1569, -- Soul of the Forge <= Recipe: Soul of the Forge
	[ 94595] = 1201, -- Spawn of G'nathus
	[ 90953] = 1127, -- Spectral Cub
	[ 94190] = 1185, -- Spectral Porcupette
	[ 49343] =  242, -- Spectral Tiger Cub
	[ 23002] =  125, -- Speedy <= Turtle Box
	[104168] = 1337, -- Spineclaw Crab
	[ 37297] =  179, -- Spirit of Competition <= Gold Medallion
	[ 23083] =  128, -- Spirit of Summer <= Captured Flame
	[ 44794] =  200, -- Spring Rabbit <= Spring Rabbit's Foot
	[ 11474] =   87, -- Sprite Darter Hatchling <= Sprite Darter Egg
	[ 40653] =  160, -- Stinker <= Reeking Pet Carrier
	[ 93029] = 1146, -- Stitched Pup <= Gluth's Bone
	[116402] = 1515, -- Stonegrinder
	[118577] = 1546, -- Stormwing
	[116756] = 1518, -- Stout Alemental
	[ 44983] =  211, -- Strand Crawler
	[ 94191] = 1184, -- Stunted Direhorn
	[118598] = 1434, -- Sun Sproutling
	[119468] = 1570, -- Sunfire Kaliri
	[ 94208] = 1196, -- Sunfur Panda
	[ 94124] = 1178, -- Sunreaver Micro-Sentry
	[116064] = 1478, -- Syd the Squid
	[ 97553] = 1231, -- Tainted Waveling <= Tainted Core
	[ 44965] =  204, -- Teldrassil Sproutling
	[112699] = 1416, -- Teroclaw Hatchling
	[ 85220] =  650, -- Terrible Turnip
	[ 85513] =  802, -- Thundering Serpent Hatchling
	[ 39896] =  194, -- Tickbird Hatchling
	[ 97552] = 1230, -- Tideskipper <= Shell of Tide-Calling
	[ 94933] = 1207, -- Tiny Blue Carp
	[ 66080] =  287, -- Tiny Flamefly
	[ 85447] =  652, -- Tiny Goldfish
	[ 94934] = 1208, -- Tiny Green Carp
	[ 19055] =  757, -- Tiny Green Dragon <= Green Dragon Orb
	[ 94932] = 1206, -- Tiny Red Carp
	[ 19054] =  758, -- Tiny Red Dragon <= Red Dragon Orb
	[ 64494] =  279, -- Tiny Shale Spider
	[ 21309] =  117, -- Tiny Snowman <= Snowman Kit
	[ 34478] =  167, -- Tiny Sporebat
	[ 69991] =  167, -- Tiny Sporebat
	[ 94935] = 1209, -- Tiny White Carp
	[ 44971] =  206, -- Tirisfal Batling
	[ 97558] = 1236, -- Tito <= Tito's Basket
	[ 33816] =  163, -- Toothy <= Toothy's Bucket
	[ 50446] =  251, -- Toxic Wasteling
	[ 21277] =  116, -- Tranquil Mechanical Yeti
	[106256] = 1365, -- Treasure Goblin <= Treasure Goblin's Pack
	[ 11026] =   65, -- Tree Frog <= Tree Frog Box
	[120121] = 1605, -- Trunks
	[ 44810] =  525, -- Turkey <= Turkey Cage
	[ 49287] =  241, -- Tuskarr Kite
	[118104] = 1538, -- Umbrafen Spore
	[ 10393] =   55, -- Undercity Cockroach
	[ 93036] = 1151, -- Untamed Hatchling <= Unscathed Egg
	[ 38658] =  187, -- Vampiric Batling
	[120050] = 1596, -- Veilwatcher Hatchling
	[103637] = 1344, -- Vengeful Porcupette
	[ 89736] =  855, -- Venus
	[ 93039] = 1154, -- Viscidus Globule
	[ 97960] = 1244, -- Viscous Horror <= Dark Quivering Blob
	[ 69824] =  310, -- Voodoo Figurine
	[ 46767] =  227, -- Warbot <= Warbot Ignition Key
	[ 95621] =  227, -- Warbot <= Warbot Ignition Key
	[113558] = 1394, -- Weebomination
	[ 23015] =  127, -- Whiskers the Rat <= Rat Cage
	[  8489] =   46, -- White Kitten <= Cat Carrier (White Kitten)
	[ 29904] =  141, -- White Moth <= White Moth Egg
	[ 39899] =  195, -- White Tickbird Hatchling
	[116804] = 1523, -- Widget the Departed
	[ 32617] =  157, -- Willy <= Sleepy Willy
	[ 49663] =  246, -- Wind Rider Cub
	[ 21308] =  118, -- Winter Reindeer <= Jingling Bell
	[ 21305] =  120, -- Winter's Little Helper <= Red Helper Box
	[ 69239] =  306, -- Winterspring Cub
	[ 46325] =  220, -- Withers
	[ 32233] =  153, -- Wolpertinger <= Wolpertinger's Tankard
	[ 11027] =   64, -- Wood Frog <= Wood Frog Box
	[ 12264] =   89, -- Worg Pup <= Worg Carrier
	[101771] = 1266, -- Xu-Fu, Cub of Xuen
	[ 29903] =  140, -- Yellow Moth <= Yellow Moth Egg
	[102147] = 1304, -- Yu'la, Broodling of Yu'lon
	[ 89367] =  850, -- Yu'lon Kite
	[ 95422] = 1211, -- Zandalari Anklerender
	[ 95423] = 1212, -- Zandalari Footslasher
	[ 94126] = 1180, -- Zandalari Kneebiter
	[ 95424] = 1213, -- Zandalari Toenibbler
	[102146] = 1305, -- Zao, Calfling of Niuzao
	[ 13582] =   94, -- Zergling <= Zergling Leash
	[ 49664] =  247, -- Zipao Tiger <= Enchanted Purple Jade
	[113554] = 1428, -- Zomstrok
}