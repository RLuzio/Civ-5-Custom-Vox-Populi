UPDATE Buildings
SET MinorityHappinessChange = -25, Cost = 200, GoldMaintenance = 2, Happiness = 0, Help = 'TXT_KEY_BUILDING_MARA_HELP', ReligiousPressureModifier = 25, HurryCostModifier = 5
WHERE Type = 'BUILDING_MARA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_MOAI' AND Value= 1);

UPDATE Building_Flavors
SET Flavor = '30'
WHERE BuildingType = 'BUILDING_MARA' AND FlavorType = 'FLAVOR_CULTURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_MOAI' AND Value= 1);

INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_MARA', 'RESOURCE_INCENSE', 'YIELD_CULTURE', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_MOAI' AND Value= 1) UNION ALL
SELECT 'BUILDING_MARA', 'RESOURCE_INCENSE', 'YIELD_FAITH', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_MOAI' AND Value= 1) UNION ALL
SELECT 'BUILDING_MARA', 'RESOURCE_WINE', 'YIELD_CULTURE', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_MOAI' AND Value= 1) UNION ALL
SELECT 'BUILDING_MARA', 'RESOURCE_WINE', 'YIELD_FAITH', 1 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_MOAI' AND Value= 1);

INSERT INTO Language_en_US (Text, Tag)
SELECT 'Reduces [ICON_HAPPINESS_3] Religious Unrest and generates +25% Religious Pressure. +1 [ICON_CULTURE] Culture from Coast tiles worked by the city.[NEWLINE]Nearby [ICON_RES_INCENSE] Incense: +1 [ICON_CULTURE] Culture, +1 [ICON_PEACE] Faith.[NEWLINE] Nearby [ICON_RES_WINE] Wine: +1 [ICON_CULTURE] Culture, +1 [ICON_PEACE] Faith.', 'TXT_KEY_BUILDING_MARA_HELP'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_MOAI' AND Value= 1);

UPDATE Language_EN_US
SET Text = 'The Marae grants +2 [ICON_PEACE] Faith. Helps reduce [ICON_HAPPINESS_3] Religious Division and generates +25% Religious Pressure. It also provides +1 [ICON_CULTURE] Culture bonus to every coast tile worked by the city. The city must contain a Shrine before the Marae can be constructed.'
WHERE Tag = 'TXT_KEY_BUILDING_MARA_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_MOAI' AND Value= 1);