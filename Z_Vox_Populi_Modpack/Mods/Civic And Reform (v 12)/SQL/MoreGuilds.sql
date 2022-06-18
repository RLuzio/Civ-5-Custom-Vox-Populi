INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
SELECT 'MORE_SPECIALIST_ATLAS', 256, 'SpecialistAtlas256.dds', 4, 2 UNION ALL
SELECT 'MORE_SPECIALIST_ATLAS', 128, 'SpecialistAtlas128.dds', 4, 2 UNION ALL
SELECT 'MORE_SPECIALIST_ATLAS', 80, 'SpecialistAtlas80.dds', 4, 2 UNION ALL
SELECT 'MORE_SPECIALIST_ATLAS', 64, 'SpecialistAtlas64.dds', 4, 2 UNION ALL
SELECT 'MORE_SPECIALIST_ATLAS', 45, 'SpecialistAtlas45.dds', 4, 2 UNION ALL
SELECT 'MORE_SPECIALIST_ATLAS', 32, 'SpecialistAtlas32.dds', 4, 2;

INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_BUILDING_ENGINEERS_GUILD', 'Labor Association' UNION ALL
SELECT 'TXT_KEY_BUILDING_MERCHANTS_GUILD', 'Credit Union' UNION ALL
SELECT 'TXT_KEY_BUILDING_SCIENTISTS_GUILD', 'Science Institution' UNION ALL
SELECT 'TXT_KEY_BUILDING_DIPLOMATS_GUILD', 'Civil Department' UNION ALL
SELECT 'TXT_KEY_BUILDING_PUBLICAN_OFFICE', 'Publican''s Office' UNION ALL
SELECT 'TXT_KEY_BUILDING_ENGINEERS_GUILD_HELP', 'Provides 3 [ICON_GREAT_PEOPLE] Great Person Points (GPP) towards a Great Engineer. Add up to one specialist to this building to gain [ICON_PRODUCTION] Production and increase the rate of Great Engineer acquisition. Workshops increase the [ICON_GOLD] Gold value of the Labor Association by +1.[NEWLINE]+10% [ICON_PRODUCTION] Production in this City.[NEWLINE][NEWLINE]Maximum of 3 of these buildings in your Empire.' UNION ALL
SELECT 'TXT_KEY_BUILDING_MERCHANTS_GUILD_HELP', 'Provides 3 [ICON_GREAT_PEOPLE] Great Person Points (GPP) towards a Great Merchant. Add up to one specialist to this building to gain [ICON_GOLD] Gold and increase the rate of Great Merchant acquisition. Banks increase the [ICON_GOLD] Gold value of the Credit Union by +1.[NEWLINE]Banks produce +5% [ICON_GOLD] Gold.[NEWLINE][NEWLINE]Maximum of 3 of these buildings in your Empire.' UNION ALL
SELECT 'TXT_KEY_BUILDING_SCIENTISTS_GUILD_HELP', 'Provides 3 [ICON_GREAT_PEOPLE] Great Person Points (GPP) towards a Great Scientist. Add up to one specialist to this building to gain [ICON_RESEARCH] Science and increase the rate of Great Scientist acquisition. Research Labs increase the [ICON_GOLD] Gold value of the Science Institution by +1.[NEWLINE]+5% [ICON_GREAT_PEOPLE] Great Person Generation in all Cities.[NEWLINE][NEWLINE]Maximum of 3 of these buildings in your Empire.' UNION ALL
SELECT 'TXT_KEY_BUILDING_DIPLOMATS_GUILD_HELP', 'Provides 3 [ICON_GREAT_PEOPLE] Great Person Points (GPP) towards a Great Diplomat. Add up to one specialist to this building to gain various yields and increase the rate of Great Diplomat acquisition. Wire Services increase the [ICON_GOLD] Gold value of the Civil Department by +1.[NEWLINE]Grants 1 delegate in the World Congress.[NEWLINE][NEWLINE]Maximum of 3 of these buildings in your Empire.' UNION ALL
SELECT 'TXT_KEY_BUILDING_PUBLICAN_OFFICE_HELP', '-25% [ICON_GOLD] Gold Cost when purchasing a tile in this City. -10% [ICON_GOLD] Base Building Maintenance in all Cities.[NEWLINE][NEWLINE]The [ICON_PRODUCTION] Production Cost and [ICON_CITIZEN] Population Requirements increase based on the number of cities you own.' UNION ALL
SELECT 'TXT_KEY_BUILDING_PUBLICAN_OFFICE_PEDIA', 'Publicans were public contractors during antiquity Rome. They supplied the army and military, managed taxes, and oversaw public projects. The legacy of these publicans would inspire how modern government would operate since these people were the first witness to the  challenges with managing large territories and population.';

INSERT INTO BuildingClasses (Type, DefaultBuilding, Description, MaxPlayerInstances)
SELECT 'BUILDINGCLASS_ENGINEERS_GUILD', 'BUILDING_ENGINEERS_GUILD', 'TXT_KEY_BUILDING_ENGINEERS_GUILD', 1 UNION ALL
SELECT 'BUILDINGCLASS_MERCHANTS_GUILD', 'BUILDING_MERCHANTS_GUILD', 'TXT_KEY_BUILDING_MERCHANTS_GUILD', 1 UNION ALL
SELECT 'BUILDINGCLASS_SCIENTISTS_GUILD', 'BUILDING_SCIENTISTS_GUILD', 'TXT_KEY_BUILDING_SCIENTISTS_GUILD', 1 UNION ALL
SELECT 'BUILDINGCLASS_DIPLOMATS_GUILD', 'BUILDING_DIPLOMATS_GUILD', 'TXT_KEY_BUILDING_DIPLOMATS_GUILD', 1 WHERE EXISTS (SELECT * FROM CSD WHERE Type='GIFT_OPTION' AND Value= 2 ) UNION ALL
SELECT 'BUILDINGCLASS_PUBLICAN_OFFICE', 'BUILDING_PUBLICAN_OFFICE', 'TXT_KEY_BUILDING_PUBLICAN_OFFICE', 1;

UPDATE BuildingClasses
SET MaxPlayerInstances = 3
WHERE Type = 'BUILDINGCLASS_ENGINEERS_GUILD' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CIVICS' AND Value= 1 );

UPDATE BuildingClasses
SET MaxPlayerInstances = 3
WHERE Type = 'BUILDINGCLASS_MERCHANTS_GUILD' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CIVICS' AND Value= 1 );

UPDATE BuildingClasses
SET MaxPlayerInstances = 3
WHERE Type = 'BUILDINGCLASS_SCIENTISTS_GUILD' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CIVICS' AND Value= 1 );

UPDATE BuildingClasses
SET MaxPlayerInstances = 3
WHERE Type = 'BUILDINGCLASS_DIPLOMATS_GUILD' AND EXISTS (SELECT * FROM CSD WHERE Type='GIFT_OPTION' AND Value= 2 );

INSERT INTO Buildings (Type, BuildingClass, Cost, Description, Help, GoldMaintenance, HurryCostModifier, MinAreaSize, ArtDefineTag, PrereqTech, SpecialistType, SpecialistCount, GreatPeopleRateChange, IconAtlas, PortraitIndex, NumCityCostMod)
SELECT 'BUILDING_ENGINEERS_GUILD', 'BUILDINGCLASS_ENGINEERS_GUILD', 800, 'TXT_KEY_BUILDING_ENGINEERS_GUILD', 'TXT_KEY_BUILDING_ENGINEERS_GUILD_HELP', 4, 5, -1, 'ART_DEF_BUILDING_BANK', 'TECH_INDUSTRIALIZATION', 'SPECIALIST_ENGINEER', 1, 3, 'MORE_SPECIALIST_ATLAS', 0, 2 UNION ALL
SELECT 'BUILDING_MERCHANTS_GUILD', 'BUILDINGCLASS_MERCHANTS_GUILD', 1000, 'TXT_KEY_BUILDING_MERCHANTS_GUILD', 'TXT_KEY_BUILDING_MERCHANTS_GUILD_HELP', 4, 5, -1, 'ART_DEF_BUILDING_FORGE', 'TECH_REPLACEABLE_PARTS', 'SPECIALIST_MERCHANT', 1, 3, 'MORE_SPECIALIST_ATLAS', 1, 2 UNION ALL
SELECT 'BUILDING_SCIENTISTS_GUILD', 'BUILDINGCLASS_SCIENTISTS_GUILD', 1200, 'TXT_KEY_BUILDING_SCIENTISTS_GUILD', 'TXT_KEY_BUILDING_SCIENTISTS_GUILD_HELP', 4, 5, -1, 'ART_DEF_BUILDING_UNIVERSITY', 'TECH_ATOMIC_THEORY', 'SPECIALIST_SCIENTIST', 1, 3, 'MORE_SPECIALIST_ATLAS', 2, 2 UNION ALL
SELECT 'BUILDING_DIPLOMATS_GUILD', 'BUILDINGCLASS_DIPLOMATS_GUILD', 1400, 'TXT_KEY_BUILDING_DIPLOMATS_GUILD', 'TXT_KEY_BUILDING_DIPLOMATS_GUILD_HELP', 4, 5, -1, 'COURTHOUSE', 'TECH_TELECOM', 'SPECIALIST_CIVIL_SERVANT', 1, 3, 'MORE_SPECIALIST_ATLAS', 3, 2 WHERE EXISTS (SELECT * FROM CSD WHERE Type='GIFT_OPTION' AND Value= 2 );

INSERT INTO Buildings (Type, BuildingClass, Cost, Description, Help, GoldMaintenance, HurryCostModifier, MinAreaSize, ArtDefineTag, PrereqTech, IconAtlas, PortraitIndex, NumCityCostMod)
SELECT 'BUILDING_PUBLICAN_OFFICE', 'BUILDINGCLASS_PUBLICAN_OFFICE', 125, 'TXT_KEY_BUILDING_PUBLICAN_OFFICE', 'TXT_KEY_BUILDING_PUBLICAN_OFFICE_HELP', 0, -20, -1, 'ART_DEF_BUILDING_BANK', 'TECH_CURRENCY', 'MORE_SPECIALIST_ATLAS', 7, 10;

UPDATE Buildings
SET EmpireNeedsModifierGlobal = -4
WHERE Type = 'BUILDING_ENGINEERS_GUILD';

INSERT INTO Building_BuildingClassYieldModifiers (BuildingType, BuildingClassType, YieldType, Modifier)
SELECT 'BUILDING_MERCHANTS_GUILD', 'BUILDINGCLASS_BANK', 'YIELD_GOLD', 5;

UPDATE Buildings
SET GlobalGreatPeopleRateModifier = 5
WHERE Type = 'BUILDING_SCIENTISTS_GUILD';

UPDATE Buildings
SET SingleLeagueVotes = 1
WHERE Type = 'BUILDING_DIPLOMATS_GUILD' AND EXISTS (SELECT * FROM CSD WHERE Type='GIFT_OPTION' AND Value= 2 );

UPDATE Buildings
SET GlobalBuildingGoldMaintenanceMod = -10, PlotBuyCostModifier = -25, Civilopedia = 'TXT_KEY_BUILDING_PUBLICAN_OFFICE_PEDIA', NeverCapture = 1, NukeImmune = 1, NationalPopRequired = 20
WHERE Type = 'BUILDING_PUBLICAN_OFFICE';

INSERT INTO Building_Flavors (BuildingType, FlavorType, Flavor)
SELECT 'BUILDING_ENGINEERS_GUILD', 'FLAVOR_PRODUCTION', 60 UNION ALL
SELECT 'BUILDING_MERCHANTS_GUILD', 'FLAVOR_GOLD', 60 UNION ALL
SELECT 'BUILDING_SCIENTISTS_GUILD', 'FLAVOR_SCIENCE', 60 UNION ALL
SELECT 'BUILDING_DIPLOMATS_GUILD', 'FLAVOR_DIPLOMACY', 60 WHERE EXISTS (SELECT * FROM CSD WHERE Type='GIFT_OPTION' AND Value= 2 ) UNION ALL
SELECT 'BUILDING_PUBLICAN_OFFICE', 'FLAVOR_GOLD', 45;

INSERT INTO Building_YieldChanges (BuildingType, YieldType, Yield)
SELECT 'BUILDING_PUBLICAN_OFFICE', 'YIELD_CULTURE', 1 UNION ALL
SELECT 'BUILDING_PUBLICAN_OFFICE', 'YIELD_GOLD', 1;

INSERT INTO Building_BuildingClassYieldChanges (BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT 'BUILDING_WORKSHOP', 'BUILDINGCLASS_ENGINEERS_GUILD', 'YIELD_GOLD', 1 UNION ALL
SELECT 'BUILDING_BANK', 'BUILDINGCLASS_MERCHANTS_GUILD', 'YIELD_GOLD', 1 UNION ALL
SELECT 'BUILDING_LABORATORY', 'BUILDINGCLASS_SCIENTISTS_GUILD', 'YIELD_GOLD', 1 UNION ALL
SELECT 'BUILDING_WIRE_SERVICE', 'BUILDINGCLASS_DIPLOMATS_GUILD', 'YIELD_GOLD', 1 WHERE EXISTS (SELECT * FROM CSD WHERE Type='GIFT_OPTION' AND Value= 2 );

INSERT INTO Civilization_BuildingClassOverrides  (CivilizationType,		BuildingClassType,					BuildingType)
SELECT 'CIVILIZATION_MINOR', 'BUILDINGCLASS_ENGINEERS_GUILD', NULL UNION ALL
SELECT 'CIVILIZATION_MINOR', 'BUILDINGCLASS_MERCHANTS_GUILD', NULL UNION ALL
SELECT 'CIVILIZATION_MINOR', 'BUILDINGCLASS_SCIENTISTS_GUILD', NULL UNION ALL
SELECT 'CIVILIZATION_MINOR', 'BUILDINGCLASS_DIPLOMATS_GUILD', NULL UNION ALL
SELECT 'CIVILIZATION_MINOR', 'BUILDINGCLASS_PUBLICAN_OFFICE', NULL;