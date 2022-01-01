UPDATE Buildings 
SET Cost = 350, GoldMaintenance = 0, BuildingProductionModifier = 25, HurryCostModifier = 5, Flat = 0
WHERE Type = 'BUILDING_WIMMEN' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLDER' AND Value= 1);

UPDATE Language_EN_US
SET Text = 'The Polder Mill is a Renaissance-era building which increases the [ICON_PRODUCTION] Production output of a city when constructing buildings.'
WHERE Tag = 'TXT_KEY_BUILDING_WIMMEN_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLDER' AND Value= 1);

UPDATE Language_EN_US
SET Text = '+25% [ICON_PRODUCTION] Production when constructing Buildings. +1 [ICON_FOOD] Food to Polders.'
WHERE Tag = 'TXT_KEY_BUILDING_WIMMEN_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLDER' AND Value= 1);

INSERT INTO Building_ImprovementYieldChanges (BuildingType, ImprovementType, YieldType, Yield)
SELECT 'BUILDING_WIMMEN', 'IMPROVEMENT_POLDER', 'YIELD_FOOD', 1 
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLDER' AND Value= 1);

UPDATE Builds
SET Help = 'A Polder can be built on tiles with access to fresh water. It generates [ICON_FOOD] Food, [ICON_GOLD] Gold, and [ICON_PRODUCTION] Production, and grants [ICON_GOLD] Gold to adjacent Villages and Towns. Provides additional yields once later techs are researched.'
WHERE Type = 'BUILD_POLDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_POLDER' AND Value= 1);
