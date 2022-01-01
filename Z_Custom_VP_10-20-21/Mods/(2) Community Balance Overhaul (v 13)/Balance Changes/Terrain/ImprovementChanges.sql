-- New Improvement

INSERT INTO Improvements
	(Type, Description, Civilopedia, ArtDefineTag, RequiresFeature, PillageGold, PortraitIndex, IconAtlas)
VALUES
	('IMPROVEMENT_LUMBERMILL_JUNGLE', 'TXT_KEY_IMPROVEMENT_LUMBERMILL_JUNGLE', 'TXT_KEY_CIV5_IMPROVEMENTS_LUMBERMILL_TEXT_JUNGLE', 'ART_DEF_IMPROVEMENT_LUMBERMILL', 1, 10, 8, 'TERRAIN_ATLAS');

INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_LUMBERMILL_JUNGLE', 'YIELD_GOLD', 1);

INSERT INTO Improvement_ValidFeatures
	(ImprovementType, FeatureType)
VALUES
	('IMPROVEMENT_LUMBERMILL_JUNGLE', 'FEATURE_JUNGLE');

INSERT INTO Builds
	(Type, PrereqTech, Time, ImprovementType, Description, Recommendation, EntityEvent, HotKey, OrderPriority, IconIndex, IconAtlas)
VALUES
	('BUILD_LUMBERMILL_JUNGLE', 'TECH_MACHINERY', 800, 'IMPROVEMENT_LUMBERMILL_JUNGLE', 'TXT_KEY_BUILD_LUMBERMILL_JUNGLE', 'TXT_KEY_BUILD_LUMBERMILL_REC_JUNGLE', 'ENTITY_EVENT_BUILD', 'KB_L', 98, 28, 'UNIT_ACTION_ATLAS');

INSERT INTO Unit_Builds
	(UnitType, BuildType)
VALUES
	('UNIT_WORKER', 'BUILD_LUMBERMILL_JUNGLE');

-- Yield Data

INSERT INTO Improvement_YieldAdjacentTwoSameType
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FARM', 'YIELD_FOOD', 1),
	('IMPROVEMENT_LUMBERMILL_JUNGLE', 'YIELD_GOLD', 1),
	('IMPROVEMENT_LUMBERMILL', 'YIELD_PRODUCTION', 1);

-- Delete things we replace below.
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_URANIUM';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_STONE';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_FISH';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_BANANA';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_BISON';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_DEER';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_COW';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_HORSE';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_SHEEP';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_SALT';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_TRUFFLES';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_CITRUS';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_COCOA';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_COPPER';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_COTTON';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_DYE';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_GEMS';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_GOLD';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_INCENSE';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_IVORY';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_MARBLE';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_PEARLS';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_SALT';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_SILK';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_SILVER';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_SPICES';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_SUGAR';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_WINE';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_CRAB';
DELETE FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_WHALE';

INSERT INTO Improvement_ResourceType_Yields
	(ImprovementType, ResourceType, YieldType, Yield)
VALUES
	('IMPROVEMENT_QUARRY', 'RESOURCE_URANIUM', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_MINE', 'RESOURCE_IRON', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_QUARRY', 'RESOURCE_STONE', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_FISHING_BOATS', 'RESOURCE_FISH', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_FISHING_BOATS', 'RESOURCE_FISH', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_BANANA', 'YIELD_FOOD', 3),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_BANANA', 'YIELD_GOLD', 1),
	('IMPROVEMENT_CAMP', 'RESOURCE_BISON', 'YIELD_FOOD', 1),
	('IMPROVEMENT_CAMP', 'RESOURCE_BISON', 'YIELD_GOLD', 1),
	('IMPROVEMENT_CAMP', 'RESOURCE_DEER', 'YIELD_FOOD', 1),
	('IMPROVEMENT_CAMP', 'RESOURCE_FUR', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_PASTURE', 'RESOURCE_COW', 'YIELD_FOOD', 1),
	('IMPROVEMENT_PASTURE', 'RESOURCE_COW', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_PASTURE', 'RESOURCE_HORSE', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_PASTURE', 'RESOURCE_SHEEP', 'YIELD_FOOD', 1),
	('IMPROVEMENT_PASTURE', 'RESOURCE_SHEEP', 'YIELD_GOLD', 2),
	('IMPROVEMENT_MINE', 'RESOURCE_SALT', 'YIELD_FOOD', 1),
	('IMPROVEMENT_CAMP', 'RESOURCE_TRUFFLES', 'YIELD_FOOD', 1),
	('IMPROVEMENT_CAMP', 'RESOURCE_TRUFFLES', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_CITRUS', 'YIELD_FOOD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_CITRUS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_COCOA', 'YIELD_GOLD', 2),
	('IMPROVEMENT_MINE', 'RESOURCE_COPPER', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_COTTON', 'YIELD_GOLD', 2),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_COTTON', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_DYE', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_DYE', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_MINE', 'RESOURCE_GEMS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_MINE', 'RESOURCE_GEMS', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_MINE', 'RESOURCE_GOLD', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_INCENSE', 'YIELD_FAITH', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_INCENSE', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_CAMP', 'RESOURCE_IVORY', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_CAMP', 'RESOURCE_IVORY', 'YIELD_GOLD', 1),
	('IMPROVEMENT_QUARRY', 'RESOURCE_MARBLE', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_FISHING_BOATS', 'RESOURCE_PEARLS', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_FISHING_BOATS', 'RESOURCE_PEARLS', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_FISHING_BOATS', 'RESOURCE_CRAB', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_FISHING_BOATS', 'RESOURCE_CRAB', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FISHING_BOATS', 'RESOURCE_WHALE', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_FISHING_BOATS', 'RESOURCE_WHALE', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_SILK', 'YIELD_GOLD', 3),
	('IMPROVEMENT_MINE', 'RESOURCE_SILVER', 'YIELD_GOLD', 2),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_SPICES', 'YIELD_FOOD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_SPICES', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_SUGAR', 'YIELD_FOOD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_SUGAR', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_WINE', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_PLANTATION', 'RESOURCE_WINE', 'YIELD_GOLD', 1);

DELETE FROM Improvement_ValidTerrains WHERE ImprovementType= 'IMPROVEMENT_FARM' AND TerrainType= 'TERRAIN_DESERT';

INSERT INTO Improvement_ValidFeatures
	(ImprovementType, FeatureType)
VALUES
	('IMPROVEMENT_FISHING_BOATS', 'FEATURE_ATOLL'),
	('IMPROVEMENT_FISHING_BOATS', 'FEATURE_REEF'),
	('IMPROVEMENT_FISHING_BOATS', 'FEATURE_ICE');

INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_HOLY_SITE', 'YIELD_CULTURE', 5),
	('IMPROVEMENT_HOLY_SITE', 'YIELD_TOURISM', 3),
	('IMPROVEMENT_TRADING_POST', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_CHATEAU', 'YIELD_FOOD', 3),
	('IMPROVEMENT_FEITORIA', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_FEITORIA', 'YIELD_GOLD', 3),
	('IMPROVEMENT_CITADEL', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_CITADEL', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_WELL', 'YIELD_GOLD', 5),
	('IMPROVEMENT_LANDMARK', 'YIELD_CULTURE', 3),
	('IMPROVEMENT_LANDMARK', 'YIELD_GOLD', 3),
	('IMPROVEMENT_FORT', 'YIELD_CULTURE_LOCAL', 1),
	('IMPROVEMENT_OFFSHORE_PLATFORM', 'YIELD_GOLD', 4);

INSERT INTO Improvement_YieldPerEra
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_LANDMARK', 'YIELD_GOLD', 1);

DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_LUMBERMILL';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_MINE';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_QUARRY';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_TRADING_POST';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_CITADEL';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_LANDMARK';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_ACADEMY';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_CUSTOMS_HOUSE';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_MANUFACTORY';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_PLANTATION';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_PASTURE';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_FISHING_BOATS';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_CAMP';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_CHATEAU';

DELETE FROM Improvement_TechFreshWaterYieldChanges;
DELETE FROM Improvement_TechNoFreshWaterYieldChanges;


INSERT INTO Improvement_FreshWaterYields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FARM', 'YIELD_FOOD', 1);

INSERT INTO Improvement_TechYieldChanges
	(ImprovementType, TechType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FARM', 'TECH_CIVIL_SERVICE', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FARM', 'TECH_FERTILIZER', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FARM', 'TECH_ROBOTICS', 'YIELD_FOOD', 3),
	('IMPROVEMENT_CAMP', 'TECH_GUILDS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_CAMP', 'TECH_RIFLING', 'YIELD_GOLD', 1),
	('IMPROVEMENT_CAMP', 'TECH_GUNPOWDER', 'YIELD_GOLD', 1),
	('IMPROVEMENT_MINE', 'TECH_STEEL', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_MINE', 'TECH_STEAM_POWER', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_MINE', 'TECH_COMBUSTION', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_MINE', 'TECH_ROBOTICS', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_QUARRY', 'TECH_STEAM_POWER', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_QUARRY', 'TECH_MACHINERY', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_QUARRY', 'TECH_DYNAMITE', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_PASTURE', 'TECH_CIVIL_SERVICE', 'YIELD_FOOD', 2),
	('IMPROVEMENT_PASTURE', 'TECH_FERTILIZER', 'YIELD_GOLD', 2),
	('IMPROVEMENT_PASTURE', 'TECH_ROBOTICS', 'YIELD_FOOD', 3),
	('IMPROVEMENT_PLANTATION', 'TECH_CHEMISTRY', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'TECH_PLASTIC', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'TECH_ECONOMICS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_FISHING_BOATS', 'TECH_COMPASS', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FISHING_BOATS', 'TECH_NAVIGATION', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FISHING_BOATS', 'TECH_REFRIGERATION', 'YIELD_FOOD', 2),
	('IMPROVEMENT_LUMBERMILL_JUNGLE', 'TECH_METALLURGY', 'YIELD_GOLD', 2),
	('IMPROVEMENT_LUMBERMILL_JUNGLE', 'TECH_COMBUSTION', 'YIELD_GOLD', 2),
	('IMPROVEMENT_LUMBERMILL', 'TECH_METALLURGY', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_LUMBERMILL', 'TECH_COMBUSTION', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_WELL', 'TECH_PLASTIC', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_WELL', 'TECH_ELECTRONICS', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_MOAI', 'TECH_ARCHITECTURE', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_MOAI', 'TECH_ASTRONOMY', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_POLDER', 'TECH_CHEMISTRY', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_TERRACE_FARM', 'TECH_CIVIL_SERVICE', 'YIELD_FOOD', 1),
	('IMPROVEMENT_TERRACE_FARM', 'TECH_FERTILIZER', 'YIELD_FOOD', 1),
	('IMPROVEMENT_TERRACE_FARM', 'TECH_ROBOTICS', 'YIELD_FOOD', 3),
	('IMPROVEMENT_FEITORIA', 'TECH_ASTRONOMY', 'YIELD_GOLD', 2),
	('IMPROVEMENT_FEITORIA', 'TECH_PRINTING_PRESS', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_FEITORIA', 'TECH_INDUSTRIALIZATION', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_CHATEAU', 'TECH_FLIGHT', 'YIELD_GOLD', 2),
	('IMPROVEMENT_CHATEAU', 'TECH_FLIGHT', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_CHATEAU', 'TECH_PRINTING_PRESS', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_BRAZILWOOD_CAMP', 'TECH_PHYSICS', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_BRAZILWOOD_CAMP', 'TECH_RADIO', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_MANUFACTORY', 'TECH_METAL_CASTING', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_MANUFACTORY', 'TECH_FERTILIZER', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_MANUFACTORY', 'TECH_COMBINED_ARMS', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_ACADEMY', 'TECH_PHYSICS', 'YIELD_SCIENCE', 3),
	('IMPROVEMENT_ACADEMY', 'TECH_SCIENTIFIC_THEORY', 'YIELD_SCIENCE', 3),
	('IMPROVEMENT_ACADEMY', 'TECH_ROCKETRY', 'YIELD_SCIENCE', 3),
	('IMPROVEMENT_ACADEMY', 'TECH_NUCLEAR_FISSION', 'YIELD_SCIENCE', 3),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_BANKING', 'YIELD_GOLD', 2),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_RAILROAD', 'YIELD_FOOD', 2),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_ARCHITECTURE', 'YIELD_FOOD', 2),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_REFRIGERATION', 'YIELD_GOLD', 2),
	('IMPROVEMENT_FORT', 'TECH_CHEMISTRY', 'YIELD_SCIENCE', 2),
	('IMPROVEMENT_FORT', 'TECH_MILITARY_SCIENCE', 'YIELD_CULTURE_LOCAL', 2),
	('IMPROVEMENT_FORT', 'TECH_STEALTH', 'YIELD_SCIENCE', 4),
	('IMPROVEMENT_FORT', 'TECH_ELECTRONICS', 'YIELD_CULTURE_LOCAL', 4),
	('IMPROVEMENT_CITADEL', 'TECH_CHEMISTRY', 'YIELD_SCIENCE', 2),
	('IMPROVEMENT_CITADEL', 'TECH_MILITARY_SCIENCE', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_CITADEL', 'TECH_STEALTH', 'YIELD_SCIENCE', 4),
	('IMPROVEMENT_CITADEL', 'TECH_ELECTRONICS', 'YIELD_PRODUCTION', 4),
	('IMPROVEMENT_LANDMARK', 'TECH_SATELLITES', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_LANDMARK', 'TECH_TELECOM', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_HOLY_SITE', 'TECH_ACOUSTICS', 'YIELD_FAITH', 4),
	('IMPROVEMENT_HOLY_SITE', 'TECH_ARCHAEOLOGY', 'YIELD_CULTURE', 4),
	('IMPROVEMENT_HOLY_SITE', 'TECH_FLIGHT', 'YIELD_TOURISM', 4),
	('IMPROVEMENT_TRADING_POST', 'TECH_GUILDS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_TRADING_POST', 'TECH_RAILROAD', 'YIELD_CULTURE', 1);

INSERT INTO Improvement_AdjacentImprovementYieldChanges
	(ImprovementType, OtherImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FEITORIA', 'IMPROVEMENT_FISHING_BOATS', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_KASBAH', 'IMPROVEMENT_FISHING_BOATS', 'YIELD_GOLD', 2);

INSERT INTO Improvement_AdjacentTerrainYieldChanges
	(ImprovementType, TerrainType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FEITORIA', 'TERRAIN_COAST', 'YIELD_GOLD', 1),
	('IMPROVEMENT_KASBAH', 'TERRAIN_COAST', 'YIELD_CULTURE', 1);

INSERT INTO Route_TechMovementChanges
	(RouteType, TechType, MovementChange)
VALUES
	('ROUTE_ROAD', 'TECH_CONSTRUCTION', -10),
	('ROUTE_ROAD', 'TECH_GUNPOWDER', -5),
	('ROUTE_RAILROAD', 'TECH_COMBUSTION', -10),
	('ROUTE_RAILROAD', 'TECH_COMBINED_ARMS', -5),
	('ROUTE_RAILROAD', 'TECH_MOBILE_TACTICS', -5);

INSERT INTO Improvement_RouteYieldChanges
	(ImprovementType, RouteType, YieldType, Yield)
VALUES
	('IMPROVEMENT_TRADING_POST', 'ROUTE_ROAD', 'YIELD_GOLD', 1),
	('IMPROVEMENT_TRADING_POST', 'ROUTE_ROAD', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_TRADING_POST', 'ROUTE_RAILROAD', 'YIELD_GOLD', 2),
	('IMPROVEMENT_TRADING_POST', 'ROUTE_RAILROAD', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'ROUTE_ROAD', 'YIELD_GOLD', 1),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'ROUTE_ROAD', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'ROUTE_RAILROAD', 'YIELD_GOLD', 2),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'ROUTE_RAILROAD', 'YIELD_PRODUCTION', 2);


-- Fix some Improvement Errata
UPDATE Improvements SET NearbyEnemyDamage = '30' WHERE Type = 'IMPROVEMENT_CITADEL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvements SET DestroyedWhenPillaged = 'false' WHERE Type = 'IMPROVEMENT_OFFSHORE_PLATFORM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvements SET PillageGold = '21' WHERE Type = 'IMPROVEMENT_OFFSHORE_PLATFORM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Yields for other improvements.
UPDATE Improvement_Yields SET Yield = '1' WHERE YieldType = 'YIELD_PRODUCTION' AND ImprovementType = 'IMPROVEMENT_MINE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvement_Yields SET Yield = '1' WHERE YieldType = 'YIELD_PRODUCTION' AND ImprovementType = 'IMPROVEMENT_LUMBERMILL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvement_Yields SET Yield = '2' WHERE YieldType = 'YIELD_GOLD' AND ImprovementType = 'IMPROVEMENT_TRADING_POST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvement_Yields SET Yield = '6' WHERE YieldType = 'YIELD_SCIENCE' AND ImprovementType = 'IMPROVEMENT_ACADEMY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvement_Yields SET Yield = '4' WHERE YieldType = 'YIELD_GOLD' AND ImprovementType = 'IMPROVEMENT_CUSTOMS_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvement_Yields SET Yield = '6' WHERE YieldType = 'YIELD_PRODUCTION' AND ImprovementType = 'IMPROVEMENT_MANUFACTORY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvement_Yields SET Yield = '4' WHERE YieldType = 'YIELD_FAITH' AND ImprovementType = 'IMPROVEMENT_HOLY_SITE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );
UPDATE Improvement_Yields SET Yield = '3' WHERE YieldType = 'YIELD_GOLD' AND ImprovementType = 'IMPROVEMENT_CHATEAU' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Improvements -- Trading Post -- Available at Currency

UPDATE Builds
SET PrereqTech = 'TECH_CURRENCY'
WHERE Type = 'BUILD_TRADING_POST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Lumbermill moved to Steel
UPDATE Builds
SET PrereqTech = 'TECH_METAL_CASTING'
WHERE Type = 'BUILD_LUMBERMILL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Railroads now more expensive (+1)
UPDATE Routes
SET GoldMaintenance = '3'
WHERE Type = 'ROUTE_RAILROAD';

-- Farm
UPDATE Builds
SET Help = 'TXT_KEY_BUILD_FARM_HELP'
WHERE Type = 'BUILD_FARM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Builds
SET Recommendation = 'TXT_KEY_BUILD_FARM_REC'
WHERE Type = 'BUILD_FARM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET RequiresFlatlands = '1'
WHERE Type = 'IMPROVEMENT_FARM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET RequiresFlatlandsOrFreshWater = '0'
WHERE Type = 'IMPROVEMENT_FARM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

	-- Forts and Citadels 'no two adjacent' and no outside borders for Fort - cannot be built on resources (helps AI quite a bit)

UPDATE Builds
SET Time = '400'
WHERE Type = 'BUILD_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET NoTwoAdjacent = '1'
WHERE Type = 'IMPROVEMENT_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET OutsideBorders = '0'
WHERE Type = 'IMPROVEMENT_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET BuildableOnResources = '0'
WHERE Type = 'IMPROVEMENT_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET NoTwoAdjacent = '1'
WHERE Type = 'IMPROVEMENT_CITADEL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Forts and Citadels now passable for ships and trade units.

UPDATE Improvements
SET MakesPassable = '1'
WHERE Type = 'IMPROVEMENT_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET MakesPassable = '1'
WHERE Type = 'IMPROVEMENT_CITADEL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Camps need defense!

UPDATE Improvements
SET DefenseModifier = '25'
WHERE Type = 'IMPROVEMENT_BARBARIAN_CAMP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Trading Post also going to be 'no two adjacent'

UPDATE Improvements
SET NoTwoAdjacent = '1'
WHERE Type = 'IMPROVEMENT_TRADING_POST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Shrink Trading Post
UPDATE ArtDefine_Landmarks
SET Scale= '0.65'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_TRADING_POST1';

-- Shrink Trading Post
UPDATE ArtDefine_Landmarks
SET Scale= '0.65'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_TRADING_POST2';

-- Shrink Trading Post
UPDATE ArtDefine_Landmarks
SET Scale= '0.65'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_TRADING_POST3';

-- Shrink Trading Post
UPDATE ArtDefine_Landmarks
SET Scale= '0.65'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_TRADING_POST4';

-- Shrink Academy
UPDATE ArtDefine_Landmarks
SET Scale= '0.75'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_ACADEMY';

-- Shrink Manufactory
UPDATE ArtDefine_Landmarks
SET Scale= '0.75'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_MANUFACTORY';

-- Shrink Holy Site
UPDATE ArtDefine_Landmarks
SET Scale= '0.75'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_HOLY_SITE';

-- Shrink Kasbah
UPDATE ArtDefine_Landmarks
SET Scale= '0.80'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_KASBAH';

-- Shrink Chateau
UPDATE ArtDefine_Landmarks
SET Scale= '0.70'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_CHATEAU';

-- Shrink Customs House
UPDATE ArtDefine_Landmarks
SET Scale= '0.70'
WHERE ImprovementType = 'ART_DEF_IMPROVEMENT_CUSTOMS_HOUSE';

-- Happiness on Landmark
UPDATE Improvements
SET HappinessOnConstruction = '3'
WHERE Type = 'IMPROVEMENT_LANDMARK' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

-- Pillage values

UPDATE Improvements
SET PillageGold = '21'
WHERE Type = 'IMPROVEMENT_OFFSHORE_PLATFORM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '17'
WHERE Type = 'IMPROVEMENT_CUSTOMS_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '17'
WHERE Type = 'IMPROVEMENT_MANUFACTORY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '17'
WHERE Type = 'IMPROVEMENT_HOLY_SITE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '17'
WHERE Type = 'IMPROVEMENT_LANDMARK' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '17'
WHERE Type = 'IMPROVEMENT_ACADEMY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '17'
WHERE Type = 'IMPROVEMENT_CITADEL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '14'
WHERE Type = 'IMPROVEMENT_BRAZILWOOD_CAMP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '14'
WHERE Type = 'IMPROVEMENT_FISHING_BOATS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '14'
WHERE Type = 'IMPROVEMENT_FEITORIA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '14'
WHERE Type = 'IMPROVEMENT_CHATEAU' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '14'
WHERE Type = 'IMPROVEMENT_POLDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '14'
WHERE Type = 'IMPROVEMENT_KASBAH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '14'
WHERE Type = 'IMPROVEMENT_KUNA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '11'
WHERE Type = 'IMPROVEMENT_ENCAMPMENT_SHOSHONE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '11'
WHERE Type = 'IMPROVEMENT_TRADING_POST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '8'
WHERE Type = 'IMPROVEMENT_LUMBERMILL_JUNGLE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '8'
WHERE Type = 'IMPROVEMENT_LUMBERMILL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '8'
WHERE Type = 'IMPROVEMENT_QUARRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '8'
WHERE Type = 'IMPROVEMENT_CAMP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '8'
WHERE Type = 'IMPROVEMENT_WELL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '8'
WHERE Type = 'IMPROVEMENT_MOAI' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '8'
WHERE Type = 'IMPROVEMENT_MINE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '5'
WHERE Type = 'IMPROVEMENT_TERRACE_FARM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '5'
WHERE Type = 'IMPROVEMENT_PLANTATION' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '5'
WHERE Type = 'IMPROVEMENT_PASTURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '5'
WHERE Type = 'IMPROVEMENT_FARM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '5'
WHERE Type = 'IMPROVEMENT_EKI' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '20'
WHERE Type = 'IMPROVEMENT_SPAIN_HACIENDA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '0'
WHERE Type = 'IMPROVEMENT_ARCHAEOLOGICAL_DIG' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '0'
WHERE Type = 'IMPROVEMENT_JFD_MACHU_PICCHU' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '0'
WHERE Type = 'IMPROVEMENT_BARBARIAN_CAMP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '0'
WHERE Type = 'IMPROVEMENT_GOODY_HUT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '0'
WHERE Type = 'IMPROVEMENT_CITY_RUINS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '0'
WHERE Type = 'IMPROVEMENT_EMBASSY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

UPDATE Improvements
SET PillageGold = '0'
WHERE Type = 'IMPROVEMENT_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_TERRAIN' AND Value= 1 );

