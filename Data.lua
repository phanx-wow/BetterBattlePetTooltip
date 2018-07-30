local _, private = ...

-- This table maps item IDs to species IDs for items that teach battle
-- pets. Blizzard obviously has some more efficient way to figure this
-- out since they show the collected count in the item tooltips, but
-- that info isn't exposed to the API, so a hardcoded map is required.

-- The contents of this file are released into the public domain.
-- Feel free to use this file, or the data it contains, in your addons!
-- Data compiled by Phanx. Credits appreciated but not required.

-- Last updated 2018-07-29 for Patch 8.0.1

private.PetItemToSpecies = {
	[163489] = 2403, -- Abyssal Eel
	[122106] = 1624, -- Abyssius <= Shard of Supremus
	[163506] = 2420, -- Accursed Hexxer
	[151828] = 2072, -- Ageless Bronze Drake
	[136910] = 1805, -- Alarm-o-Bot
	[142448] = 1984, -- Albino Buzzard
	[119434] = 1385, -- Albino Chimaeraling
	[119148] = 1571, -- Albino River Calf <= Indentured Albino River Calf
	[ 44822] =   74, -- Albino Snake
	[163650] = 2433, -- Aldrusian Sproutling
	[ 72042] =  331, -- Alliance Balloon
	[139775] = 1918, -- Alliance Enthusiast
	[106240] = 1363, -- Alterac Brew-Pup <= Alterac Brandy
	[152963] = 2093, -- Amalgam of Destruction
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
	[128690] = 1706, -- Ashmaw Cub
	[ 93035] = 1150, -- Ashstone Core <= Core of Hardened Ash
	[163555] = 2439, -- Azerite Puddle <= Drop of Azerite
	[163515] = 2429, -- Azeriti <= Shard of Azerite
	[104157] = 1321, -- Azure Crane Chick
	[ 34535] =   57, -- Azure Whelpling
	[162578] = 2352, -- Baa'l <= Baa'ls Darksign
	[ 44819] =  202, -- Baby Blizzard Bear
	[163859] = 2477, -- Baby Crawg
	[136919] = 1884, -- Baby Elderhorn
	[134047] = 1828, -- Baby Winston
	[147542] = 2047, -- Ban-Fu, Cub of Ban-Lu
	[ 32588] =  156, -- Bananas <= Banana Charm
	[ 90177] =  903, -- Baneling
	[163799] = 2456, -- Barnaby
	[163511] = 2425, -- Barnacled Hermit Crab
	[140934] = 1934, -- Benax
	[163494] = 2408, -- Bilefang Skitterer <= Wad of Spider Web
	[ 10360] =   75, -- Black Kingsnake
	[  8491] =   42, -- Black Tabby Cat <= Cat Carrier (Black Tabby)
	[104158] = 1322, -- Blackfuse Bombling
	[152975] = 2086, -- Blazehound <= Smoldering Treat
	[116439] = 1517, -- Blazing Cindercrawler
	[128478] = 1693, -- Blazing Firehawk
	[129188] = 1753, -- Bleakwater Jelly
	[142096] = 1965, -- Blightbreath <= Putricide's Alchemy Supplies
	[142095] = 1964, -- Blood Boil <= Remains of a Blood Beast
	[147539] = 2035, -- Bloodbrood Whelpling
	[163500] = 2414, -- Bloodfeaster Larva
	[163861] = 2476, -- Bloodfeaster Larva <= Undulating Blue Sac
	[163818] = 2451, -- Bloodstone Tunneler
	[127704] = 1577, -- Bloodthorn Hatchling
	[126925] = 1666, -- Blorp <= Blorp's Bubble
	[ 98550] = 1248, -- Blossoming Ancient
	[ 54436] =  254, -- Blue Clockwork Rocket Bot
	[ 29958] =  145, -- Blue Dragonhawk Hatchling
	[163508] = 2422, -- Blue Flitter <= Butterfly in a Jar
	[ 65661] =  259, -- Blue Mini Jouster
	[ 29901] =  138, -- Blue Moth <= Blue Moth Egg
	[  8485] =   40, -- Bombay Cat <= Cat Carrier (Bombay)
	[122532] = 1600, -- Bone Serpent
	[119146] = 1458, -- Bone Wasp
	[142094] = 1963, -- Boneshard <= Fragment of Frozen Bone
	[104202] = 1343, -- Bonkers
	[152970] = 2082, -- Bound Stream <= Lesser Circle of Binding
	[128424] = 1466, -- Brightpaw
	[ 71387] =  325, -- Brilliant Kaliri
	[118107] = 1540, -- Brilliant Spore
	[151829] = 2071, -- Bronze Proto-Whelp
	[118675] = 1563, -- Bronze Whelpling <= Time-Locked Box
	[129362] = 1777, -- Broot
	[ 10394] =   70, -- Brown Prairie Dog <= Prairie Dog Whistle
	[ 29364] =  137, -- Brown Rabbit <= Brown Rabbit Crate
	[ 10361] =   77, -- Brown Snake
	[163244] = 2402, -- Brutus
	[163974] = 2479, -- Bucketshell
	[163776] = 2442, -- Bumbles <= Large Honeycomb Cluster
	[116403] = 1516, -- Bush Chicken <= Frightened Bush Chicken
	[ 46398] =  224, -- Calico Cat <= Cat Carrier (Calico Cat)
	[163798] = 2455, -- Captain Nibs
	[163514] = 2428, -- Carnivorous Lasher <= Violent Looking Flower Pot
	[143754] = 1999, -- Cavern Moccasin
	[136923] = 1888, -- Celestial Calf
	[ 54810] =  255, -- Celestial Dragon
	[ 70099] =  316, -- Cenarion Hatchling
	[122114] = 1633, -- Chaos Pup <= Void Collar
	[102145] = 1303, -- Chi-Chi, Hatchling of Chi-Ji
	[ 89368] =  849, -- Chi-ji Kite
	[ 11110] =  646, -- Chicken <= Chicken Egg
	[163504] = 2418, -- Child of Jani
	[ 93038] = 1152, -- Chrominius <= Whistle of Chromatic Bone
	[ 35350] =  174, -- Chuck <= Chuck's Bucket
	[ 92707] = 1117, -- Cinder Kitten
	[127748] = 1662, -- Cinder Pup
	[152976] = 2087, -- Cinderweb Recluse <= Cinderweb Egg
	[ 93025] = 1142, -- Clock'em
	[ 64372] =  277, -- Clockwork Gnome
	[ 34425] =  191, -- Clockwork Rocket Bot
	[ 39898] =  197, -- Cobra Hatchling
	[  8496] =   47, -- Cockatiel <= Parrot Cage (Cockatiel)
	[ 97554] = 1232, -- Coilfang Stalker <= Dripping Strider Egg
	[163823] = 2457, -- Coldlight Surfrunner
	[ 49646] =  244, -- Core Hound Pup
	[ 93034] = 1149, -- Corefire Imp <= Blazing Rune
	[136925] = 1890, -- Corgi Pup
	[140320] = 1929, -- Corgnelius
	[163491] = 2405, -- Corlain Falcon <= Pristine Falcon Feather
	[  8486] =   41, -- Cornish Rex Cat <= Cat Carrier (Cornish Rex)
	[152980] = 2091, -- Corrupted Blood <= Elementium Back Plate
	[127749] = 1672, -- Corrupted Nest Guardian
	[163513] = 2427, -- Cou'pa
	[140672] = 1931, -- Court Scribe
	[143679] = 1997, -- Crackers
	[163805] = 2448, -- Craghoof Kid
	[ 60847] =  264, -- Crawling Claw
	[110721] = 1396, -- Crazy Carrot
	[142093] = 1962, -- Creeping Tentacle <= Wriggling Darkness
	[ 71076] =  321, -- Creepy Crate
	[163510] = 2424, -- Crimson Frog
	[ 70160] =  318, -- Crimson Lasher
	[ 10392] =   78, -- Crimson Snake
	[118106] = 1537, -- Crimson Spore
	[  8499] =   58, -- Crimson Whelpling <= Tiny Crimson Whelpling
	[129175] = 1752, -- Crispin
	[153026] = 2115, -- Cross Gazer
	[127868] = 1688, -- Crusher
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
	[156566] = 2157, -- Dart
	[ 48112] =  232, -- Darting Hatchling
	[ 60216] =  262, -- De-Weaponized Mechanical Companion
	[104161] = 1330, -- Death Adder Hatchling
	[ 93037] = 1153, -- Death Talon Whelpguard <= Blackwing Banner
	[163809] = 2464, -- Deathsting Scorpid
	[114968] = 1449, -- Deathwatch Hatchling
	[ 67418] =  294, -- Deathy <= Smoldering Murloc Egg
	[ 48114] =  233, -- Deviate Hatchling
	[151645] = 2001, -- Dibbler <= Model D1-BB-L3R
	[151633] = 2065, -- Dig Rat
	[151633] = 2065, -- Dig Rat
	[161080] = 2197, -- Direhorn Hatchling <= Intact Direhorn Egg
	[ 94573] = 1205, -- Direhorn Runt
	[152967] = 2079, -- Discarded Experiment <= Experiment-In-A-Jar
	[ 20769] =  114, -- Disgusting Oozeling
	[153054] = 2118, -- Docile Skyfin
	[118709] = 1564, -- Doom Bloom
	[119142] = 1450, -- Draenei Micro Defender
	[152974] = 2085, -- Drafty <= Breezy Essence
	[ 34493] =  169, -- Dragon Kite
	[109014] = 1386, -- Dread Hatchling
	[142083] = 1952, -- Dreadmaw <= Giant Worm Egg
	[163634] = 2431, -- Dreadtick Leecher
	[136902] = 1722, -- Dream Whelpling <= Toxic Whelpling
	[104162] = 1331, -- Droplet of Y'Shaarj
	[142098] = 1967, -- Drudge Ghoul <= Drudge Remains
	[163492] = 2406, -- Drustvar Piglet
	[ 44970] =  205, -- Dun Morogh Cub
	[ 44973] =  207, -- Durotar Scorpion
	[127703] = 1588, -- Dusty Sporewing
	[142380] = 1979, -- Dutiful Gruntling
	[142379] = 1978, -- Dutiful Squire
	[ 32616] =  158, -- Egbert <= Egbert's Egg
	[113216] = 1426, -- Elekk Plushie
	[ 67282] =  293, -- Elementium Geode
	[ 44974] =  209, -- Elwynn Lamb
	[  8498] =   59, -- Emerald Whelpling
	[129178] = 1720, -- Emmigosa
	[129217] = 1766, -- Empowered Manafiend <= Warm Arcane Crystal
	[129218] = 1765, -- Empyreal Manafiend <= Glittering Arcane Crystal
	[ 44982] =  213, -- Enchanted Broom
	[128533] = 1699, -- Enchanted Cauldron
	[128621] = 1699, -- Enchanted Cauldron <= Formula: Enchanted Cauldron
	[ 67274] =  267, -- Enchanted Lantern
	[ 67308] =  267, -- Enchanted Lantern <= Formula: Enchanted Lantern
	[128535] = 1701, -- Enchanted Pen
	[128623] = 1701, -- Enchanted Pen <= Formula: Enchanted Pen
	[152878] = 2201, -- Enchanted Tiki Mask
	[128534] = 1700, -- Enchanted Torch
	[128622] = 1700, -- Enchanted Torch <= Formula: Enchanted Torch
	[129216] = 1764, -- Energized Manafiend <= Vibrating Arcane Crystal
	[ 37298] =  180, -- Essence of Competition <= Competitor's Souvenir
	[ 38050] =  183, -- Ethereal Soul-Trader <= Soul-Trader Beacon
	[118921] = 1566, -- Everbloom Peachick
	[143756] = 1998, -- Everliving Spore
	[136899] = 1717, -- Extinguished Eye
	[136901] = 1719, -- Eye of Inquisition
	[119170] = 1576, -- Eye of Observation
	[ 79744] =  348, -- Eye of the Legion
	[152979] = 2090, -- Faceless Mindlasher <= Puddle of Black Liquid
	[152972] = 2083, -- Faceless Minion <= Twilight Summoning Portal
	[163806] = 2449, -- False Knucklebump
	[ 21301] =  119, -- Father Winter's Helper <= Green Helper Box
	[153045] = 2117, -- Fel Lasher
	[129760] = 1760, -- Fel Piglet
	[129205] = 1660, -- Fel Pup <= A Tiny Infernal Collar
	[153055] = 2119, -- Fel-Afflicted Skyfin
	[163924] = 1889, -- Felbat Pup
	[153040] = 2113, -- Felclaw Marsuul
	[ 70908] =  319, -- Feline Familiar
	[ 85578] =  821, -- Feral Vermling
	[ 74611] =  342, -- Festival Lantern
	[130168] = 1802, -- Fetid Waveling
	[ 76062] =  346, -- Fetish Shaman <= Fetish Shaman's Spear
	[ 97551] = 1229, -- Fiendish Imp <= Satyr Charm
	[ 97961] = 1245, -- Filthling <= Half-Empty Food Container
	[160704] = 2187, -- Filthy Slime <= Filthy Bucket
	[140316] = 1928, -- Firebat Pup
	[ 29960] =  146, -- Firefly <= Captured Firefly
	[118578] = 1545, -- Firewing
	[ 84105] =  847, -- Fishy
	[136898] = 1716, -- Fledgling Warden Owl
	[150742] = 2058, -- Foe Reaper 0.9 <= Pet Reaper 0.9
	[119149] = 1430, -- Forest Sproutling <= Captured Forest Sproutling
	[ 60955] =  266, -- Fossilized Hatchling
	[153057] = 2121, -- Fossorial Bile Larva
	[163690] = 2438, -- Foulfeather <= Plagued Egg
	[ 64403] =  278, -- Fox Kit [Drop]
	[ 90897] =  278, -- Fox Kit [Horde]
	[ 90898] =  278, -- Fox Kit [Alliance]
	[163711] = 2440, -- Fozling <= Shard of Fozruk
	[122107] = 1625, -- Fragment of Anger
	[122109] = 1627, -- Fragment of Desire
	[122108] = 1626, -- Fragment of Suffering
	[158077] = 2165, -- Francois <= Faberge Egg
	[163493] = 2407, -- Frenzied Cottontail <= Bloody Rabbit Fang
	[163509] = 2423, -- Freshwater Pincher
	[ 53641] =  253, -- Frigid Frostling <= Ice Chip
	[147540] = 2036, -- Frostbrood Whelpling
	[117380] = 1530, -- Frostwolf Ghostpup
	[119141] = 1542, -- Frostwolf Pup
	[ 39286] =  188, -- Frosty <= Frosty's Collar
	[117564] = 1471, -- Fruit Hunter
	[ 93032] = 1144, -- Fungal Abomination <= Blighted Spore
	[163648] = 2432, -- Fuzzy Creepling
	[142092] = 1961, -- G0-R41-0N Ultratonk <= Overcomplicated Controller
	[ 97821] = 1237, -- Gahz'rooki <= Gahz'rooki's Summoning Stone
	[163860] = 2474, -- Gearspring Hopper <= Wind-Up Frog
	[113623] = 1442, -- Ghastly Kid <= Spectral Bell
	[152555] = 2077, -- Ghost Shark
	[ 39973] =  190, -- Ghostly Skull
	[126926] = 1665, -- Ghostshell Crab <= Translucent Shell
	[ 93030] = 1143, -- Giant Bone Spider <= Dusty Clutch of Eggs
	[ 43698] =  193, -- Giant Sewer Rat
	[163811] = 2466, -- Giggling Flame
	[127701] = 1598, -- Glowing Sporebat
	[ 65662] =  260, -- Gold Mini Jouster
	[ 29953] =  142, -- Golden Dragonhawk Hatchling
	[ 34518] =  170, -- Golden Pig <= Golden Pig Coin
	[104163] = 1332, -- Gooey Sha-ling
	[153056] = 2120, -- Grasping Manifestation
	[  8500] =   68, -- Great Horned Owl
	[163495] = 2409, -- Greatwing Macaw <= Greatwing Macaw Feather
	[  8492] =   50, -- Green Wing Macaw <= Parrot Cage (Green Wing Macaw)
	[ 72134] =  333, -- Gregarious Grell <= Grell Moss
	[ 86564] =  834, -- Grinder <= Imbued Jade Fragment
	[118517] = 1602, -- Grommloc
	[122105] = 1622, -- Grotesque <= Grotesque Statue
	[128770] = 1725, -- Grumpling
	[128354] = 1705, -- Grumpy <= Grumpy's Leash
	[ 46802] =  228, -- Grunty <= Heavy Murloc Egg
	[ 49662] =  245, -- Gryphon Hatchling
	[104291] = 1345, -- Gu'chi Swarmling <= Swarmling of Gu'chi
	[160847] = 2190, -- Guardian Cobra Hatchling <= Snake Charmer's Flute
	[ 69847] =  311, -- Guardian Cub [BoP]
	[ 72068] =  311, -- Guardian Cub [BoE]
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
	[136900] = 1718, -- Hateful Eye
	[118574] = 1544, -- Hatespark the Tiny
	[  8501] =   67, -- Hawk Owl
	[163218] = 2003, -- Hearthy
	[ 23713] =  130, -- Hippogryph Hatchling
	[123862] = 1384, -- Hogs <= Hogs' Studded Collar
	[ 86562] =  835, -- Hopling
	[ 72045] =  332, -- Horde Balloon
	[139776] = 1919, -- Horde Fanatic
	[140261] = 1926, -- Hungering Claw
	[  8494] =   49, -- Hyacinth Macaw <= Parrot Cage (Hyacinth Macaw)
	[118207] = 1541, -- Hydraling
	[ 70140] =  317, -- Hyjal Bear Cub
	[122112] = 1631, -- Hyjal Wisp
	[141714] = 1949, -- Igneous Flameling
	[ 90900] = 1039, -- Imperial Moth
	[ 90902] = 1040, -- Imperial Silkworm
	[152978] = 2089, -- Infernal Pyreclaw <= Fandral's Pet Carrier
	[143953] = 2017, -- Infinite Hatchling
	[163802] = 2461, -- Inky
	[111660] = 1387, -- Iron Starlette
	[142087] = 1956, -- Ironbound Proto-Whelp <= Ironbound Collar
	[ 88148] =  792, -- Jade Crane Chick
	[ 82774] =  845, -- Jade Owl
	[ 90470] =  845, -- Jade Owl <= Design: Jade Owl
	[ 89686] =  856, -- Jade Tentacle
	[104307] = 1348, -- Jadefire Spirit
	[104164] = 1333, -- Jademist Dancer
	[ 94835] = 1202, -- Ji-Kun Hatchling
	[ 19450] =  106, -- Jubling <= A Jubling's Tiny Home
	[163821] = 2453, -- Juvenile Brineshell
	[122116] = 1635, -- K'ute <= Holy Chime
	[120051] = 1597, -- Kaliri Hatchling
	[163804] = 2447, -- Kindleweb Spiderling
	[ 44738] =  199, -- Kirin Tor Familiar
	[136911] = 1806, -- Knockoff Blingtron
	[104165] = 1334, -- Kovok
	[163822] = 2454, -- Kunchong Hatchling
	[140323] = 1930, -- Lagan
	[117404] =  115, -- Land Shark
	[ 68840] =  302, -- Landro's Lichling
	[ 67128] =  285, -- Landro's Lil' XT
	[117528] = 1533, -- Lanticore Spawnling
	[ 69251] =  307, -- Lashtail Hatchling
	[163812] = 2468, -- Laughing Stonekin
	[ 48118] =  235, -- Leaping Hatchling
	[127856] = 1687, -- Left Shark
	[ 69648] =  308, -- Legs
	[ 97556] = 1234, -- Lesser Voidcaller <= Crystal of the Void
	[122104] = 1623, -- Leviathan Hatchling <= Leviathan Egg
	[136914] = 1808, -- Leyline Broodling
	[112057] = 1412, -- Lifelike Mechanical Frostboar
	[118485] = 1412, -- Lifelike Mechanical Frostboar <= Schematic: Lifelike Mechanical Frostboar
	[ 15996] =   95, -- Lifelike Toad <= Lifelike Mechanical Toad
	[ 16044] =   95, -- Lifelike Toad <= Schematic: Lifelike Mechanical Toad
	[ 97548] = 1226, -- Lil' Bad Wolf <= Spiky Collar
	[163502] = 2416, -- Lil' Ben'fon
	[103670] = 1320, -- Lil' Bling
	[ 62540] =  268, -- Lil' Deathwing
	[ 49693] =  249, -- Lil' K.T. <= Lil' Phylactery
	[110684] = 1395, -- Lil' Leftovers <= Leftovers
	[ 68385] =  297, -- Lil' Ragnaros
	[163778] = 2443, -- Lil' Siege Tower
	[ 11826] =   86, -- Lil' Smoky
	[ 11827] =   86, -- Lil' Smoky <= Schematic: Lil' Smoky
	[ 71033] =  320, -- Lil' Tarecgosa
	[161016] = 2196, -- Lil' Tika
	[163779] = 2444, -- Lil' War Machine
	[ 54847] =  256, -- Lil' XT
	[ 44841] =  203, -- Little Fawn <= Little Fawn's Salt Lick
	[163815] = 2471, -- Littlehoof
	[ 97959] = 1243, -- Living Fluid <= Quivering Blob
	[ 94125] = 1177, -- Living Sandling
	[127705] = 1661, -- Lost Netherpup
	[163568] = 2430, -- Lost Platysaur
	[116155] = 1511, -- Lovebird Hatchling
	[ 32498] =  155, -- Lucky <= Fortune Coin
	[ 85871] =  671, -- Lucky Quilen Cub
	[ 73797] =  337, -- Lumpy <= Lump of Coal
	[ 74610] =  341, -- Lunar Lantern
	[139791] = 1922, -- Lurking Owl Kitten
	[ 30360] =  111, -- Lurky <= Lurky's Egg
	[ 46831] = 1351, -- Macabre Marionette
	[ 67275] =  292, -- Magic Lamp
	[ 67312] =  292, -- Magic Lamp <= Formula: Magic Lamp
	[ 27445] =  132, -- Magical Crawdad <= Magical Crawdad Box
	[142086] = 1955, -- Magma Rageling <= Red-Hot Coal
	[156721] = 2158, -- Mailemental
	[ 29363] =  136, -- Mana Wyrmling
	[114834] = 1446, -- Meadowstomper Calf
	[111402] = 1403, -- Mechanical Axebeak
	[118484] = 1403, -- Mechanical Axebeak <= Schematic: Mechanical Axebeak
	[ 10398] =   83, -- Mechanical Chicken
	[ 87526] =  844, -- Mechanical Pandaren Dragonling
	[163496] = 2410, -- Mechanical Prairie Dog <= Strange Looking Mechanical Squirrel
	[118741] = 1565, -- Mechanical Scorpid
	[119177] = 1565, -- Mechanical Scorpid <= Schematic: Mechanical Scorpid
	[  4401] =   39, -- Mechanical Squirrel <= Mechanical Squirrel Box
	[  4408] =   39, -- Mechanical Squirrel <= Schematic: Mechanical Squirrel Box
	[ 45002] =  215, -- Mechanopeep
	[ 97549] = 1227, -- Menagerie Custodian <= Instant Arcane Sanctum Security Kit
	[101426] =  666, -- Micronax <= Micronax Controller
	[161214] = 2202, -- Miimii <= Thousand Year Old Mummy Wraps
	[ 13584] =   93, -- Mini Diablo <= Diablo Stone
	[ 93041] = 1156, -- Mini Mindslayer <= Jewel of Maddening Whispers
	[ 56806] =  258, -- Mini Thor
	[ 39656] =  189, -- Mini Tyrael <= Tyrael's Hilt
	[151632] = 2064, -- Mining Monkey
	[ 31760] =  149, -- Miniwing
	[141893] = 1936, -- Mischief
	[163814] = 2467, -- Mischievous Zephyr
	[ 33993] =  165, -- Mojo
	[115301] = 1451, -- Molten Corgi
	[101570] = 1276, -- Moon Moon
	[ 68618] =  296, -- Moonkin Hatchling [Alliance]
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
	[128427] = 1454, -- Murkidan
	[ 45180] =  217, -- Murkimus the Gladiator <= Murkimus' Little Spear
	[ 46892] =  217, -- Murkimus the Gladiator <= Murkimus' Tiny Spear
	[ 20371] =  107, -- Murky <= Blue Murloc Egg
	[163820] = 2458, -- Muskflank Calfling
	[116258] = 1514, -- Mystical Spring Bouquet
	[151269] = 2002, -- Naxxy
	[142085] = 1954, -- Nerubian Swarmer <= Nerubian Relic
	[ 38628] =  186, -- Nether Ray Fry
	[ 97550] = 1228, -- Netherspace Abyssal <= Netherspace Portal-Stone
	[116815] = 1524, -- Netherspawn, Spawn of Netherspawn
	[ 25535] =  131, -- Netherwhelp <= Netherwhelp's Collar
	[128426] = 1691, -- Nibbles
	[127753] = 1664, -- Nightmare Bell
	[140741] = 1932, -- Nightmare Lasher
	[140761] = 1933, -- Nightmare Treant
	[136903] = 1723, -- Nightmare Whelpling
	[ 68841] =  303, -- Nightsaber Cub
	[118595] = 1432, -- Nightshade Sproutling
	[129878] = 1715, -- Nightwatch Swooper
	[141532] = 1943, -- Noblegarden Bunny
	[136897] = 1714, -- Northern Hawk Owl
	[129826] = 1727, -- Nursery Spider
	[ 71140] =  323, -- Nuts <= Nuts' Acorn
	[ 48120] =  236, -- Obsidian Hatchling
	[163801] = 2462, -- Octopode Fry
	[104166] = 1335, -- Ominous Flame
	[ 48527] =  240, -- Onyx Panther <= Enchanted Onyx
	[ 49362] =  243, -- Onyxian Whelpling
	[  8487] =   43, -- Orange Tabby Cat <= Cat Carrier (Orange Tabby)
	[118919] = 1495, -- Ore Eater <= Red Goren Egg
	[147841] = 2050, -- Orphaned Felbat
	[153027] = 2116, -- Orphaned Marsuul
	[ 13583] =   92, -- Panda Cub <= Panda Collar
	[ 92799] = 1125, -- Pandaren Air Spirit
	[ 92800] = 1126, -- Pandaren Earth Spirit
	[ 92798] = 1124, -- Pandaren Fire Spirit
	[ 49665] =  248, -- Pandaren Monk
	[ 90173] =  868, -- Pandaren Water Spirit
	[ 68833] =  301, -- Panther Cub
	[143954] = 2018, -- Paradox Spirit
	[ 32622] =  159, -- Peanut <= Elekk Training Collar
	[ 60869] =  265, -- Pebble
	[ 22235] =  122, -- Peddlefeet <= Truesilver Shafted Arrow
	[ 44723] =  198, -- Pengu <= Nurtured Penguin Egg
	[127754] = 1663, -- Periwinkle Calf
	[ 49912] =  250, -- Perky Pug
	[ 59597] =  261, -- Personal World Destroyer
	[ 11825] =   85, -- Pet Bombling
	[ 11828] =   85, -- Pet Bombling <= Schematic: Pet Bombling
	[ 35504] =  175, -- Phoenix Hatchling
	[ 97557] = 1235, -- Phoenix Hawk Hatchling <= Brilliant Phoenix Hawk Feather
	[ 94903] = 1204, -- Pierre
	[ 46707] =  166, -- Pint-Sized Pink Pachyderm
	[163813] = 2465, -- Playful Frostkin
	[129798] = 1755, -- Plump Jelly
	[150739] = 2041, -- Pocket Cannon
	[150739] = 2041, -- Pocket Cannon
	[ 97555] = 1233, -- Pocket Reaver <= Tiny Fel Engine Key
	[158464] = 2188, -- Poda
	[ 22781] =  124, -- Poley <= Polar Bear Collar
	[ 89587] =  381, -- Porcupette
	[163800] = 2452, -- Poro
	[ 44721] =  196, -- Proto-Drake Whelp
	[ 69821] =  309, -- Pterrordax Hatchling
	[119467] = 1568, -- Puddle Terror
	[ 71624] =  328, -- Purple Puffer
	[120309] = 1543, -- Pygmy Cow <= Glass of Warm Milk
	[ 94574] = 1200, -- Pygmy Direhorn
	[130154] = 1907, -- Pygmy Owl
	[122125] = 1636, -- Race MiniZep <= Race MiniZep Controller
	[163689] = 2437, -- Ragepeep <= Angry Egg
	[163503] = 2417, -- Ranishu Runt
	[100905] = 1256, -- Rascal-Bot
	[152968] = 2080, -- Rattlejaw <= Shadowy Pile of Bones
	[ 48122] =  237, -- Ravasaur Hatchling
	[ 48124] =  238, -- Razormaw Hatchling
	[ 48126] =  239, -- Razzashi Hatchling
	[153252] = 2135, -- Rebellious Imp
	[ 85222] = 1042, -- Red Cricket
	[ 29956] =  143, -- Red Dragonhawk Hatchling
	[ 29902] =  139, -- Red Moth <= Red Moth Egg
	[ 94025] = 1176, -- Red Panda
	[141352] = 1938, -- Rescued Fawn
	[161089] = 2199, -- Restored Revenant <= Pile of Bones
	[136905] = 1756, -- Ridgeback Piglet
	[130166] = 1804, -- Risen Saber Kitten
	[140274] = 1453, -- River Calf
	[ 34492] =  168, -- Rocket Chicken
	[163220] = 2401, -- Rooter
	[104317] = 1349, -- Rotten Little Helper <= Rotten Helper Box
	[111866] = 1411, -- Royal Peachick <= Royal Peacock
	[104159] = 1328, -- Ruby Droplet
	[142088] = 1957, -- Runeforged Servitor <= Stormforged Rune
	[ 63355] =  271, -- Rustberg Gull [Alliance]
	[ 64996] =  271, -- Rustberg Gull [Horde]
	[142089] = 1958, -- Sanctum Cub <= Glittering Ball of Yarn
	[ 72153] =  665, -- Sand Scarab
	[163808] = 2463, -- Sandshell Chitterer
	[163512] = 2426, -- Sandstinger Wasp
	[ 82775] =  846, -- Sapphire Cub
	[ 90471] =  846, -- Sapphire Cub <= Design: Sapphire Cub
	[163560] = 2421, -- Saurolisk Hatchling
	[128477] = 1692, -- Savage Cub
	[163684] = 2436, -- Scabby
	[ 66073] =  289, -- Scooter the Snail <= Snail Shell
	[146953] = 2042, -- Scraps
	[163797] = 2445, -- Scuttle
	[114919] = 1448, -- Sea Calf
	[ 73953] =  340, -- Sea Pony
	[118105] = 1539, -- Seaborne Spore
	[163490] = 2404, -- Seabreeze Bumblebee <= Pair of Bee Wings
	[ 34955] =  172, -- Searing Scorchling <= Scorched Stone
	[ 45606] =  218, -- Sen'jin Fetish
	[  8495] =   51, -- Senegal <= Parrot Cage (Senegal)
	[118923] = 1567, -- Sentinel's Companion
	[119431] = 1601, -- Servant of Demidos
	[136904] = 1754, -- Sewer-Pipe Jelly
	[151234] = 2062, -- Shadow
	[151234] = 2062, -- Shadow
	[128309] = 1690, -- Shard of Cyrukh
	[ 46820] =  229, -- Shimmering Wyrmling
	[ 46821] =  229, -- Shimmering Wyrmling
	[ 69992] =  229, -- Shimmering Wyrmling
	[  8490] =   44, -- Siamese Cat <= Cat Carrier (Siamese)
	[156851] = 2163, -- Silithid Mini-Tank
	[ 29957] =  144, -- Silver Dragonhawk Hatchling
	[ 34519] =  171, -- Silver Pig <= Silver Pig Coin
	[  8488] =   45, -- Silver Tabby Cat <= Cat Carrier (Silver Tabby)
	[ 88147] =  820, -- Singing Cricket <= Singing Cricket Cage
	[ 66067] =  291, -- Singing Sunflower <= Brazie's Sunflower Seeds
	[ 33154] =  162, -- Sinister Squashling
	[163975] = 2478, -- Sir Snips
	[122110] = 1628, -- Sister of Temptation <= Sultry Grimoire
	[104167] = 1336, -- Skunky Alemental
	[119150] = 1575, -- Sky Fry
	[104332] = 1350, -- Sky Lantern
	[115483] = 1467, -- Sky-Bo
	[129277] = 1711, -- Skyhorn Nestling
	[163858] = 2475, -- Slippy <= Ball of Tentacles
	[122534] = 1655, -- Slithershock Elver
	[ 12529] =   90, -- Smolderweb Hatchling <= Smolderweb Carrier
	[ 68673] =   90, -- Smolderweb Hatchling <= Smolderweb Egg
	[160708] = 2189, -- Smoochums <= Smoochums' Bloody Heart
	[142091] = 1960, -- Snaplasher <= Blessed Seed
	[163816] = 2472, -- Snapper
	[ 35349] =  173, -- Snarly <= Snarly's Bucket
	[151569] = 2063, -- Sneaky Marmot
	[142084] = 1953, -- Snobold Runt <= Magnataur Hunting Horn
	[163819] = 2459, -- Snort
	[141530] = 1941, -- Snowfang <= Snowfang's Trust
	[  8497] =   72, -- Snowshoe Rabbit <= Rabbit Crate (Snowshoe)
	[ 94209] = 1197, -- Snowy Panda
	[ 94152] = 1183, -- Son of Animus
	[119143] = 1574, -- Son of Sethe
	[147543] = 2049, -- Son of Skum
	[ 78916] =  347, -- Soul of the Aspects
	[119328] = 1569, -- Soul of the Forge
	[119329] = 1569, -- Soul of the Forge <= Recipe: Soul of the Forge
	[142097] = 1966, -- Soulbroken Whelpling <= Skull of a Frozen Whelp
	[163803] = 2446, -- Sparkleshell Sandcrawler
	[ 94595] = 1201, -- Spawn of G'nathus
	[160702] = 2186, -- Spawn of Merektha
	[ 90953] = 1127, -- Spectral Cub
	[ 94190] = 1185, -- Spectral Porcupette
	[ 49343] =  242, -- Spectral Tiger Cub
	[ 23002] =  125, -- Speedy <= Turtle Box
	[104168] = 1337, -- Spineclaw Crab
	[ 37297] =  179, -- Spirit of Competition <= Gold Medallion
	[ 23083] =  128, -- Spirit of Summer <= Captured Flame
	[ 44794] =  200, -- Spring Rabbit <= Spring Rabbit's Foot
	[ 11474] =   87, -- Sprite Darter Hatchling <= Sprite Darter Egg
	[163712] = 2441, -- Squawkling <= Mana-Warped Egg
	[141316] = 1935, -- Squirky <= Odd Murloc Egg
	[142100] = 1969, -- Stardust
	[138810] = 1911, -- Sting Ray Pup
	[ 40653] =  160, -- Stinker <= Reeking Pet Carrier
	[122111] = 1629, -- Stinkrot <= Smelly Gravestone
	[ 93029] = 1146, -- Stitched Pup <= Gluth's Bone
	[116402] = 1515, -- Stonegrinder
	[129208] = 1721, -- Stormborne Whelpling
	[118577] = 1546, -- Stormwing
	[116756] = 1518, -- Stout Alemental
	[ 44983] =  211, -- Strand Crawler
	[ 94191] = 1184, -- Stunted Direhorn
	[142223] =  382, -- Sun Darter Hatchling
	[118598] = 1434, -- Sun Sproutling
	[122113] = 1632, -- Sunblade Micro-Defender <= Sunblade Rune of Activation
	[136920] = 1885, -- Sunborne Val'kyr
	[119468] = 1570, -- Sunfire Kaliri
	[ 94208] = 1196, -- Sunfur Panda
	[ 94124] = 1178, -- Sunreaver Micro-Sentry
	[163817] = 2473, -- Sunscale Hatchling
	[152977] = 2088, -- Surger <= Vibrating Stone
	[163505] = 2419, -- Swamp Toad <= Toad in a Box
	[116064] = 1478, -- Syd the Squid
	[ 97553] = 1231, -- Tainted Waveling <= Tainted Core
	[161081] = 2198, -- Taptaf
	[163677] = 2435, -- Teeny Titan Orb
	[ 44965] =  204, -- Teldrassil Sproutling
	[ 22780] = 1073, -- Terky <= White Murloc Egg
	[112699] = 1416, -- Teroclaw Hatchling
	[ 85220] =  650, -- Terrible Turnip
	[136908] = 1759, -- Thaumaturgical Piglet
	[163810] = 2469, -- Thistlebrush Bud
	[130167] = 1803, -- Thistleleaf Adventurer
	[ 85513] =  802, -- Thundering Serpent Hatchling
	[ 39896] =  194, -- Tickbird Hatchling
	[ 97552] = 1230, -- Tideskipper <= Shell of Tide-Calling
	[163807] = 2450, -- Tinder Pup
	[ 94933] = 1207, -- Tiny Blue Carp
	[163498] = 2412, -- Tiny Direhorn
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
	[152966] = 2078, -- Tinytron <= Rough-Hewn Remote
	[ 44971] =  206, -- Tirisfal Batling
	[ 97558] = 1236, -- Tito <= Tito's Basket
	[ 33816] =  163, -- Toothy <= Toothy's Bucket
	[153541] = 2143, -- Tottle
	[ 50446] =  251, -- Toxic Wasteling
	[163501] = 2415, -- Tragg the Curious
	[ 21277] =  116, -- Tranquil Mechanical Yeti
	[139789] = 1920, -- Transmutant
	[143842] = 2004, -- Trashy
	[106256] = 1365, -- Treasure Goblin <= Treasure Goblin's Pack
	[ 11026] =   65, -- Tree Frog <= Tree Frog Box
	[150741] = 2057, -- Tricorne
	[132519] = 1886, -- Trigger
	[136921] = 1886, -- Trigger
	[120121] = 1605, -- Trunks
	[ 44810] =  525, -- Turkey <= Turkey Cage
	[ 49287] =  241, -- Tuskarr Kite
	[147900] = 2051, -- Twilight
	[152969] = 2081, -- Twilight Clutch-Sister <= Odd Twilight Egg
	[144394] = 2022, -- Tylarr Gronnden
	[118104] = 1538, -- Umbrafen Spore
	[ 10393] =   55, -- Undercity Cockroach
	[152981] = 2092, -- Unstable Tendril <= Severed Tentacle
	[ 93036] = 1151, -- Untamed Hatchling <= Unscathed Egg
	[139790] = 1921, -- Untethered Wyrmling
	[153195] = 2136, -- Uuna <= Uuna's Doll
	[ 38658] =  187, -- Vampiric Batling
	[120050] = 1596, -- Veilwatcher Hatchling
	[160940] = 2192, -- Vengeful Chicken <= Intact Chicken Brain
	[103637] = 1344, -- Vengeful Porcupette
	[ 89736] =  855, -- Venus
	[147541] = 2037, -- Vilebrood Whelpling
	[ 93039] = 1154, -- Viscidus Globule
	[ 97960] = 1244, -- Viscous Horror <= Dark Quivering Blob
	[163652] = 2434, -- Voidwiggler <= Tiny Grimoire
	[ 69824] =  310, -- Voodoo Figurine
	[163824] = 2460, -- Voru'kar Leecher
	[ 46767] =  227, -- Warbot <= Warbot Ignition Key
	[ 95621] =  227, -- Warbot <= Warbot Ignition Key
	[113558] = 1394, -- Weebomination
	[ 23015] =  127, -- Whiskers the Rat <= Rat Cage
	[  8489] =   46, -- White Kitten <= Cat Carrier (White Kitten)
	[ 29904] =  141, -- White Moth <= White Moth Egg
	[ 39899] =  195, -- White Tickbird Hatchling
	[142099] = 1968, -- Wicked Soul <= Call of the Frozen Blade
	[163497] = 2411, -- Wicker Pup <= Spooky Bundle of Sticks
	[116804] = 1523, -- Widget the Departed
	[ 32617] =  157, -- Willy <= Sleepy Willy
	[ 49663] =  246, -- Wind Rider Cub
	[142090] = 1959, -- Winter Rageling <= Ominous Pile of Snow
	[ 21308] =  118, -- Winter Reindeer <= Jingling Bell
	[ 21305] =  120, -- Winter's Little Helper <= Red Helper Box
	[ 69239] =  306, -- Winterspring Cub
	[ 46325] =  220, -- Withers
	[ 32233] =  153, -- Wolpertinger <= Wolpertinger's Tankard
	[141348] = 1937, -- Wondrous Wisdomball
	[ 11027] =   64, -- Wood Frog <= Wood Frog Box
	[ 12264] =   89, -- Worg Pup <= Worg Carrier
	[122115] = 1634, -- Wretched Servant <= Servant's Bell
	[136922] = 1887, -- Wyrmy Tunkins
	[101771] = 1266, -- Xu-Fu, Cub of Xuen
	[ 29903] =  140, -- Yellow Moth <= Yellow Moth Egg
	[122533] = 1656, -- Young Talbuk
	[143755] = 2000, -- Young Venomfang
	[102147] = 1304, -- Yu'la, Broodling of Yu'lon
	[ 89367] =  850, -- Yu'lon Kite
	[ 95422] = 1211, -- Zandalari Anklerender
	[ 95423] = 1212, -- Zandalari Footslasher
	[ 94126] = 1180, -- Zandalari Kneebiter
	[163499] = 2413, -- Zandalari Shinchomper <= Raptor Containment Crate
	[ 95424] = 1213, -- Zandalari Toenibbler
	[118101] = 1536, -- Zangar Spore
	[102146] = 1305, -- Zao, Calfling of Niuzao
	[152973] = 2084, -- Zephyrian Prince <= Zephyr's Call
	[128423] = 1255, -- Zeradar
	[ 13582] =   94, -- Zergling <= Zergling Leash
	[ 49664] =  247, -- Zipao Tiger <= Enchanted Purple Jade
	[113554] = 1428, -- Zomstrok
	[137298] = 1903, -- Zoom
}
