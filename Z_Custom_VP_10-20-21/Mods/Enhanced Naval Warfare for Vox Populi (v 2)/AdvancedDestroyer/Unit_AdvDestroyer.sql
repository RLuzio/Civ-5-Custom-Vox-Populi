----------------------------------------------------
-- Enhanced Modern Warfare
-- New unit: Advanced Destroyer
-- Author: Asterix Rage (From Infixo code)
-- Feb, 2020: Created
----------------------------------------------------

----------------------------------------------------
-- ArtDef
----------------------------------------------------

INSERT INTO ArtDefine_UnitInfos (Type, DamageStates, Formation)
VALUES ('ART_DEF_UNIT_ADVANCED_DESTROYER', 3, '');

INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale , Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
VALUES ('ART_DEF_UNIT_MEMBER_ADVANCED_DESTROYER', 0.112, 'Sea', 'Railgun_Cruiser.fxsxml', 'METAL', 'METALLRG');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType, UnitMemberInfoType, NumMembers)
VALUES ('ART_DEF_UNIT_ADVANCED_DESTROYER', 'ART_DEF_UNIT_MEMBER_ADVANCED_DESTROYER', 1);

INSERT INTO ArtDefine_UnitMemberCombats (
	UnitMemberType,
	EnableActions, DisableActions,
	HasShortRangedAttack, HasLeftRightAttack, HasRefaceAfterCombat, HasIndependentWeaponFacing, RushAttackFormation)
VALUES (
	'ART_DEF_UNIT_MEMBER_ADVANCED_DESTROYER',
	'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady AttackSurfaceToAir', '',
	1, 1, 0, 1, '');

INSERT INTO ArtDefine_UnitMemberCombatWeapons
	(UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, HitEffect, WeaponTypeTag, WeaponTypeSoundOverrideTag)
VALUES
	('ART_DEF_UNIT_MEMBER_ADVANCED_DESTROYER', 0, 0, 'ART_DEF_VEFFECT_MECH_ROCKET_PROJECTILE', 25, 50, 5.3, 'ART_DEF_VEFFECT_GUIDED_MISSILE_IMPACT_$(TERRAIN)', 'EXPLOSIVE', 'EXPLOSION200POUND'),
	('ART_DEF_UNIT_MEMBER_ADVANCED_DESTROYER', 1, 0, 'ART_DEF_VEFFECT_MECH_ROCKET_PROJECTILE', 25, 50, 5.3, 'ART_DEF_VEFFECT_GUIDED_MISSILE_IMPACT_$(TERRAIN)', 'BULLETHC', 'BULLETHC');


INSERT INTO ArtDefine_StrategicView (StrategicViewType, TileType, Asset)
VALUES ('ART_DEF_UNIT_ADVANCED_DESTROYER', 'Unit', 'sv_ENW_advDestroya.dds');

----------------------------------------------------
-- Unit
----------------------------------------------------

INSERT INTO UnitClasses (Type, Description, MaxPlayerInstances, DefaultUnit)
VALUES ('UNITCLASS_ADVANCED_DESTROYER', 'TXT_KEY_UNIT_ADVANCED_DESTROYER', -1, 'UNIT_ADVANCED_DESTROYER');

INSERT INTO Units
	(Type, Class, Domain, CombatClass, PrereqTech, DefaultUnitAI,
	Description, Civilopedia, Strategy, Help,
	Cost, FaithCost, ExtraMaintenanceCost, Combat, Moves, RangedCombat, Range, AirInterceptRange, BaseSightRange,
	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, Mechanized,
	AdvancedStartCost, MinAreaSize, XPValueAttack, XPValueDefense, MoveRate,
	BaseLandAirDefense, SpecialCargo, DomainCargo, PurchaseCooldown,
	UnitArtInfo, UnitFlagAtlas, UnitFlagIconOffset, IconAtlas, PortraitIndex)
VALUES
	('UNIT_ADVANCED_DESTROYER', 'UNITCLASS_ADVANCED_DESTROYER', 'DOMAIN_SEA', 'UNITCOMBAT_NAVALMELEE', 'TECH_PARTICLE_PHYSICS', 'UNITAI_ATTACK_SEA',
	'TXT_KEY_UNIT_ADVANCED_DESTROYER', 'TXT_KEY_UNIT_ADVANCED_DESTROYER_PEDIA', 'TXT_KEY_UNIT_ADVANCED_DESTROYER_STRATEGY', 'TXT_KEY_ADVANCED_DESTROYER_HELP',
	3400, 1550, 3, 100, 6, 0, 0, 4, 4, 
	1, 1, 1, 1, 1,
	60, 10, 3, 3, 'BOAT',
	50, 'SPECIALUNIT_MISSILE', 'DOMAIN_AIR', 1,
	'ART_DEF_UNIT_ADVANCED_DESTROYER', 'FLAG_ATLAS_ENW', 6, 'ICON_ATLAS_ENW', 9);

INSERT INTO UnitGameplay2DScripts (UnitType, SelectionSound, FirstSelectionSound)
VALUES ('UNIT_ADVANCED_DESTROYER', 'AS2D_SELECT_BATTLESHIP', 'AS2D_BIRTH_BATTLESHIP');

----------------------------------------------------
-- Promotions
-- No special promos
----------------------------------------------------

INSERT INTO Unit_FreePromotions
	(UnitType, PromotionType)
VALUES
	('UNIT_ADVANCED_DESTROYER', 'PROMOTION_SEE_INVISIBLE_SUBMARINE'),
	('UNIT_ADVANCED_DESTROYER', 'PROMOTION_NAVAL_SENTRY'),
	('UNIT_ADVANCED_DESTROYER', 'PROMOTION_INTERCEPTION_I'),
	('UNIT_ADVANCED_DESTROYER', 'PROMOTION_INTERCEPTION_II'),
	('UNIT_ADVANCED_DESTROYER', 'PROMOTION_INTERCEPTION_III'),
	('UNIT_ADVANCED_DESTROYER', 'PROMOTION_CARGO_I'),
	('UNIT_ADVANCED_DESTROYER', 'PROMOTION_CARGO_III'),
	('UNIT_ADVANCED_DESTROYER', 'PROMOTION_ANTI_SUBMARINE_II');

----------------------------------------------------
-- Other features
----------------------------------------------------

INSERT INTO Unit_BuildingClassPurchaseRequireds (UnitType, BuildingClassType)
VALUES ('UNIT_ADVANCED_DESTROYER','BUILDINGCLASS_SEAPORT');

-- Polynesian UA
INSERT INTO Trait_BuildsUnitClasses	(TraitType, UnitClassType, BuildType)
VALUES ('TRAIT_WAYFINDING', 'UNITCLASS_ADVANCED_DESTROYER', 'BUILD_FISHING_BOATS');

----------------------------------------------------
-- AI
----------------------------------------------------

INSERT INTO Technology_Flavors (TechType, FlavorType, Flavor)
VALUES ('TECH_PARTICLE_PHYSICS', 'FLAVOR_NAVAL', 10);

INSERT INTO Unit_AITypes (UnitType, UnitAIType)
VALUES
	('UNIT_ADVANCED_DESTROYER', 'UNITAI_ATTACK_SEA'),
	('UNIT_ADVANCED_DESTROYER', 'UNITAI_RESERVE_SEA'),
	('UNIT_ADVANCED_DESTROYER', 'UNITAI_ESCORT_SEA'),
	('UNIT_ADVANCED_DESTROYER', 'UNITAI_EXPLORE_SEA');

INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
VALUES
	('UNIT_ADVANCED_DESTROYER', 'FLAVOR_NAVAL', 55),
	('UNIT_ADVANCED_DESTROYER', 'FLAVOR_NAVAL_RECON', 35);

----------------------------------------------------
-- Text (en_US)
----------------------------------------------------

INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_ADVANCED_DESTROYER', 'Advanced Destroyer');

-- Pedia: Historical Info (bottom)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_ADVANCED_DESTROYER_PEDIA', '21st century destroyers are the global standard for surface combatant ships. They tend to display features such as large, slab sides without complicated corners and crevices to keep the radar cross-section small, vertical launch systems to carry a large number of missiles at high readiness to fire and helicopter flight decks and hangars. Hardware and software are combined for greater detection range, increased sensitivity and more accurate discrimination. Only one of these vessels can defend an entire fleet against ballistic missiles, cruise missiles, hostile aircraft and surface ships simultaneously.');

-- Pedia: Strategy (middle)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_ADVANCED_DESTROYER_STRATEGY', 'Very strong and expensive naval melee unit capable of tracking submarines from far away and dealing efficiently with any air threat.');

-- Pedia: Game Info (top)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_ADVANCED_DESTROYER_HELP', 'Able to be loaded with 4 missiles, this very powerful naval melee unit sees submarines from afar. Its ultimate strength is to intercept Air Units.');
