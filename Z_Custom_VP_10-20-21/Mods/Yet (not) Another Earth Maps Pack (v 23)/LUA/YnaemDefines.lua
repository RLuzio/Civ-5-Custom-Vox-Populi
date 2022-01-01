-- Ynaem
-- Author: Gedemon
-- DateCreated: 11/3/2010
--------------------------------------------------------------

--print ("---- Loading YnAEMP defines -----")

-- Get YnAEMP related mods
defaultCSModID = "53da86d6-4a0d-4f92-a489-4d1a7fb7cd30"
madeiraCSModID = "9f6d56dd-d653-4c8a-b3a7-4a30582c86c2"
extendedCSModID = "77214b67-d97a-4359-bfe6-b534905528f1"
dynamicModID = "97837c72-d198-49d2-accd-31101cfc048a"

-- Used to find YnAEMP mod files (basically : maps files)
YnaemModId = "36e88483-48fe-4545-b85f-bafc50dde315"
YnaemModVersion = Modding.GetActivatedModVersion(YnaemModId)

g_defaultCS = 0
g_madeiraCS = 0
g_extendedCS = 0
g_dynamicCS = 0
g_dynamicMod = false
g_bBadCS = false

local unsortedInstalledMods = Modding.GetInstalledMods()
for key, modInfo in pairs(unsortedInstalledMods) do
	for k, v in pairs(modInfo) do
		if modInfo.Enabled then
			--print (k)
			if modInfo.ID == defaultCSModID then
				g_defaultCS = 1
			end
			if modInfo.ID == madeiraCSModID then
				g_madeiraCS = 1
			end
			if modInfo.ID == extendedCSModID then
				g_extendedCS = 1
			end
			if modInfo.ID == dynamicModID then
				g_dynamicCS = 1
				g_dynamicMod = true
			end
		end
	end
end

-- more than one CS mod activated ?
if ( g_defaultCS + g_madeiraCS + g_extendedCS + g_dynamicCS > 1 ) then
	g_bBadCS = true
end


-- use mod data to save / load data between game initialisation phases
dynHistModVersion = Modding.GetLatestInstalledModVersion(dynamicModID) -- use DynHist mod ID for components intercompatibility
modUserData = Modding.OpenUserData(dynamicModID, dynHistModVersion)

-- map type
GIANT_EARTH = 1
HUGE_EARTH = 2
STANDARD_CORDIFORM_EARTH = 3
LARGE_EUROPE = 4
STANDARD_WESTERN_MEDITERRANEAN = 5
LARGE_MEDITERRANEAN = 6
STANDARD_EASTERN_MEDITERRANEAN = 7
LARGE_EASTERN_MEDITERRANEAN = 8
LARGE_GREATEST_EARTH = 9
STANDARD_AMERICA = 10
GIANT_EUROPE = 11
APENNINE = 12
EAST_ASIA = 13
BRITISH_ISLES = 14
NORTHEAST_ASIA = 15
AEGEAN = 16
NORTH_ATLANTIC = 17
PACIFIC = 18
SOUTH_PACIFIC = 19
NORTHWEST_EUROPE = 20
CARIBBEAN = 21
ASIA = 22
MEDITERRANEAN = 23
MESOPOTAMIA = 24
LARGE_AFRICA = 25
NILE_VALLEY = 26
AMERICAS = 27

-- List of available maps
-- todo: ID as index
if ( g_madeiraCS == 1 ) then
	local str = "[NEWLINE]No other map available for Madeira's CS"
	g_MapList = { 
		[GIANT_EARTH] = { ID = GIANT_EARTH, File = "Earth_Giant_blank.Civ5Map", Name = "Giant Earth", Description = "180x96 giant earth" .. str, Size = "WORLDSIZE_HUGE", Civs = 20, Minors = 36, TablePrefix = "Yagem" },
	}
elseif ( g_dynamicCS == 1 ) then
	local str = "[NEWLINE]Limited list for Dynamic History"
	g_MapList = { 
		[GIANT_EARTH] = { ID = GIANT_EARTH, File = "Earth_Giant_blank.Civ5Map", Name = "Giant Earth", Description = "180x96 giant earth" .. str, Size = "WORLDSIZE_HUGE", Civs = 20, Minors = 36, TablePrefix = "Yagem" },
		[LARGE_EUROPE] = { ID = LARGE_EUROPE, File = "Europe_Large_blank.Civ5Map", Name = "Large Europe", Description = "79x73 large Europe by Dieter VonClam" .. str, Size = "WORLDSIZE_LARGE", Civs = 12, Minors = 12, TablePrefix = "EuroLarge" },
	}
else
	g_MapList = { 
		[GIANT_EARTH] = { ID = GIANT_EARTH, File = "Earth_Giant_blank.Civ5Map", Name = "Giant Earth", Description = "180x96 giant earth, conversion of Genghis Kai's GEM for civ4", Size = "WORLDSIZE_HUGE", Civs = 22, Minors = 41, TablePrefix = "Yagem",},
		[HUGE_EARTH] = { ID = HUGE_EARTH, File = "Earth_Huge_blank.Civ5Map", Name = "Huge Earth", Description = "120x80 huge earth by Dale with enlarged Europe", Size = "WORLDSIZE_HUGE", Civs = 18, Minors = 20, TablePrefix = "Yahem" },
		[STANDARD_CORDIFORM_EARTH] = { ID = STANDARD_CORDIFORM_EARTH, File = "Earth_Standard_Cordiform_blank.Civ5Map", Name = "Standard Cordiform Earth", Description = "80x52 standard Earth using Werner projection by smellymummy", Size = "WORLDSIZE_STANDARD", Civs = 12, Minors = 12, TablePrefix = "Cordiform" },
		[LARGE_EUROPE] = { ID = LARGE_EUROPE, File = "Europe_Large_blank.Civ5Map", Name = "Large Europe", Description = "79x73 large Europe by Dieter VonClam", Size = "WORLDSIZE_LARGE", Civs = 12, Minors = 12, TablePrefix = "EuroLarge" },
		-- [STANDARD_WESTERN_MEDITERRANEAN] = { ID = STANDARD_WESTERN_MEDITERRANEAN, File = "Western_Mediterranean_Standard_blank.Civ5Map", Name = "Standard Western Mediterranean", Description = "74x52 standard Western Mediterranean for Ambrox62's AMC", Size = "WORLDSIZE_STANDARD", Civs = 8, Minors = 16, TablePrefix = "AmcWestMedStandard" },
		-- [LARGE_MEDITERRANEAN] = { ID = LARGE_MEDITERRANEAN, File = "Mediterranean_Large_blank.Civ5Map", Name = "Large Mediterranean", Description = "110x55 large Mediterranean for Ambrox62's AMC", Size = "WORLDSIZE_LARGE", Civs = 14, Minors = 22, TablePrefix = "AmcMedLarge" },
		-- [STANDARD_EASTERN_MEDITERRANEAN] = { ID = STANDARD_EASTERN_MEDITERRANEAN, File = "Eastern_Mediterranean_Standard_blank.Civ5Map", Name = "Standard Eastern Mediterranean", Description = "72x55 standard Eastern Mediterranean for Ambrox62's AMC", Size = "WORLDSIZE_STANDARD", Civs = 10, Minors = 16, TablePrefix = "AmcEastMedStandard" },
		-- [LARGE_EASTERN_MEDITERRANEAN] = { ID = LARGE_EASTERN_MEDITERRANEAN, File = "Eastern_Mediterranean_Large_blank.Civ5Map", Name = "Large Eastern Mediterranean", Description = "110x55 large Eastern Mediterranean for Ambrox62's AMC", Size = "WORLDSIZE_LARGE", Civs = 14, Minors = 22, TablePrefix = "AmcEastMedLarge" },
		[LARGE_GREATEST_EARTH] = { ID = LARGE_GREATEST_EARTH, File = "GreatestEarthMap.Civ5Map", Name = "Large Earth", Description = "104x64 Large Earth by djvandyke, with massively rescaled regions for better Gameplay", Size = "WORLDSIZE_LARGE", Civs = 22, Minors = 16, TablePrefix = "GreatestEarth" },
		--[STANDARD_AMERICA] = { ID = STANDARD_AMERICA, File = "ANACMap_blank.Civ5Map", Name = "Standard America", Description = "69x69 standard America for Optik's ANAC", Size = "WORLDSIZE_STANDARD", Civs = 8, Minors = 12, TablePrefix = "AmericaStandard" },
		[GIANT_EUROPE] = { ID = GIANT_EUROPE, File = "Europe_Giant_blank.Civ5Map", Name = "Giant Europe", Description = "166x118 giant Europe by Damasc", Size = "WORLDSIZE_HUGE", Civs = 18, Minors = 24, TablePrefix = "EuroGiant" },
		[APENNINE] = { ID = APENNINE, File = "Apennine.Civ5Map", Name = "Apennine", Description = "60x58 Apennine by Evanescence", Size = "WORLDSIZE_STANDARD", Civs = 3, Minors = 6, TablePrefix = "Apennine" },
		[EAST_ASIA] = { ID = EAST_ASIA, File = "South_East_Asia_Large_blank.Civ5Map", Name = "East Asia", Description = "79x79 large East Asia", Size = "WORLDSIZE_LARGE", Civs = 6, Minors = 9, TablePrefix = "EastAsia" },
		[BRITISH_ISLES] = { ID = BRITISH_ISLES, File = "British_Isles.Civ5Map", Name = "British Isles", Description = "61x74 standard British Isles by Firaxis", Size = "WORLDSIZE_STANDARD", Civs = 3, Minors = 0, TablePrefix = "BritishIsles" },
		[NORTHEAST_ASIA] = { ID = NORTHEAST_ASIA, File = "Northeast_Asia.Civ5Map", Name = "North-East Asia", Description = "64x56 standard North-East Asia by Evanescence", Size = "WORLDSIZE_STANDARD", Civs = 3, Minors = 1, TablePrefix = "NorthEastAsia" },
		[AEGEAN] = { ID = AEGEAN, File = "Aegean.Civ5Map", Name = "Aegean", Description = "61x51 standard Aegean by Evanescence", Size = "WORLDSIZE_STANDARD", Civs = 3, Minors = 14, TablePrefix = "Aegean" },
		[NORTH_ATLANTIC] = { ID = NORTH_ATLANTIC, File = "North_Atlantic.Civ5Map", Name = "North Atlantic", Description = "105x57 Large North Atlantic", Size = "WORLDSIZE_LARGE", Civs = 18, Minors = 19, TablePrefix = "NorthAtlantic" },
		[PACIFIC] = { ID = PACIFIC, File = "Pacific.Civ5Map", Name = "Pacific", Description = "114x79 Large Pacific by kevincbryan", Size = "WORLDSIZE_LARGE", Civs = 8, Minors = 13, TablePrefix = "Pacific" },
		[SOUTH_PACIFIC] = { ID = SOUTH_PACIFIC, File = "South_Pacific.Civ5Map", Name = "South Pacific", Description = "99x95 South Pacific by Firaxis", Size = "WORLDSIZE_STANDARD", Civs = 1, Minors = 14, TablePrefix = "SouthPacific" },
		[NORTHWEST_EUROPE] = { ID = NORTHWEST_EUROPE, File = "NorthWestEurope_Standard.Civ5Map", Name = "North-West Europe", Description = "56x67 standard North-West Europe by jordie", Size = "WORLDSIZE_STANDARD", Civs = 10, Minors = 8, TablePrefix = "NorthWestEurope" },
		[CARIBBEAN] = { ID = CARIBBEAN, File = "Caribbean.Civ5Map", Name = "Caribbean", Description = "99x69 large Caribbean by Firaixs", Size = "WORLDSIZE_LARGE", Civs = 8, Minors = 2, TablePrefix = "Caribbean" },
		[ASIA] = { ID = ASIA, File = "Asia.Civ5Map", Name = "Large Asia", Description = "103x63 Large Asia", Size = "WORLDSIZE_LARGE", Civs = 8, Minors = 14, TablePrefix = "Asia" },
		[MEDITERRANEAN] = { ID = MEDITERRANEAN, File = "Mediterranean.Civ5Map", Name = "Mediterranean", Description = "103x64 large Mediterranean", Size = "WORLDSIZE_LARGE", Civs = 13, Minors = 20, TablePrefix = "Mediterranean" },
		[MESOPOTAMIA] = { ID = MESOPOTAMIA, File = "Mesopotamia.Civ5Map", Name = "Mesopotamia", Description = "79x49 large Mesopotamia", Size = "WORLDSIZE_LARGE", Civs = 12, Minors = 7, TablePrefix = "Mesopotamia" },
		[LARGE_AFRICA] = { ID = LARGE_AFRICA, File = "Africa_Large_blank.Civ5Map", Name = "Large Africa", Description = "65x74 large Africa by jordie", Size = "WORLDSIZE_LARGE", Civs = 6, Minors = 24, TablePrefix = "AfricaLarge" },
		[NILE_VALLEY] = { ID = NILE_VALLEY, File = "NileValley.Civ5Map", Name = "Nile Valley", Description = "81x80 large Nile Valley by Admiral Ackbar", Size = "WORLDSIZE_LARGE", Civs = 2, Minors = 24, TablePrefix = "NileValley" },
		[AMERICAS] = { ID = AMERICAS, File = "Americas.Civ5Map", Name = "Americas", Description = "67x80 standard Americas (North+South) by ?", Size = "WORLDSIZE_STANDARD", Civs = 16, Minors = 6, TablePrefix = "Americas" },
	}
end

-- Bosphorus Strait position
-- x, y are plot coordinate, replX and replY the replacement plot for any civ starting here
-- riverX, riverY are the coordinate of the plot NW or W to the strait as a river (see position)
g_BosphorusPlot = { 
	[GIANT_EARTH] = {x=31, y=59, replX=32, replY=59, riverX=31, riverY=60, position = "NW"},
	[HUGE_EARTH] = {x=69, y=54, replX=69, replY=53, riverX=69, riverY=54, position = "NW"},
	[STANDARD_CORDIFORM_EARTH] = {x=45, y=24, replX=45, replY=23, riverX=44, riverY=24, position = "W"},
	[LARGE_EUROPE] = {x=53, y=31, replX=54, replY=31, riverX=53, riverY=31, position = "W-NW"},
	[LARGE_GREATEST_EARTH] = {x=58, y=45, replX=59, replY=45, riverX=57, riverY=45, position = "W"},
	[GIANT_EUROPE] = {x=110, y=34, replX=110, replY=33, riverX=110, riverY=34, position = "W-NW"},
}

-- Natural Wonder renaming
g_NaturalWonderName = { 
	[GIANT_EARTH] = {},
	[HUGE_EARTH] = {},
	[STANDARD_CORDIFORM_EARTH] = {},
	[LARGE_EUROPE] = { TXT_KEY_FEATURE_VOLCANO = "Santorini", TXT_KEY_FEATURE_REEF = "Coral Reef", TXT_KEY_FEATURE_GEYSER = "The Great Geysir", TXT_KEY_FEATURE_CRATER = "Tin Bider crater", TXT_KEY_FEATURE_POTOSI = "The Great Copper Mountain" },
	[STANDARD_WESTERN_MEDITERRANEAN] = { 
		TXT_KEY_FEATURE_VOLCANO = "Santorini", 
		TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT = "Santorini is an island located in the southern Aegean Sea. The island is the site of one of the largest volcanic eruptions in recorded history: the Minoan eruption, sometimes called the Thera eruption, which occurred some 3600 years ago at the height of the Minoan civilization. The eruption left a large caldera surrounded by volcanic ash deposits hundreds of feet deep and may have led indirectly to the collapse of the Minoan civilization on the island of Crete, 110 km to the south, through a gigantic tsunami. Another popular theory holds that the Thera eruption is the source of the legend of Atlantis.",
		TXT_KEY_FEATURE_MT_FUJI = "Mont Blanc", 
		TXT_KEY_CIV5_FEATURES_FUJI_TEXT = "Mont Blanc is the highest mountain in the Alps, Western Europe and the European Union. The mountain lies between the regions of Aosta Valley, Italy, and Haute-Savoie, France. It rises 4,810 m above sea level and is ranked 11th in the world in topographic prominence. The summit of Mont Blanc is a thick, perennial ice and snow dome whose thickness varies, so no exact and permanent summit elevation can be determined, although accurate measurements have been made. It was first climbed in 1786 by Michel-Gabriel Paccard and Jacques Balmat. In 1886, future U.S. President Theodore Roosevelt led an expedition to the peak. Today it is one of the most visited tourist destinations in the world.",
		TXT_KEY_FEATURE_GEYSER = "Ayvalik Hot Springs", 
		TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT = "Ayvalik is a town in the northwestern Aegean coast of Turkey, in a district of the Balikesir Province. It was alternatively called Kidonies by the town''s formerly important Greek population. Hot springs are abundant in the Ayvalik surrounding area. Mentioned in Homer’s epics as Agamemnon Thermal Springs, and in the writings of geographer Strabon, these waters have been used to cure various ailments. Members of Alexander the Great’s army used the spring to heal their wounds, which made their healing powers famous.",
		TXT_KEY_FEATURE_CRATER = "Ries Crater",  
		TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT = "The Ries crater is a large circular depression near Nordlinger, in western Bavaria. The depression is interpreted as a meteor impact crater formed about 14.3 million-14.5 million years ago in the Miocene. The original crater rim had an estimated diameter of 24 kilometers. The present floor of the depression is about 100 to 150 m below the eroded remains of the rim. Stone buildings in Nordlingen contain millions of tiny diamonds, all less than 0.2 mm across. The impact that caused the Ries crater created an estimated 72,000 tonnes of them when it impacted a local graphite deposit. Stone from this area was quarried and used to build the local buildings.",
		TXT_KEY_FEATURE_MESA = "Siligo Mesa", 
		TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT = "Siligo is a town in the region of Logudoro, in northern Sardinia, Italy. It is known for the mesa of Monte Santu, an elevated area of land with a flat top formed by weathering and erosion of horizontally layered rocks that have been uplifted by tectonic activity. The place hosts an archaeological site and a prehistoric Nuragic Sanctuary."
		},
	[LARGE_MEDITERRANEAN] = { 
		TXT_KEY_FEATURE_VOLCANO = "Santorini", 
		TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT = "Santorini is an island located in the southern Aegean Sea. The island is the site of one of the largest volcanic eruptions in recorded history: the Minoan eruption, sometimes called the Thera eruption, which occurred some 3600 years ago at the height of the Minoan civilization. The eruption left a large caldera surrounded by volcanic ash deposits hundreds of feet deep and may have led indirectly to the collapse of the Minoan civilization on the island of Crete, 110 km to the south, through a gigantic tsunami. Another popular theory holds that the Thera eruption is the source of the legend of Atlantis.",
		TXT_KEY_FEATURE_MT_FUJI = "Mont Blanc", 
		TXT_KEY_CIV5_FEATURES_FUJI_TEXT = "Mont Blanc is the highest mountain in the Alps, Western Europe and the European Union. The mountain lies between the regions of Aosta Valley, Italy, and Haute-Savoie, France. It rises 4,810 m above sea level and is ranked 11th in the world in topographic prominence. The summit of Mont Blanc is a thick, perennial ice and snow dome whose thickness varies, so no exact and permanent summit elevation can be determined, although accurate measurements have been made. It was first climbed in 1786 by Michel-Gabriel Paccard and Jacques Balmat. In 1886, future U.S. President Theodore Roosevelt led an expedition to the peak. Today it is one of the most visited tourist destinations in the world.",
		TXT_KEY_FEATURE_REEF = "Red Sea Reef", 
		TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT = "The Red Sea is a seawater inlet of the Indian Ocean, lying between Africa and Asia. It is a rich and diverse ecosystem counting more than 1200 species of fish, and around 10% of these are found nowhere else. The rich diversity is in part due to the 2,000 km of coral reef extending along its coastline; these fringing reefs are 5000–7000 years old and are largely formed of stony acropora and porites corals. The reefs form platforms and sometimes lagoons along the coast and occasional other features such as cylinders. These coastal reefs are also visited by pelagic species of red sea fish, including some of the 44 species of shark.",
		TXT_KEY_FEATURE_GEYSER = "Ayvalik Hot Springs", 
		TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT = "Ayvalik is a town in the northwestern Aegean coast of Turkey, in a district of the Balikesir Province. It was alternatively called Kidonies by the town''s formerly important Greek population. Hot springs are abundant in the Ayvalik surrounding area. Mentioned in Homer’s epics as Agamemnon Thermal Springs, and in the writings of geographer Strabon, these waters have been used to cure various ailments. Members of Alexander the Great’s army used the spring to heal their wounds, which made their healing powers famous.",
		TXT_KEY_FEATURE_CRATER = "Ries Crater", 
		TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT = "The Ries crater is a large circular depression near Nordlinger, in western Bavaria. The depression is interpreted as a meteor impact crater formed about 14.3 million-14.5 million years ago in the Miocene. The original crater rim had an estimated diameter of 24 kilometers. The present floor of the depression is about 100 to 150 m below the eroded remains of the rim. Stone buildings in Nordlingen contain millions of tiny diamonds, all less than 0.2 mm across. The impact that caused the Ries crater created an estimated 72,000 tonnes of them when it impacted a local graphite deposit. Stone from this area was quarried and used to build the local buildings.",
		TXT_KEY_FEATURE_POTOSI = "Iron Mountain", 
		TXT_KEY_CIV5_FEATURES_POTOSI_TEXT = "Iron Mountains are a mountain ridge in the south of Chrudim District, in the middle of Czech Republic. These mountains are not particularly high. They provided sources of iron in the ancient times, while today offer good conditions for winter sports.",
		TXT_KEY_FEATURE_MESA = "Siligo Mesa",
		TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT = "Siligo is a town in the region of Logudoro, in northern Sardinia, Italy. It is known for the mesa of Monte Santu, an elevated area of land with a flat top formed by weathering and erosion of horizontally layered rocks that have been uplifted by tectonic activity. The place hosts an archaeological site and a prehistoric Nuragic Sanctuary."
		},
	[STANDARD_EASTERN_MEDITERRANEAN] = {
		TXT_KEY_FEATURE_VOLCANO = "Santorini", 
		TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT = "Santorini is an island located in the southern Aegean Sea. The island is the site of one of the largest volcanic eruptions in recorded history: the Minoan eruption, sometimes called the Thera eruption, which occurred some 3600 years ago at the height of the Minoan civilization. The eruption left a large caldera surrounded by volcanic ash deposits hundreds of feet deep and may have led indirectly to the collapse of the Minoan civilization on the island of Crete, 110 km to the south, through a gigantic tsunami. Another popular theory holds that the Thera eruption is the source of the legend of Atlantis.",
		TXT_KEY_FEATURE_MT_FUJI = "Mount Damavand", 
		TXT_KEY_CIV5_FEATURES_FUJI_TEXT = "Mount Damavand, also known as Donbavand, is a potentially active volcano and the highest peak in Iran. It has a special place in Persian mythology and folklore. Located near the southern coast of the Caspian Sea, it is the highest point in the Middle East and the highest volcano in all of Asia. It is a potentially active volcano, since there are fumaroles near the summit crater emitting sulfur.",
		TXT_KEY_FEATURE_REEF = "Red Sea Reef", 
		TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT = "The Red Sea is a seawater inlet of the Indian Ocean, lying between Africa and Asia. It is a rich and diverse ecosystem counting more than 1200 species of fish, and around 10% of these are found nowhere else. The rich diversity is in part due to the 2,000 km of coral reef extending along its coastline; these fringing reefs are 5000–7000 years old and are largely formed of stony acropora and porites corals. The reefs form platforms and sometimes lagoons along the coast and occasional other features such as cylinders. These coastal reefs are also visited by pelagic species of red sea fish, including some of the 44 species of shark.",
		TXT_KEY_FEATURE_GEYSER = "Ayvalik Hot Springs", 
		TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT = "Ayvalik is a town in the northwestern Aegean coast of Turkey, in a district of the Balikesir Province. It was alternatively called Kidonies by the town''s formerly important Greek population. Hot springs are abundant in the Ayvalik surrounding area. Mentioned in Homer’s epics as Agamemnon Thermal Springs, and in the writings of geographer Strabon, these waters have been used to cure various ailments. Members of Alexander the Great’s army used the spring to heal their wounds, which made their healing powers famous.",
		TXT_KEY_FEATURE_CRATER = "Boltysh Crater", 
		TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT = "The Boltysh Crater is an impact crater in the Kirovohrad Oblast province of Ukraine. The crater is 24 kilometres in diameter and its age of 65 million years, based on argon dating techniques, is within error of that of  of Chicxulub Crater in Mexico. The Chicxulub impact is believed to have caused the mass extinction at the end of the Cretaceous era, which included the extinction of the dinosaurs. The Boltysh impact likely occurred several thousand years before Chicxulub, suggesting the extinction event may have been driven by multiple meteor strikes over an extended period of time about 65 million years ago.",
		TXT_KEY_FEATURE_GIBRALTAR = "Aphrodite Rock",
		TXT_KEY_CIV5_FEATURES_GIBRALTER_TEXT = "Aphrodite''s Rock is a sea stack in Paphos, a coastal city in the southwest of Cyprus. It is regarded as the mythological birthplace of Aphrodite. According to the legend, Gaia (Mother Earth) asked one of her sons, Cronus, to mutilate his father, Uranus (Sky). Cronus cut off Uranus'' testicles and threw them into the sea. A white foam appeared from which a maiden arose; the waves first taking her to Kythera and then bringing her to Cyprus. The maiden, named Aphrodite, went to the assembly of gods from Cyprus. Known for lustful love more than romantic love, Aphrodite attracted a large cult following in Paphos, which was eventually crushed by the Romans."
		},
	[LARGE_EASTERN_MEDITERRANEAN] = { 
		TXT_KEY_FEATURE_VOLCANO = "Santorini", 
		TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT = "Santorini is an island located in the southern Aegean Sea. The island is the site of one of the largest volcanic eruptions in recorded history: the Minoan eruption, sometimes called the Thera eruption, which occurred some 3600 years ago at the height of the Minoan civilization. The eruption left a large caldera surrounded by volcanic ash deposits hundreds of feet deep and may have led indirectly to the collapse of the Minoan civilization on the island of Crete, 110 km to the south, through a gigantic tsunami. Another popular theory holds that the Thera eruption is the source of the legend of Atlantis.",
		TXT_KEY_FEATURE_MT_FUJI = "Mount Damavand",
		TXT_KEY_CIV5_FEATURES_FUJI_TEXT = "Mount Damavand, also known as Donbavand, is a potentially active volcano and the highest peak in Iran. It has a special place in Persian mythology and folklore. Located near the southern coast of the Caspian Sea, it is the highest point in the Middle East and the highest volcano in all of Asia. It is a potentially active volcano, since there are fumaroles near the summit crater emitting sulfur.",
		TXT_KEY_FEATURE_REEF = "Red Sea Reef",
		TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT = "The Red Sea is a seawater inlet of the Indian Ocean, lying between Africa and Asia. It is a rich and diverse ecosystem counting more than 1200 species of fish, and around 10% of these are found nowhere else. The rich diversity is in part due to the 2,000 km of coral reef extending along its coastline; these fringing reefs are 5000–7000 years old and are largely formed of stony acropora and porites corals. The reefs form platforms and sometimes lagoons along the coast and occasional other features such as cylinders. These coastal reefs are also visited by pelagic species of red sea fish, including some of the 44 species of shark.",
		TXT_KEY_FEATURE_GEYSER = "Ayvalik Hot Springs",
		TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT = "Ayvalik is a town in the northwestern Aegean coast of Turkey, in a district of the Balikesir Province. It was alternatively called Kidonies by the town''s formerly important Greek population. Hot springs are abundant in the Ayvalik surrounding area. Mentioned in Homer’s epics as Agamemnon Thermal Springs, and in the writings of geographer Strabon, these waters have been used to cure various ailments. Members of Alexander the Great’s army used the spring to heal their wounds, which made their healing powers famous.",
		TXT_KEY_FEATURE_CRATER = "Ries Crater",
		TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT = "The Ries crater is a large circular depression near Nordlinger, in western Bavaria. The depression is interpreted as a meteor impact crater formed about 14.3 million-14.5 million years ago in the Miocene. The original crater rim had an estimated diameter of 24 kilometers. The present floor of the depression is about 100 to 150 m below the eroded remains of the rim. Stone buildings in Nordlingen contain millions of tiny diamonds, all less than 0.2 mm across. The impact that caused the Ries crater created an estimated 72,000 tonnes of them when it impacted a local graphite deposit. Stone from this area was quarried and used to build the local buildings.",
		TXT_KEY_FEATURE_POTOSI = "Iron Mountain",
		TXT_KEY_CIV5_FEATURES_POTOSI_TEXT = "Iron Mountains are a mountain ridge in the south of Chrudim District, in the middle of Czech Republic. These mountains are not particularly high. They provided sources of iron in the ancient times, while today offer good conditions for winter sports.",
		TXT_KEY_FEATURE_MESA = "Siligo Mesa",
		TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT = "Siligo is a town in the region of Logudoro, in northern Sardinia, Italy. It is known for the mesa of Monte Santu, an elevated area of land with a flat top formed by weathering and erosion of horizontally layered rocks that have been uplifted by tectonic activity. The place hosts an archaeological site and a prehistoric Nuragic Sanctuary.",
		TXT_KEY_FEATURE_GIBRALTAR = "Aphrodite Rock",
		TXT_KEY_CIV5_FEATURES_GIBRALTER_TEXT = "Aphrodite''s Rock is a sea stack in Paphos, a coastal city in the southwest of Cyprus. It is regarded as the mythological birthplace of Aphrodite. According to the legend, Gaia (Mother Earth) asked one of her sons, Cronus, to mutilate his father, Uranus (Sky). Cronus cut off Uranus'' testicles and threw them into the sea. A white foam appeared from which a maiden arose; the waves first taking her to Kythera and then bringing her to Cyprus. The maiden, named Aphrodite, went to the assembly of gods from Cyprus. Known for lustful love more than romantic love, Aphrodite attracted a large cult following in Paphos, which was eventually crushed by the Romans."
		},
	[LARGE_GREATEST_EARTH] = {},
	[STANDARD_AMERICA] = {},
	[GIANT_EUROPE] = { 
		TXT_KEY_FEATURE_VOLCANO = "Santorini",
		TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT = "Santorini is an island located in the southern Aegean Sea. The island is the site of one of the largest volcanic eruptions in recorded history: the Minoan eruption, sometimes called the Thera eruption, which occurred some 3600 years ago at the height of the Minoan civilization. The eruption left a large caldera surrounded by volcanic ash deposits hundreds of feet deep and may have led indirectly to the collapse of the Minoan civilization on the island of Crete, 110 km to the south, through a gigantic tsunami. Another popular theory holds that the Thera eruption is the source of the legend of Atlantis.",		
		TXT_KEY_FEATURE_REEF = "The Sula Reef",
		TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT = "The Sula Reef is a deep-water coral reef off the coast of Norway. It is located on the Sula Ridge, named after the island of Sula. The reef is generated by the coral Lophelia pertusa. It has a length extension of about thirteen kilometers, and is 700 meters wide. The thickness of the reef is up to 35 meters. Until the discovery of the Røst Reef in 2002, the Sula Reef was the world's largest known Lophelia reef.",
		TXT_KEY_FEATURE_GEYSER = "The Great Geysir",
		TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT = "Geysir sometimes known as The Great Geysir, is a geyser in southwestern Iceland. It was the first geyser described in a printed source and the first known to modern Europeans. The English word geyser (a periodically spouting hot spring) derives from Geysir. The name Geysir itself is derived from the Icelandic verb geysa. Geysir lies in the Haukadalur valley on the slopes of Laugarfjall hill, which is also the home to Strokkur geyser about 50 metres south.",
		TXT_KEY_FEATURE_CRATER = "Tin Bider crater",
		TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT = "Tin Bider is an impact crater that sits in dry, rugged terrain in Algeria. The crater was formed in the last 70 million years, perhaps in the late Cretaceous or early Tertiary Period. Spanning 6 kilometres, the crater sits at the southern end of a range of hills. The elevated position and concentric rings of Tin Bider suggest that its structure is complex.",
		TXT_KEY_FEATURE_POTOSI = "The Great Copper Mountain",
		TXT_KEY_CIV5_FEATURES_POTOSI_TEXT =  "Falun Mine was a mine in Falun, Sweden, that operated for a millennium from the 10th century to 1992. It produced as much as two thirds of Europe's copper needs and helped fund many of Sweden's wars in the 17th century. Technological developments at the mine had a profound influence on mining globally for two centuries. Since 2001 it has been designated a UNESCO world heritage site as well as a museum.",
		TXT_KEY_FEATURE_MT_FUJI = "Mt. Etna",
		TXT_KEY_CIV5_FEATURES_FUJI_TEXT = "Mount Etna is an active stratovolcano on the east coast of Sicily, Italy, in the Province of Catania, between Messina and Catania. It lies above the convergent plate margin between the African Plate and the Eurasian Plate. It is the tallest active volcano on the European continent, currently 3,329 m (10,922 ft) high, though this varies with summit eruptions.",
		TXT_KEY_FEATURE_MT_KAILASH = "Mont Blanc",
		TXT_KEY_CIV5_FEATURES_MT_KAILASH_TEXT = "Mont Blanc is the highest mountain in the Alps, Western Europe and the European Union. The mountain lies between the regions of Aosta Valley, Italy, and Haute-Savoie, France. It rises 4,810 m above sea level and is ranked 11th in the world in topographic prominence. The summit of Mont Blanc is a thick, perennial ice and snow dome whose thickness varies, so no exact and permanent summit elevation can be determined, although accurate measurements have been made. It was first climbed in 1786 by Michel-Gabriel Paccard and Jacques Balmat. In 1886, future U.S. President Theodore Roosevelt led an expedition to the peak. Today it is one of the most visited tourist destinations in the world.",
		TXT_KEY_FEATURE_MESA = "Siligo Mesa",
		TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT = "Siligo is a town in the region of Logudoro, in northern Sardinia, Italy. It is known for the mesa of Monte Santu, an elevated area of land with a flat top formed by weathering and erosion of horizontally layered rocks that have been uplifted by tectonic activity. The place hosts an archaeological site and a prehistoric Nuragic Sanctuary.",
		TXT_KEY_FEATURE_SRI_PADA = "Kirkjufell",
		TXT_KEY_CIV5_FEATURES_SRI_PADA_TEXT = "Kirkjufell (Icelandic: Church mountain) is a 463m high mountain on the north coast of Iceland's Snæfellsnes peninsula, near the town of Grundarfjörður.",
		TXT_KEY_FEATURE_LAKE_VICTORIA = "Lake Ladoga",
		TXT_KEY_CIV5_FEATURES_LAKE_VICTORIA_TEXT = "Lake Ladoga is a freshwater lake located in the Republic of Karelia and Leningrad Oblast in northwestern Russia just outside the outskirts of Saint Petersburg. It is the largest lake in Europe, and the 15th largest freshwater lake by area in the world.",
		TXT_KEY_FEATURE_KILIMANJARO = "Mt. Elbrus",
		TXT_KEY_CIV5_FEATURES_KILIMANJARO_TEXT = "Mount Elbrus is a dormant volcano located in the western Caucasus mountain range, in Kabardino-Balkaria and Karachay–Cherkessia of Russia, near the border with Georgia. Mt. Elbrus's peak is the highest in the Caucasus Mountains and in Europe."
		},
	[APENNINE] = {},
	[EAST_ASIA] = {},
	[BRITISH_ISLES] = {},
	[NORTHEAST_ASIA] = {},
	[AEGEAN] = {},
	[NORTH_ATLANTIC] = {},
	[PACIFIC] = {},
	[SOUTH_PACIFIC] = {},
	[NORTHWEST_EUROPE] = {},
	[CARIBBEAN] = {},
	[ASIA] = {},
	[MEDITERRANEAN] = {},
	[MESOPOTAMIA] = {},
	[LARGE_AFRICA] = {},
	[NILE_VALLEY] = {},
	[AMERICAS] = {},
}


g_NaturalWonderPlacement = { 
	[GIANT_EARTH] = {
		["FEATURE_POTOSI"] = {X=157, Y=21},
		["FEATURE_MT_SINAI"] = {X=34, Y=47},
		["FEATURE_SRI_PADA"] = {X=63, Y=33},
		["FEATURE_MT_KAILASH"] = {X=65, Y=56},
		["FEATURE_ULURU"] = {X=92, Y=16},
		["FEATURE_LAKE_VICTORIA"] = {X=34, Y=28},
		["FEATURE_KILIMANJARO"] = {X=36, Y=26},
	},
	[HUGE_EARTH] = {
		["FEATURE_POTOSI"] = {X=35, Y=21},
		["FEATURE_MT_SINAI"] = {X=73, Y=46},
		["FEATURE_SRI_PADA"] = {X=92, Y=33},
		["FEATURE_MT_KAILASH"] = {X=92, Y=51},
		["FEATURE_ULURU"] = {X=112, Y=17},
	},
	[STANDARD_CORDIFORM_EARTH] = {
		["FEATURE_POTOSI"] = {X=16, Y=10},
		["FEATURE_MT_SINAI"] = {X=47, Y=18},
		["FEATURE_SRI_PADA"] = {X=61, Y=17},
		["FEATURE_MT_KAILASH"] = {X=58, Y=26},
		["FEATURE_ULURU"] = {X=72, Y=10},
	},
	[LARGE_EUROPE] = {
		["FEATURE_MT_SINAI"] = {X=61, Y=12},
	},
	[LARGE_GREATEST_EARTH] = {
		["FEATURE_LAKE_VICTORIA"] = {X=60, Y=18},
		["FEATURE_KILIMANJARO"] = {X=61, Y=15},
	},
}
--------------------------------------------------------------

-- max number of resource tiles around civ starting position (see CivilizationsStartTable.xml)
MAX_REQUESTED_RESOURCE = 6

--------------------
-- Map option : Type
--------------------
-- Major placement
MAJOR_PLACEMENT = 1
-- City States placement
MINOR_PLACEMENT = 2
-- Bosphorus tile
BOSPHORUS = 3
-- City States minimum distance
MINOR_DISTANCE = 4
-- Remove United States
NO_US = 5
-- Resources option
RESOURCE_GEO = 6
RESOURCE_DEPOSIT = 7
RESOURCE_QUANTITY = 8
RESOURCE_SCALE = 9
RESOURCE_REQUESTED = 10

--------------------
-- Map option : Value
--------------------
-- Map option : Civilization placement
MAJOR_TSL_ONLY = 1
MAJOR_TSL_RANDOM = 2
MAJOR_ALL_RANDOM = 3
-- Map option : City States placement
MINOR_TSL_ONLY = 1
MINOR_TSL_RANDOM = 2
MINOR_ALL_RANDOM = 3
-- Map option : City States minimum distance
g_MinorDistanceValue = {0,2,4,6,9}
MINOR_DISTANCE_NO = 1
MINOR_DISTANCE_MINI = 2
MINOR_DISTANCE_CLOSE = 3
MINOR_DISTANCE_MEDIUM = 4
MINOR_DISTANCE_AWAY = 5
-- Map option : Resources quantity
g_ResourceQuantityCoeff = {0.25,0.5,1,2,4}
RESOURCE_POOR = 1
RESOURCE_SPARSE = 2
RESOURCE_STANDARD = 3
RESOURCE_ABUNDANT = 4
RESOURCE_RICHE = 5

-------------------------------
-- Map Options : Mod dependency
-------------------------------

if g_bBadCS then
	MajorPlacementValues = { 
			{ Name	= "Only TSL", ToolTip = "Only Civilizations with True Starting Location will be in game", Value = MAJOR_TSL_ONLY,},
			{ Name	= "Random and TSL", ToolTip = "Civilizations with no TSL get random placement", Value = MAJOR_TSL_RANDOM,},
			{ Name	= "Totally random", ToolTip = "All Civilizations get random placement", Value = MAJOR_ALL_RANDOM,},
		}
		
	MinorPlacementValues = { 
			{ Name	= "Only TSL", ToolTip = "Only City States with True Starting Location will be in game", Value = MINOR_TSL_ONLY,},
			{ Name	= "Random and TSL", ToolTip = "City States with no TSL get random placement", Value = MINOR_TSL_RANDOM,},
			{ Name	= "Totally random", ToolTip = "All City States get random placement", Value = MINOR_ALL_RANDOM,},
		}

elseif ( g_madeiraCS == 1 ) then
	MinorPlacementValues = { 
			{ Name	= "Only TSL", ToolTip = "Madeira's selection with True Starting Location", Value = MINOR_TSL_ONLY,},
			{ Name	= "Random", ToolTip = "Madeira's selection with random placement", Value = MINOR_ALL_RANDOM,},
		}
elseif ( g_dynamicCS == 1 ) then
	MinorPlacementValues = { 
			{ Name	= "Dynamic Placement", ToolTip = "Dynamic History mod is activated", Value = MINOR_TSL_ONLY,},
		}
else
	MajorPlacementValues = { 
			{ Name	= "Only TSL", ToolTip = "Only Civilizations with True Starting Location will be in game", Value = MAJOR_TSL_ONLY,},
			{ Name	= "Random and TSL", ToolTip = "Civilizations with no TSL get random placement", Value = MAJOR_TSL_RANDOM,},
			{ Name	= "Totally random", ToolTip = "All Civilizations get random placement", Value = MAJOR_ALL_RANDOM,},
		}
		
	MinorPlacementValues = { 
			{ Name	= "Only TSL", ToolTip = "Only City States with True Starting Location will be in game", Value = MINOR_TSL_ONLY,},
			{ Name	= "Random and TSL", ToolTip = "City States with no TSL get random placement", Value = MINOR_TSL_RANDOM,},
			{ Name	= "Totally random", ToolTip = "All City States get random placement", Value = MINOR_ALL_RANDOM,},
		}
end

if ( g_dynamicCS == 1 ) then
	NoUSOption = 	{
		ID = NO_US,
		Name = "Delayed start for civilizations",
		ToolTip = "Dynamic History Mod is selected, if checked Civilizations will start at real date",
		Disabled = false,
		GameOption = false,
		Checked = true,
		SortPriority = 3,
	}
else
	NoUSOption = 	{
		ID = NO_US,
		Name = "Only native American",
		ToolTip = "Will remove United States and Brazil at game start if it was (randomly or not) selected, keeping only native american civilizations",
		Disabled = false,
		GameOption = false,
		SortPriority = 3,
	}
end

----------------------
-- Map Options : Table
----------------------
g_MapPulldownOptions = {
---------------- 
[GIANT_EARTH] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[HUGE_EARTH] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = { 
			{ Name	= "Only TSL", ToolTip = "Only Civilizations with True Starting Location will be in game", Value = MAJOR_TSL_ONLY,},
			{ Name	= "Random and TSL", ToolTip = "Civilizations with no TSL get random placement", Value = MAJOR_TSL_RANDOM,},
			{ Name	= "Totally random", ToolTip = "All Civilizations get random placement", Value = MAJOR_ALL_RANDOM,},
		},
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = { 
			{ Name	= "Only TSL", ToolTip = "Only City States with True Starting Location will be in game", Value = MINOR_TSL_ONLY,},
			{ Name	= "Random and TSL", ToolTip = "City States with no TSL get random placement", Value = MINOR_TSL_RANDOM,},
			{ Name	= "Totally random", ToolTip = "All City States get random placement", Value = MINOR_ALL_RANDOM,},
		},
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[STANDARD_CORDIFORM_EARTH] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = { 
			{ Name	= "Only TSL", ToolTip = "Only Civilizations with True Starting Location will be in game", Value = MAJOR_TSL_ONLY,},
			{ Name	= "Random and TSL", ToolTip = "Civilizations with no TSL get random placement", Value = MAJOR_TSL_RANDOM,},
			{ Name	= "Totally random", ToolTip = "All Civilizations get random placement", Value = MAJOR_ALL_RANDOM,},
		},
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = { 
			{ Name	= "Only TSL", ToolTip = "Only City States with True Starting Location will be in game", Value = MINOR_TSL_ONLY,},
			{ Name	= "Random and TSL", ToolTip = "City States with no TSL get random placement", Value = MINOR_TSL_RANDOM,},
			{ Name	= "Totally random", ToolTip = "All City States get random placement", Value = MINOR_ALL_RANDOM,},
		},
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[LARGE_EUROPE] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[STANDARD_WESTERN_MEDITERRANEAN] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[LARGE_MEDITERRANEAN] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[STANDARD_EASTERN_MEDITERRANEAN] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[LARGE_EASTERN_MEDITERRANEAN] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------- 
[LARGE_GREATEST_EARTH] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[STANDARD_AMERICA] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[GIANT_EUROPE] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[APENNINE] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[EAST_ASIA] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[BRITISH_ISLES] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[NORTHEAST_ASIA] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[AEGEAN] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[NORTH_ATLANTIC] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[PACIFIC] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[SOUTH_PACIFIC] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[NORTHWEST_EUROPE] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[CARIBBEAN] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
----------------
[ASIA] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[MEDITERRANEAN] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[MESOPOTAMIA] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[LARGE_AFRICA] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[NILE_VALLEY] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
---------------
[AMERICAS] = {
	[MAJOR_PLACEMENT] = {
		ID = MAJOR_PLACEMENT,
		Name = "Civ Placement",
		ToolTip = "Placement for Major Civilizations",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MajorPlacementValues -- mod dependancy for these values, see the MOD Dependancy section above
	},
	[MINOR_PLACEMENT] = {
		ID = MINOR_PLACEMENT,
		Name = "CS Placement",
		ToolTip = "Placement for City States",
		Disabled = false,
		DefaultValue = 1,
		SortPriority = 2,
		Values = MinorPlacementValues -- mod dependency for these values, see the MOD Dependency section above
	},
	[MINOR_DISTANCE] = {
			ID = MINOR_DISTANCE,
			Name = "CS Separation",
			ToolTip = "City States minimum separation distance: a city that starts under the minimum distance will be removed from the game",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 2,
			Values = { 
				{ Name	= "Don't check", ToolTip = "Allow City States starting positions to overlap. Not recommanded", Value = MINOR_DISTANCE_NO,},
				{ Name	= "Minimum", ToolTip = "3 tiles", Value = MINOR_DISTANCE_MINI,},
				{ Name	= "Close", ToolTip = "~ 5 tiles", Value = MINOR_DISTANCE_CLOSE,},
				{ Name	= "Medium", ToolTip = "~ 7 tiles", Value = MINOR_DISTANCE_MEDIUM,},
				{ Name	= "Away", ToolTip = "~ 9 tiles", Value = MINOR_DISTANCE_AWAY,},
			},
	},
	[RESOURCE_QUANTITY] = {
			ID = RESOURCE_QUANTITY,
			Name = "Resources",
			ToolTip = "Resources quantity",
			Disabled = false,
			DefaultValue = 3,
			SortPriority = 3,
			Values = { 
				{ Name	= "Poor", ToolTip = "Resources are extremly rare", Value = RESOURCE_POOR,},
				{ Name	= "Sparse", ToolTip = "Less resources", Value = RESOURCE_SPARSE,},
				{ Name	= "Standard", ToolTip = "Standard value", Value = RESOURCE_STANDARD,},
				{ Name	= "Abundant", ToolTip = "More resources", Value = RESOURCE_ABUNDANT,},
				{ Name	= "Riche", ToolTip = "I've said : Give me more resources !!!", Value = RESOURCE_RICHE,},
			},
	},
},
}
---------------
---------------
g_MapCheckboxOptions = {
---------------- 
[GIANT_EARTH] = {
	{
		ID = BOSPHORUS,
		Name = "Bosphorus Strait is a sea",
		ToolTip = "If checked, will use a sea tile for Bosphorus, else it will be a river",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	
		-- mod dependancy for NO_US option
		NoUSOption

	,	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_DEPOSIT,
		Name = "Add major deposits of strategic resources",
		ToolTip = "Place some heavy deposits in specified regions",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[HUGE_EARTH] = {
	{
		ID = BOSPHORUS,
		Name = "Bosphorus Strait is a sea",
		ToolTip = "If checked, will use a sea tile for Bosphorus, else it will be a river",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	{
		ID = NO_US,
		Name = "Only native American",
		ToolTip = "Will remove United States and Brazil at game start if it was (randomly or not) selected, keeping only native american civilizations",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_DEPOSIT,
		Name = "Add major deposits of strategic resources",
		ToolTip = "Place some heavy deposits in specified regions",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[STANDARD_CORDIFORM_EARTH] = {
	{
		ID = BOSPHORUS,
		Name = "Bosphorus Strait is a sea",
		ToolTip = "If checked, will use a sea tile for Bosphorus, else it will be a river",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	{
		ID = NO_US,
		Name = "Only native American",
		ToolTip = "Will remove United States and Brazil at game start if it was (randomly or not) selected, keeping only native american civilizations",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
---------------- 
[LARGE_EUROPE] = {
	{
		ID = BOSPHORUS,
		Name = "Bosphorus Strait is a sea",
		ToolTip = "If checked, will use a sea tile for Bosphorus, else it will be a river",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
---------------- 
[STANDARD_WESTERN_MEDITERRANEAN] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resources placement",
		ToolTip = "Force resources to be placed in the correct geographic region (exclude from specified regions)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_DEPOSIT,
		Name = "Add specific resources in regions",
		ToolTip = "Place requested resources in regions (force minimal placement in a region)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[LARGE_MEDITERRANEAN] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resources placement",
		ToolTip = "Force resources to be placed in the correct geographic region (exclude from specified regions)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_DEPOSIT,
		Name = "Add specific resources in regions",
		ToolTip = "Place requested resources in regions (force minimal placement in a region)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
---------------- 
[STANDARD_EASTERN_MEDITERRANEAN] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resources placement",
		ToolTip = "Force resources to be placed in the correct geographic region (exclude from specified regions)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_DEPOSIT,
		Name = "Add specific resources in regions",
		ToolTip = "Place requested resources in regions (force minimal placement in a region)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[LARGE_EASTERN_MEDITERRANEAN] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resources placement",
		ToolTip = "Force resources to be placed in the correct geographic region (exclude from specified regions)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_DEPOSIT,
		Name = "Add specific resources in regions",
		ToolTip = "Place requested resources in regions (force minimal placement in a region)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[LARGE_GREATEST_EARTH] = {
	{
		ID = BOSPHORUS,
		Name = "Bosphorus Strait is a sea",
		ToolTip = "If checked, will use a sea tile for Bosphorus, else it will be a river",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	{
		ID = NO_US,
		Name = "Only native American",
		ToolTip = "Will remove United States and Brazil at game start if it was (randomly or not) selected, keeping only native american civilizations",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},		{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
---------------- 
[STANDARD_AMERICA] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resources placement",
		ToolTip = "Force resources to be placed in the correct geographic region (exclude from specified regions)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_DEPOSIT,
		Name = "Add specific resources in regions",
		ToolTip = "Place requested resources in regions (force minimal placement in a region)",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[GIANT_EUROPE] = {
	{
		ID = BOSPHORUS,
		Name = "Bosphorus Strait is a sea",
		ToolTip = "If checked, will use a sea tile for Bosphorus, else it will be a river",
		Disabled = false,
		GameOption = false,
		SortPriority = 0,
	},	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[APENNINE] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[EAST_ASIA] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[BRITISH_ISLES] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[NORTHEAST_ASIA] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[AEGEAN] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[NORTH_ATLANTIC] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[PACIFIC] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[SOUTH_PACIFIC] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[NORTHWEST_EUROPE] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[CARIBBEAN] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[ASIA] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[MEDITERRANEAN] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[MESOPOTAMIA] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[LARGE_AFRICA] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[NILE_VALLEY] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
[AMERICAS] = {
	{
		ID = RESOURCE_GEO,
		Name = "Use true geographic resource placement",
		ToolTip = "Force resources to be placed in the correct geographic region",
		Disabled = false,
		GameOption = false,
		SortPriority = 1,
	},	{
		ID = RESOURCE_SCALE,
		Name = "Don't scale resources with players",
		ToolTip = "The number of resources won't be scaled depending of the number of players",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},	{
		ID = RESOURCE_REQUESTED,
		Name = "Add specific resources at starting positions",
		ToolTip = "Place historic resources for each civilization",
		Disabled = false,
		GameOption = false,
		SortPriority = 2,
	},
},
----------------
}

--print ("---- YnAEMP defines loaded -----")