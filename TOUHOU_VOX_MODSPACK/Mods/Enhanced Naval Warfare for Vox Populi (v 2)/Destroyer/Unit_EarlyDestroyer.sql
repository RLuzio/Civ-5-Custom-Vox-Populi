----------------------------------------------------
-- Enhanced Modern Warfare
-- New unit: Early Destroyer
-- Author: Infixo
-- Feb 17, 2017: Created
----------------------------------------------------

----------------------------------------------------
-- ArtDef
----------------------------------------------------

INSERT INTO ArtDefine_UnitInfos (Type, DamageStates, Formation)
VALUES ('ART_DEF_UNIT_EARLY_DESTROYER', 3, '');

INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale , Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
VALUES ('ART_DEF_UNIT_MEMBER_EARLY_DESTROYER', 0.075, 'Sea', 'Wickes.fxsxml', 'METAL', 'METALLRG');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType, UnitMemberInfoType, NumMembers)
VALUES ('ART_DEF_UNIT_EARLY_DESTROYER', 'ART_DEF_UNIT_MEMBER_EARLY_DESTROYER', 1);

INSERT INTO ArtDefine_UnitMemberCombats (
	UnitMemberType,
	EnableActions, DisableActions,
	HasShortRangedAttack, HasLeftRightAttack, HasRefaceAfterCombat, HasIndependentWeaponFacing, RushAttackFormation)
VALUES (
	'ART_DEF_UNIT_MEMBER_EARLY_DESTROYER',
	'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady AttackSurfaceToAir', '',
	1, 1, 0, 1, '');

INSERT INTO ArtDefine_UnitMemberCombatWeapons
	(UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, HitEffect, WeaponTypeTag, WeaponTypeSoundOverrideTag)
VALUES
	('ART_DEF_UNIT_MEMBER_EARLY_DESTROYER', 0, 0, '', 25, 50, NULL, 'ART_DEF_VEFFECT_ARTILLERY_IMPACT_$(TERRAIN)', 'EXPLOSIVE', 'EXPLOSION200POUND'),
	('ART_DEF_UNIT_MEMBER_EARLY_DESTROYER', 1, 0, '', 25, 50, NULL, 'ART_DEF_VEFFECT_ARTILLERY_IMPACT_$(TERRAIN)', 'BULLETHC', 'BULLETHC');

INSERT INTO ArtDefine_StrategicView (StrategicViewType, TileType, Asset)
VALUES ('ART_DEF_UNIT_EARLY_DESTROYER', 'Unit', 'SV_EarlyDestroyer.dds');

----------------------------------------------------
-- Unit
----------------------------------------------------

INSERT INTO UnitClasses (Type, Description, MaxPlayerInstances, DefaultUnit)
VALUES ('UNITCLASS_EARLY_DESTROYER', 'TXT_KEY_UNIT_EARLY_DESTROYER', -1, 'UNIT_EARLY_DESTROYER');

INSERT INTO Units
	(Type, Class, Domain, CombatClass, PrereqTech, ObsoleteTech, DefaultUnitAI,
	Description, Civilopedia, Strategy, Help,
	Cost, FaithCost, ExtraMaintenanceCost, Combat, Moves, RangedCombat, Range, AirInterceptRange, BaseSightRange,
	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, Mechanized,
	AdvancedStartCost, MinAreaSize, XPValueAttack, XPValueDefense, MoveRate,
	BaseLandAirDefense, SpecialCargo, DomainCargo, PurchaseCooldown,
	UnitArtInfo, UnitFlagAtlas, UnitFlagIconOffset, IconAtlas, PortraitIndex)
VALUES
	('UNIT_EARLY_DESTROYER', 'UNITCLASS_EARLY_DESTROYER', 'DOMAIN_SEA', 'UNITCOMBAT_NAVALMELEE', 'TECH_RADIO', 'TECH_NUCLEAR_FISSION', 'UNITAI_ATTACK_SEA',
	'TXT_KEY_UNIT_EARLY_DESTROYER', 'TXT_KEY_UNIT_EARLY_DESTROYER_PEDIA', 'TXT_KEY_UNIT_EARLY_DESTROYER_STRATEGY', 'TXT_KEY_UNIT_EARLY_DESTROYER_HELP',
	1400, 880, 0, 70, 5, 0, 0, 0, 2, 
	1, 1, 1, 1, 1,
	60, 10, 3, 3, 'BOAT',
	20, NULL, NULL, 1,
	'ART_DEF_UNIT_EARLY_DESTROYER', 'FLAG_ATLAS_ENW', 1, 'ICON_ATLAS_ENW', 1);

INSERT INTO UnitGameplay2DScripts (UnitType, SelectionSound, FirstSelectionSound)
VALUES ('UNIT_EARLY_DESTROYER', 'AS2D_SELECT_BATTLESHIP', 'AS2D_BIRTH_BATTLESHIP');

DELETE FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_IRONCLAD';
INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
VALUES ('UNIT_IRONCLAD', 'UNITCLASS_EARLY_DESTROYER');
INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
VALUES ('UNIT_EARLY_DESTROYER', 'UNITCLASS_DESTROYER');

UPDATE Units
SET PrereqTech = 'TECH_NUCLEAR_FISSION', ObsoleteTech = 'TECH_LASERS'
WHERE Type = 'UNIT_DESTROYER';


----------------------------------------------------
-- Promotions
-- No special promos
----------------------------------------------------

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
VALUES
	('UNIT_EARLY_DESTROYER', 'PROMOTION_ANTI_SUBMARINE_I');


----------------------------------------------------
-- Other features
----------------------------------------------------

-- INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
-- VALUES ('UNIT_EARLY_DESTROYER', 'RESOURCE_IRON', 1);

INSERT INTO Unit_BuildingClassPurchaseRequireds (UnitType, BuildingClassType)
VALUES ('UNIT_EARLY_DESTROYER','BUILDINGCLASS_SEAPORT');

-- Polynesian UA
INSERT INTO Trait_BuildsUnitClasses	(TraitType, UnitClassType, BuildType)
VALUES ('TRAIT_WAYFINDING', 'UNITCLASS_EARLY_DESTROYER', 'BUILD_FISHING_BOATS');

DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_DESTROYER' AND PromotionType = 'PROMOTION_WITHDRAW_BEFORE_MELEE';

-- DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_IRONCLAD' AND PromotionType = 'PROMOTION_FIRE_SUPPORT';


----------------------------------------------------
-- AI
----------------------------------------------------


INSERT INTO Unit_AITypes (UnitType, UnitAIType)
VALUES
	('UNIT_EARLY_DESTROYER', 'UNITAI_ATTACK_SEA'),
	('UNIT_EARLY_DESTROYER', 'UNITAI_RESERVE_SEA'),
	('UNIT_EARLY_DESTROYER', 'UNITAI_ESCORT_SEA'),
	('UNIT_EARLY_DESTROYER', 'UNITAI_EXPLORE_SEA');

INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
VALUES
	('UNIT_EARLY_DESTROYER', 'FLAVOR_NAVAL', 40),
	('UNIT_EARLY_DESTROYER', 'FLAVOR_NAVAL_RECON', 30);

----------------------------------------------------
-- Text (en_US)
----------------------------------------------------

INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_EARLY_DESTROYER', 'Destroyer');

-- Pedia: Historical Info (bottom)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_EARLY_DESTROYER_PEDIA', 'A Destroyer is a fast, maneuverable long-endurance warship intended to escort larger vessels in a fleet, convoy or battle group and defend them against smaller powerful short-range attackers. They were originally developed in the late 19th century as a defence against torpedo boats, hence the original name was "torpedo boat destroyer". By the World War I the name was shortened to simply "destroyer" by nearly all navies.[NEWLINE]A typical destroyer built in 1910s and 1920s was 100m long with displacement approx. 1200 tons. The armament consisted of 4 to 6 102 mm caliber guns and multiple 533 mm torpedo tubes. The ship was able to achieve speed of 65 km/h.');

-- Pedia: Strategy (middle)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_EARLY_DESTROYER_STRATEGY', 'The Destroyer is a naval melee unit able to see submarines if promoted. Use it for attack and escorting other units.');

-- Pedia: Game Info (top)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_EARLY_DESTROYER_HELP', 'Strong Naval Melee Unit capable of tracking Submarines if promoted.');
