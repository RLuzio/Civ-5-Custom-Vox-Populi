UPDATE Building_YieldChanges
SET Yield = 0
WHERE BuildingType = 'BUILDING_STEMPLES' AND YieldType = 'YIELD_GOLD' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = 3
WHERE BuildingType = 'BUILDING_STEMPLES' AND YieldType = 'YIELD_CULTURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 );

INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_STEMPLES', 'RESOURCE_INCENSE', 'YIELD_CULTURE', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 ) UNION ALL
SELECT 'BUILDING_STEMPLES', 'RESOURCE_INCENSE', 'YIELD_GOLD', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 ) UNION ALL
SELECT 'BUILDING_STEMPLES', 'RESOURCE_WINE', 'YIELD_CULTURE', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 ) UNION ALL
SELECT 'BUILDING_STEMPLES', 'RESOURCE_WINE', 'YIELD_GOLD', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 ) UNION ALL
SELECT 'BUILDING_STEMPLES', 'RESOURCE_STONE', 'YIELD_CULTURE', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 );

INSERT INTO Building_Flavors (BuildingType, FlavorType, Flavor)
SELECT 'BUILDING_STEMPLES', 'FLAVOR_CULTURE', 25
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 );

UPDATE Buildings
SET MinorityHappinessChange = -25, Cost = 150, GoldMaintenance = 1, ReligiousPressureModifier = 25, HurryCostModifier = 5
WHERE Type = 'BUILDING_STEMPLES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Reduces [ICON_HAPPINESS_3] Religious Unrest and generates +25% Religious Pressure.[NEWLINE]Nearby [ICON_RES_INCENSE] Incense: +1 [ICON_CULTURE] Culture, +1 [ICON_GOLD] Gold.[NEWLINE] Nearby [ICON_RES_WINE] Wine: +1 [ICON_CULTURE] Culture, +1 [ICON_GOLD] Gold.'
WHERE Tag = 'TXT_KEY_BUILDING_STEMPLES_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_TERRACE_FARM' AND Value= 1 );