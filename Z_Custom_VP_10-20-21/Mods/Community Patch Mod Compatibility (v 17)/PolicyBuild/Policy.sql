INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
SELECT 'POLICY_ICONATLAS', 256, 'POLICY_ICONATLAS256.dds', 8, 8 UNION ALL
SELECT 'POLICY_ICONATLAS', 128, 'POLICY_ICONATLAS128.dds', 8, 8 UNION ALL
SELECT 'POLICY_ICONATLAS', 80, 'POLICY_ICONATLAS80.dds', 8, 8 UNION ALL
SELECT 'POLICY_ICONATLAS', 64, 'POLICY_ICONATLAS64.dds', 8, 8 UNION ALL
SELECT 'POLICY_ICONATLAS', 45, 'POLICY_ICONATLAS45.dds', 8, 8
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Tradition[ENDCOLOR] focuses on generating Great People and the construction of an impressive Capital.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Tradition grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] +3 [ICON_FOOD] Food, +1 [ICON_CULTURE] Culture, and +2 [ICON_CITIZEN] Population in the [ICON_CAPITAL] Capital. [NEWLINE][ICON_BULLET]+1 [ICON_CULTURE] Culture in the Capital for every 2 [ICON_CITIZEN] Citizens. [NEWLINE][ICON_BULLET] +5% [ICON_FOOD] Growth in all Cities.[NEWLINE] [ICON_BULLET] Unlocks the [COLOR_CYAN]Saunas[ENDCOLOR][NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Tradition policy unlocked grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] +5% [ICON_FOOD] Growth in all Cities, and +1 [ICON_FOOD] Food in your [ICON_CAPITAL] Capital.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all Policies in Tradition grants:[ENDCOLOR][NEWLINE][ICON_BULLET] Unlocks building the [COLOR_CYAN]University of Sankore[ENDCOLOR]. [NEWLINE][ICON_BULLET] +1 [ICON_FOOD] Food from all Great Person Improvements and Landmarks, and [COLOR_CYAN]Throne Room[ENDCOLOR] built in [ICON_CAPITAL] Capital (+10% to all Yields, 1 Musician Specialist, 1 [ICON_GREAT_WORK] Great Work of Music slot, [ICON_GOLDEN_AGE] Golden Ages last 25% longer).[NEWLINE][ICON_BULLET] Allows for the purchase of [ICON_GREAT_ENGINEER] Great Engineers with [ICON_PEACE] Faith starting in the Industrial Era.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_TRADITION_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Progress[ENDCOLOR] is best for civilizations which desire robust infrastructure and scientific advancement.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Progress grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] Receive 20 [ICON_RESEARCH] Science when a [ICON_CITIZEN] Citizen is born in your [ICON_CAPITAL] Capital.[NEWLINE][ICON_BULLET] Receive 15 [ICON_RESEARCH] Science for every [ICON_CITIZEN] Citizen already in your [ICON_CAPITAL] Capital, scaling with Era. [NEWLINE][ICON_BULLET] Receive 15 [ICON_CULTURE] Culture when a Technology is researched, scaling with Era, and 15 [ICON_CULTURE] Culture per Technology already unlocked (not scaling with Era).[NEWLINE] [ICON_BULLET] Unlocks the [COLOR_CYAN]Town Councils[ENDCOLOR].[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Progress policy unlocked grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] Gain an additional 10 [ICON_CULTURE] Culture when a Technology is researched, scaling with Era.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all policies in Progress grants:[ENDCOLOR][NEWLINE][ICON_BULLET] Unlocks building the [COLOR_CYAN]Forbidden Palace[ENDCOLOR]. [NEWLINE][ICON_BULLET] Receive 15 [ICON_GOLD] Gold when a [ICON_CITIZEN] Citizen is born in any city, scaling with Era.[NEWLINE][ICON_BULLET] Allows for the purchase of [ICON_GREAT_WRITER] Great Writers with [ICON_PEACE] Faith starting in the Industrial Era.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_LIBERTY_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Authority[ENDCOLOR] will greatly benefit warlike and expansionist civilizations.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Authority grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] +25% combat bonus VS Barbarians, and receive announcements when Barbarian Camps spawn in revealed territory. [NEWLINE][ICON_BULLET] Gain [ICON_CULTURE] Culture when you kill Units and clear Barbarian Camps.[NEWLINE][ICON_BULLET] +1 [ICON_PRODUCTION] Production in every City.[NEWLINE][ICON_BULLET] Unlocks the [COLOR_CYAN]Strongholds[ENDCOLOR][NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Authority policy unlocked grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] +1 [ICON_PRODUCTION] Production in every City.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all policies in Authority grants:[ENDCOLOR][NEWLINE][ICON_BULLET] Unlocks building [COLOR_CYAN]Alhambra[ENDCOLOR]. [NEWLINE][ICON_BULLET]Yields from [COLOR_POSITIVE_TEXT]Tribute[ENDCOLOR] Policy doubled.[NEWLINE][ICON_BULLET]Allows the purchasing of Landsknechts, Foreign Legions, and Mercenaries as their prerequisite technologies are researched.[NEWLINE][ICON_BULLET] Allows for the purchase of [ICON_GREAT_GENERAL] Great Generals with [ICON_PEACE] Faith starting in the Industrial Era.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_HONOR_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Fealty[ENDCOLOR] is best for empires focused on [ICON_RELIGION] Religion, City [ICON_PRODUCTION] Infrastructure, and [ICON_FOOD] Growth.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Fealty grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] Can purchase Monasteries with [ICON_PEACE] Faith (+1 [ICON_PEACE] Faith, +3 [ICON_FOOD] Food, +3 [ICON_RESEARCH] Science).[NEWLINE][ICON_BULLET] -25% [ICON_PEACE] Faith costs for purchasing Buildings, Missionaries, and Inquisitors.[NEWLINE][ICON_BULLET] Unlocks the [COLOR_CYAN]Manor Houses[ENDCOLOR].[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Fealty policy unlocked grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] +1 [ICON_FOOD] Food and +3 [ICON_STRENGTH] Defense in every City.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all Policies in Fealty grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] Unlocks building the [COLOR_CYAN]Red Fort[ENDCOLOR].[NEWLINE][ICON_BULLET] The [ICON_TOURISM] Tourism modifier for [COLOR_POSITIVE_TEXT]Shared Religion[ENDCOLOR] is increased by 25%.[NEWLINE][ICON_BULLET] Cities that follow your [ICON_RELIGION] Majority Religion generate +3 [ICON_RESEARCH] Science, [ICON_PEACE] Faith, [ICON_PRODUCTION] Production, and [ICON_CULTURE] Culture.[NEWLINE][ICON_BULLET] Allows for the purchase of [ICON_GREAT_ARTIST] Great Artists with [ICON_PEACE] Faith starting in the Industrial Era.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_PIETY_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Statecraft[ENDCOLOR] improves your ability to benefit from [ICON_INTERNATIONAL_TRADE] Trade Routes, [ICON_CITY_STATE] City-States, [ICON_SPY] Spies, and [ICON_DIPLOMAT] the World Congress.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Statecraft grants:[ENDCOLOR][NEWLINE][ICON_BULLET] +1 of every Yield in [ICON_CAPITAL] Capital for every 15 [ICON_CITIZEN] Citizens in your Empire.[NEWLINE][ICON_BULLET] +1 [ICON_GOLD] Gold in every City.[NEWLINE][ICON_BULLET] Unlocks the [COLOR_CYAN]State Embassy[ENDCOLOR][NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Statecraft policy unlocked grants:[ENDCOLOR] [NEWLINE][ICON_BULLET]+10% [ICON_INFLUENCE] Influence from Trade Missions, and +1 [ICON_GOLD] Gold in every City.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all policies in Statecraft grants:[ENDCOLOR][NEWLINE][ICON_BULLET] Unlocks building the [COLOR_CYAN]Palace of Westminster[ENDCOLOR]. [NEWLINE][ICON_BULLET] Every World Congresss Session, gain [ICON_CULTURE] Culture, [ICON_RESEARCH] Science, and [ICON_GOLD] Gold based on the number of [ICON_DIPLOMAT] Delegates you control, scaling with Era.[NEWLINE][ICON_BULLET] World Wonders require 1 less unlocked Policy for every 3 City-State alliances you maintain.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_PATRONAGE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Artistry[ENDCOLOR] allows you to maximize the potential of [ICON_GREAT_WORK] Great Works, [ICON_GREAT_PEOPLE] Great People, and [ICON_GOLDEN_AGE] Golden Ages.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Artistry grants:[ENDCOLOR][NEWLINE][ICON_BULLET] +25% [ICON_GREAT_PEOPLE] Great Person rates in all cities.[NEWLINE][ICON_BULLET]+100% [ICON_PRODUCTION] construction rate of all Guilds.[NEWLINE][ICON_BULLET] Unlocks the [COLOR_CYAN]Memorials[ENDCOLOR].[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Artistry policy unlocked grants:[ENDCOLOR][NEWLINE][ICON_BULLET] +2 [ICON_GOLDEN_AGE] Golden Age Points and +1 [ICON_RESEARCH] Science in every City.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all policies in Artistry grants:[ENDCOLOR][NEWLINE][ICON_BULLET] Unlocks building the [COLOR_CYAN]Louvre[ENDCOLOR]. [NEWLINE][ICON_BULLET] Completing an Archaeological Dig or starting a [ICON_GOLDEN_AGE] Golden Age generates [ICON_TOURISM] Tourism with all known Civilizations. [NEWLINE][ICON_BULLET] Allows you to see Hidden Antiquity Sites, and Landmarks gain +3 [ICON_RESEARCH] Science and [ICON_GOLDEN_AGE] Golden Age Points. [NEWLINE][ICON_BULLET] Allows for the purchase of [ICON_GREAT_MUSICIAN] Great Musicians with [ICON_PEACE] Faith starting in the Industrial Era.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_AESTHETICS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Industry[ENDCOLOR] provides bonuses to empires focused on [ICON_GOLD] Gold and [ICON_PRODUCTION] Production.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Industry grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] 10 [ICON_GOLD] Gold every time you construct a building. Scales with Era. [NEWLINE][ICON_BULLET] -5% [ICON_GOLD] Gold needed for purchases.[NEWLINE][ICON_BULLET] Unlocks the [COLOR_CYAN]Depots[ENDCOLOR][NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Industry policy unlocked grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] -5% [ICON_GOLD] Gold needed for purchases.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all Policies in Industry grants:[ENDCOLOR][NEWLINE][ICON_BULLET] Unlocks building [COLOR_CYAN]Broadway[ENDCOLOR]. [NEWLINE][ICON_BULLET] +1 [ICON_HAPPINESS_1] Happiness for every owned Luxury. [NEWLINE][ICON_BULLET] Specialists gain +1 [ICON_PRODUCTION] Production and [ICON_GOLD] Gold.[NEWLINE][ICON_BULLET] Allows for the purchase of [ICON_GREAT_MERCHANT] Great Merchants with [ICON_PEACE] Faith starting in the Industrial Era.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_COMMERCE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Imperialism[ENDCOLOR] enhances your ability to spread your empire through military power, particularly naval (and later air) supremacy.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Imperialism grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] +1 [ICON_MOVES] Movement for Naval units, Embarked units, and [ICON_GREAT_GENERAL] Great Generals, as well as +1 Sight for Naval melee and Land melee units. [NEWLINE][ICON_BULLET] +10% [ICON_PRODUCTION] Production for Military Units, -10% [ICON_GOLD] Gold required for upgrades.[NEWLINE][ICON_BULLET] Unlocks the [COLOR_CYAN]Botanical Gardens[ENDCOLOR].[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Imperialism policy unlocked grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] +5% [ICON_PRODUCTION] Production for Military Units, -5% [ICON_GOLD] Gold required for upgrades.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all policies in Imperialism grants:[ENDCOLOR][NEWLINE][ICON_BULLET] Unlocks building the [COLOR_CYAN]Pentagon[ENDCOLOR]. [NEWLINE][ICON_BULLET] Each Air Unit stationed in a city increases the City''s [ICON_STRENGTH] Defense by 3, and reduces [ICON_HAPPINESS_3] Unhappiness from Needs by 2%.[NEWLINE][ICON_BULLET]All Naval units gain the [COLOR_POSITIVE_TEXT]Ironsides[ENDCOLOR] Promotion (become stronger as they take damage).[NEWLINE][ICON_BULLET] Allows for the purchase of [ICON_GREAT_ADMIRAL] Great Admirals with [ICON_PEACE] Faith starting in the Industrial Era.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_EXPLORATION_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Rationalism[ENDCOLOR] focuses on maximizing [ICON_FOOD] Growth and [ICON_RESEARCH] Science output.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting Rationalism grants:[ENDCOLOR][NEWLINE][ICON_BULLET] +3 [ICON_RESEARCH] Science and +2 [ICON_PRODUCTION] Production from all Strategic Resources.[NEWLINE][ICON_BULLET] +5% [ICON_RESEARCH] Science, and -3% [ICON_HAPPINESS_3] Unhappiness Threshold for all Needs.[NEWLINE][ICON_BULLET] Unlocks the [COLOR_CYAN]Patent Offices[ENDCOLOR].[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Each Rationalism policy unlocked grants:[ENDCOLOR] [NEWLINE][ICON_BULLET] +1% [ICON_RESEARCH] Science, and -1% [ICON_HAPPINESS_3] Unhappiness Threshold for all Needs.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Adopting all Policies in Rationalism grants:[ENDCOLOR][NEWLINE][ICON_BULLET] Unlocks building [COLOR_CYAN]Bletchley Park[ENDCOLOR]. [NEWLINE][ICON_BULLET] +33% [ICON_GREAT_SCIENTIST] Great Scientist rate in all cities. [NEWLINE][ICON_BULLET] +25% [ICON_FOOD] Growth in all cities.[NEWLINE][ICON_BULLET] Allows for the purchase of [ICON_GREAT_SCIENTIST] Great Scientists with [ICON_PEACE] Faith starting in the Industrial Era.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_RATIONALISM_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

INSERT INTO LocalizedText
	(Language, Tag, Text)
VALUES
	('en_US', 'TXT_KEY_BUILDING_TCS_PUBLIC_BATHS', 'Sauna'),
	('en_US', 'TXT_KEY_BUILDING_TCS_TOWN_COUNCIL', 'Town Council'),
	('en_US', 'TXT_KEY_BUILDING_TCS_STRONGHOLD', 'Stronghold'),
	('en_US', 'TXT_KEY_BUILDING_TCS_PAROCHIAL_SCHOOL', 'Manor House'),
	('en_US', 'TXT_KEY_BUILDING_TCS_CHANCERY', 'State Embassy'),
	('en_US', 'TXT_KEY_BUILDING_TCS_MEMORIAL', 'Memorial'),
	('en_US', 'TXT_KEY_BUILDING_TCS_DEPOT', 'Depot'),
	('en_US', 'TXT_KEY_BUILDING_TCS_BOTANICAL_GARDENS', 'Botanical Gardens'),
	('en_US', 'TXT_KEY_BUILDING_TCS_PATENT_OFFICE', 'Patent Office'),
	('en_US', 'TXT_KEY_BUILDING_TCS_PUBLIC_BATHS_HELP', '+1 [ICON_CULTURE] Culture. +1 [ICON_FOOD] Food for every 3 [ICON_CITIZEN] Population.[NEWLINE][NEWLINE]Requires Tradition.'),
	('en_US', 'TXT_KEY_BUILDING_TCS_TOWN_COUNCIL_HELP', '+1 [ICON_CULTURE] Culture for every 4 [ICON_CITIZEN] Population. Gain 20% of the [ICON_CULTURE] Culture output of the City as an instant boost to your current culture when a [ICON_CITIZEN] Citizen is born in this City. -10% [ICON_CULTURE] Culture cost of acquiring new tiles.[NEWLINE][NEWLINE]Requires Progress.'),
	('en_US', 'TXT_KEY_BUILDING_TCS_STRONGHOLD_HELP', '+1 [ICON_PRODUCTION] Production to Forts and Citadels. +5 XP for all units trained in this City. +5 [ICON_STRENGTH] Defense. [NEWLINE][NEWLINE]Requires Authority.'),
	('en_US', 'TXT_KEY_BUILDING_TCS_PAROCHIAL_SCHOOL_HELP', '+2 [ICON_PEACE] Faith. Gain 50% of the [ICON_FOOD] Food, [ICON_PRODUCTION] Production and [ICON_GOLD] Gold output of the City as an instant boost to your current yields. [NEWLINE][NEWLINE]Requires Fealty.'),
	('en_US', 'TXT_KEY_BUILDING_TCS_CHANCERY_HELP', '+1 [ICON_CITY_STATE] World Congress Vote. +5 [ICON_GOLD] Gold, [ICON_CULTURE] Culture, and [ICON_RESEARCH] Science. Can only be built in the capital. [NEWLINE][NEWLINE]Requires Statecraft.'),
	('en_US', 'TXT_KEY_BUILDING_TCS_MEMORIAL_HELP', '+3 [ICON_TOURISM] Tourism. Contain one slot for an Artist.[NEWLINE][NEWLINE]Requires Artistry.'),
	('en_US', 'TXT_KEY_BUILDING_TCS_DEPOT_HELP', '+2 [ICON_PRODUCTION] Production. +1 [ICON_PRODUCTION] Production and +1 [ICON_GOLD] Gold for every 4 [ICON_CITIZEN] Population. Contain one slot for a Merchant.[NEWLINE][NEWLINE]Requires Industry.'),
	('en_US', 'TXT_KEY_BUILDING_TCS_BOTANICAL_GARDENS_HELP', 'Reduces [ICON_HAPPINESS_3] Poverty and Distress. +3 [ICON_GOLDEN_AGE] Golden Age Points. Contain one slot for an Engineer.[NEWLINE][NEWLINE]Requires Imperialism.'),
	('en_US', 'TXT_KEY_BUILDING_TCS_PATENT_OFFICE_HELP', '+4 [ICON_RESEARCH] Science. +1 [ICON_GOLD] Gold for every 8 Citizens. Contain one slot for a Scientist.[NEWLINE][NEWLINE]Requires Rationalism.');

INSERT INTO BuildingClasses (Type, DefaultBuilding, Description)
	SELECT 'BUILDINGCLASS_TCS_PUBLIC_BATHS', 'BUILDING_TCS_PUBLIC_BATHS', 'TXT_KEY_BUILDING_TCS_PUBLIC_BATHS' WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDINGCLASS_TCS_TOWN_COUNCIL', 'BUILDING_TCS_TOWN_COUNCIL', 'TXT_KEY_BUILDING_TCS_TOWN_COUNCIL' WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDINGCLASS_TCS_STRONGHOLD', 'BUILDING_TCS_STRONGHOLD', 'TXT_KEY_BUILDING_TCS_STRONGHOLD' WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDINGCLASS_TCS_PAROCHIAL_SCHOOL', 'BUILDING_TCS_PAROCHIAL_SCHOOL', 'TXT_KEY_BUILDING_TCS_PAROCHIAL_SCHOOL' WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDINGCLASS_TCS_CHANCERY', 'BUILDING_TCS_CHANCERY', 'TXT_KEY_BUILDING_TCS_CHANCERY' WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDINGCLASS_TCS_MEMORIAL', 'BUILDING_TCS_MEMORIAL', 'TXT_KEY_BUILDING_TCS_MEMORIAL' WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDINGCLASS_TCS_DEPOT', 'BUILDING_TCS_DEPOT', 'TXT_KEY_BUILDING_TCS_DEPOT' WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDINGCLASS_TCS_BOTANICAL_GARDENS', 'BUILDING_TCS_BOTANICAL_GARDENS', 'TXT_KEY_BUILDING_TCS_BOTANICAL_GARDENS' WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDINGCLASS_TCS_PATENT_OFFICE', 'BUILDING_TCS_PATENT_OFFICE', 'TXT_KEY_BUILDING_TCS_PATENT_OFFICE'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

INSERT INTO Buildings (Type, BuildingClass, Cost, GoldMaintenance, PrereqTech, PolicyBranchType, Description, Help, MinAreaSize, NukeImmune, NeverCapture, HurryCostModifier, IconAtlas, PortraitIndex)
	SELECT 'BUILDING_TCS_PUBLIC_BATHS', 'BUILDINGCLASS_TCS_PUBLIC_BATHS', 75, 1, NULL, 'POLICY_BRANCH_TRADITION', 'TXT_KEY_BUILDING_TCS_PUBLIC_BATHS', 'TXT_KEY_BUILDING_TCS_PUBLIC_BATHS_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 0 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_TOWN_COUNCIL', 'BUILDINGCLASS_TCS_TOWN_COUNCIL', 75, 1, NULL, 'POLICY_BRANCH_LIBERTY', 'TXT_KEY_BUILDING_TCS_TOWN_COUNCIL', 'TXT_KEY_BUILDING_TCS_TOWN_COUNCIL_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_STRONGHOLD', 'BUILDINGCLASS_TCS_STRONGHOLD', 75, 0, NULL, 'POLICY_BRANCH_HONOR', 'TXT_KEY_BUILDING_TCS_STRONGHOLD', 'TXT_KEY_BUILDING_TCS_STRONGHOLD_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 2 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PAROCHIAL_SCHOOL', 'BUILDINGCLASS_TCS_PAROCHIAL_SCHOOL', 200, 0, NULL, 'POLICY_BRANCH_PIETY', 'TXT_KEY_BUILDING_TCS_PAROCHIAL_SCHOOL', 'TXT_KEY_BUILDING_TCS_PAROCHIAL_SCHOOL_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_CHANCERY', 'BUILDINGCLASS_TCS_CHANCERY', 350, 1, NULL, 'POLICY_BRANCH_PATRONAGE', 'TXT_KEY_BUILDING_TCS_CHANCERY', 'TXT_KEY_BUILDING_TCS_CHANCERY_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 4 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_MEMORIAL', 'BUILDINGCLASS_TCS_MEMORIAL', 200, 1, NULL, 'POLICY_BRANCH_AESTHETICS', 'TXT_KEY_BUILDING_TCS_MEMORIAL', 'TXT_KEY_BUILDING_TCS_MEMORIAL_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_DEPOT', 'BUILDINGCLASS_TCS_DEPOT', 400, NULL, NULL, 'POLICY_BRANCH_COMMERCE', 'TXT_KEY_BUILDING_TCS_DEPOT', 'TXT_KEY_BUILDING_TCS_DEPOT_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 6 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_BOTANICAL_GARDENS', 'BUILDINGCLASS_TCS_BOTANICAL_GARDENS', 400, 0, NULL, 'POLICY_BRANCH_EXPLORATION', 'TXT_KEY_BUILDING_TCS_BOTANICAL_GARDENS', 'TXT_KEY_BUILDING_TCS_BOTANICAL_GARDENS_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 7 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PATENT_OFFICE', 'BUILDINGCLASS_TCS_PATENT_OFFICE', 400, 2, NULL, 'POLICY_BRANCH_RATIONALISM', 'TXT_KEY_BUILDING_TCS_PATENT_OFFICE', 'TXT_KEY_BUILDING_TCS_PATENT_OFFICE_HELP', -1, 1, 1, 25, 'POLICY_ICONATLAS', 8
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND VALUE= 1);

INSERT INTO Building_ClassesNeededInCity (BuildingType, BuildingClassType)
	SELECT 'BUILDING_TCS_CHANCERY', 'BUILDINGCLASS_PALACE'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND VALUE= 1);

INSERT INTO Building_DomainFreeExperiences (BuildingType, DomainType, Experience)
	SELECT 'BUILDING_TCS_STRONGHOLD', 'DOMAIN_LAND', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_STRONGHOLD', 'DOMAIN_SEA', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_STRONGHOLD', 'DOMAIN_AIR', 5
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

INSERT INTO Building_YieldChanges (BuildingType, YieldType, Yield)
	SELECT 'BUILDING_TCS_PUBLIC_BATHS', 'YIELD_CULTURE', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PAROCHIAL_SCHOOL', 'YIELD_FAITH', 2 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_CHANCERY', 'YIELD_CULTURE', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_CHANCERY', 'YIELD_SCIENCE', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_CHANCERY', 'YIELD_GOLD', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_MEMORIAL', 'YIELD_TOURISM', 3 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_DEPOT', 'YIELD_PRODUCTION', 2 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_BOTANICAL_GARDENS', 'YIELD_GOLDEN_AGE_POINTS', 3 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PATENT_OFFICE', 'YIELD_SCIENCE', 4
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

INSERT INTO Building_YieldChangesPerPop (BuildingType, YieldType, Yield)
	SELECT 'BUILDING_TCS_PUBLIC_BATHS', 'YIELD_FOOD', 34 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_TOWN_COUNCIL', 'YIELD_CULTURE', 25 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_DEPOT', 'YIELD_GOLD', 25 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_DEPOT', 'YIELD_PRODUCTION', 25 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PATENT_OFFICE', 'YIELD_GOLD', 13
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

INSERT INTO Building_ImprovementYieldChanges (BuildingType, ImprovementType, YieldType, Yield)
	SELECT 'BUILDING_TCS_STRONGHOLD', 'IMPROVEMENT_FORT', 'YIELD_PRODUCTION', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_STRONGHOLD', 'IMPROVEMENT_CITADEL', 'YIELD_PRODUCTION', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

INSERT INTO Building_Flavors (BuildingType, FlavorType, Flavor)
	SELECT 'BUILDING_TCS_PUBLIC_BATHS', 'FLAVOR_GROWTH', 15 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PUBLIC_BATHS', 'FLAVOR_CULTURE', 10 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_TOWN_COUNCIL', 'FLAVOR_EXPANSION', 15 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_TOWN_COUNCIL', 'FLAVOR_CULTURE', 15 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_STRONGHOLD', 'FLAVOR_CITY_DEFENSE', 20 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_STRONGHOLD', 'FLAVOR_MILITARY_TRAINING', 20 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_STRONGHOLD', 'FLAVOR_OFFENSE', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PAROCHIAL_SCHOOL', 'FLAVOR_RELIGION', 20 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_CHANCERY', 'FLAVOR_PRODUCTION', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_CHANCERY', 'FLAVOR_GOLD', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_CHANCERY', 'FLAVOR_CULTURE', 5 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_CHANCERY', 'FLAVOR_DIPLOMACY', 15 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_MEMORIAL', 'FLAVOR_CULTURE', 20 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_DEPOT', 'FLAVOR_GOLD', 10 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_DEPOT', 'FLAVOR_PRODUCTION', 15 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_BOTANICAL_GARDENS', 'FLAVOR_HAPPINESS', 10 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PATENT_OFFICE', 'FLAVOR_SCIENCE', 20 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
	SELECT 'BUILDING_TCS_PATENT_OFFICE', 'FLAVOR_GOLD', 5
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

INSERT INTO Building_GrowthExtraYield (BuildingType, YieldType, Yield)
SELECT 'BUILDING_TCS_TOWN_COUNCIL', 'YIELD_CULTURE', 20 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
SELECT 'BUILDING_TCS_PAROCHIAL_SCHOOL', 'YIELD_FOOD', 50 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
SELECT 'BUILDING_TCS_PAROCHIAL_SCHOOL', 'YIELD_PRODUCTION', 50 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) UNION ALL
SELECT 'BUILDING_TCS_PAROCHIAL_SCHOOL', 'YIELD_GOLD', 50 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Buildings
SET FaithCost = 200
WHERE Type = 'BUILDING_TCS_PAROCHIAL_SCHOOL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Buildings
SET SpecialistCount = 3, SingleLeagueVotes = 1
WHERE Type = 'BUILDING_TCS_CHANCERY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_MERCHANT'
WHERE Type = 'BUILDING_TCS_CHANCERY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) AND NOT EXISTS (SELECT * FROM CSD WHERE Type='CSD_DIFFICULTY');

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_CIVIL_SERVANT'
WHERE Type = 'BUILDING_TCS_CHANCERY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1) AND EXISTS (SELECT * FROM CSD WHERE Type='CSD_DIFFICULTY');

UPDATE Buildings
SET SpecialistCount = 2, SingleLeagueVotes = 1
WHERE Type = 'BUILDING_TCS_CHANCERY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Buildings
SET PlotCultureCostModifier = -10
WHERE Type = 'BUILDING_TCS_TOWN_COUNCIL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Buildings
SET Defense = 500
WHERE Type = 'BUILDING_TCS_STRONGHOLD' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_ARTIST', SpecialistCount = 1
WHERE Type = 'BUILDING_TCS_MEMORIAL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_MERCHANT', SpecialistCount = 1
WHERE Type = 'BUILDING_TCS_DEPOT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);			

UPDATE Buildings
SET PovertyHappinessChange = -10, DefenseHappinessChange = -10, SpecialistType = 'SPECIALIST_ENGINEER', SpecialistCount = 1
WHERE Type = 'BUILDING_TCS_BOTANICAL_GARDENS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_SCIENTIST', SpecialistCount = 1
WHERE Type = 'BUILDING_TCS_PATENT_OFFICE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLICY' AND Value= 1);