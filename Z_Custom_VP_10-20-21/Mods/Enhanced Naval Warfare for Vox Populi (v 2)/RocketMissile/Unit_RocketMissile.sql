----------------------------------------------------
-- Enhanced Modern Warfare
-- New unit: Attack Submarine
-- Author: Infixo
-- Feb 16, 2017: Created
----------------------------------------------------

----------------------------------------------------
-- ArtDef
----------------------------------------------------

INSERT INTO ArtDefine_UnitInfos (Type, DamageStates, Formation)
VALUES ('ART_DEF_UNIT_ROCKET_MISSILE', 1, '');

-- uses vanilla's model but smaller
INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale , Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
VALUES ('ART_DEF_UNIT_MEMBER_ROCKET_MISSILE', 0.11, 'Air', 'GuidedMissile.fxsxml', 'METAL', 'METALLRG');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType, UnitMemberInfoType, NumMembers)
VALUES ('ART_DEF_UNIT_ROCKET_MISSILE', 'ART_DEF_UNIT_MEMBER_ROCKET_MISSILE', 1);

INSERT INTO ArtDefine_UnitMemberCombats
	(UnitMemberType, EnableActions, DisableActions,
	AttackRadius, MoveRate, TurnRateMin, TurnRateMax, PitchRateMin, PitchRateMax,
	HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasRefaceAfterCombat, HasIndependentWeaponFacing, HasCollisionAttack, AttackAltitude, RushAttackFormation)
VALUES
	('ART_DEF_UNIT_MEMBER_ROCKET_MISSILE', 'Idle Attack Bombard Death Run', '',
	48, 2.4, 0.5, 1.5, 1.0, 3.0,
	NULL, NULL, NULL, 0, NULL, 1, 50, '');

INSERT INTO ArtDefine_UnitMemberCombatWeapons
	(UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, HitEffect, WeaponTypeTag, WeaponTypeSoundOverrideTag)
VALUES
	('ART_DEF_UNIT_MEMBER_ROCKET_MISSILE', 0, 0, NULL, 100, 100, NULL, 'ART_DEF_VEFFECT_GUIDED_MISSILE_IMPACT_$(TERRAIN)', 'EXPLOSIVE', 'EXPLOSION200POUND');
	-- missiles have only 1 entry
	--('ART_DEF_UNIT_MEMBER_ROCKET_MISSILE', 1, 0, 'ART_DEF_VEFFECT_MECH_ROCKET_PROJECTILE', 25, 50, 5.3, 'ART_DEF_VEFFECT_GUIDED_MISSILE_IMPACT_$(TERRAIN)', 'BULLETHC', 'BULLETHC');

INSERT INTO ArtDefine_StrategicView (StrategicViewType, TileType, Asset)
VALUES ('ART_DEF_UNIT_ROCKET_MISSILE', 'Unit', 'SV_RocketMissile.dds');

----------------------------------------------------
-- Unit
----------------------------------------------------

INSERT INTO UnitClasses (Type, Description, MaxPlayerInstances, DefaultUnit)
VALUES ('UNITCLASS_ROCKET_MISSILE', 'TXT_KEY_UNIT_ROCKET_MISSILE', -1, 'UNIT_ROCKET_MISSILE');

INSERT INTO Units
	(Type, Class, Domain, CombatClass, PrereqTech, ObsoleteTech, DefaultUnitAI,
	Description, Civilopedia, Strategy, Help,
	Cost, FaithCost, ExtraMaintenanceCost, Combat, Moves, RangedCombat, Range, AirInterceptRange, BaseSightRange,
	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, Mechanized, Immobile, Suicide,
	AdvancedStartCost, MinAreaSize, XPValueAttack, XPValueDefense, MoveRate, AirUnitCap, CombatLimit, RangedCombatLimit,
	SpecialCargo, DomainCargo, Special, PurchaseCooldown, NukeDamageLevel,  -- NDL is 2 for NM, 1 for AB, -1 for non-nukes
	UnitArtInfo, UnitFlagAtlas, UnitFlagIconOffset, IconAtlas, PortraitIndex)
VALUES
	('UNIT_ROCKET_MISSILE', 'UNITCLASS_ROCKET_MISSILE', 'DOMAIN_AIR', NULL, 'TECH_ROCKETRY', NULL, 'UNITAI_MISSILE_AIR',
	'TXT_KEY_UNIT_ROCKET_MISSILE', 'TXT_KEY_UNIT_ROCKET_MISSILE_PEDIA', 'TXT_KEY_UNIT_ROCKET_MISSILE_STRATEGY', 'TXT_KEY_UNIT_ROCKET_MISSILE_HELP',
	400, 0, 0, 0, 2, 120, 8, 0, 2,
	0, 1, 0, 1, 1, 1, 1,
	40, -1, 0, 2, 'AIR_REBASE', 1, 0, 100,
	NULL, NULL, 'SPECIALUNIT_MISSILE', 1, -1,
	'ART_DEF_UNIT_ROCKET_MISSILE', 'FLAG_ATLAS_ENW', 4, 'ICON_ATLAS_ENW', 4);

INSERT INTO UnitGameplay2DScripts (UnitType, SelectionSound, FirstSelectionSound)
VALUES ('UNIT_ROCKET_MISSILE', 'AS2D_SELECT_NUCLEAR_MISSILE', 'AS2D_BIRTH_NUCLEAR_MISSILE');

INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
VALUES ('UNIT_ROCKET_MISSILE', 'UNITCLASS_GUIDED_MISSILE');

----------------------------------------------------
-- Promotions
----------------------------------------------------
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
VALUES
	('UNIT_ROCKET_MISSILE', 'PROMOTION_HEAVY_PAYLOAD'); -- cities +50%


----------------------------------------------------
-- Other features
----------------------------------------------------

INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_ROCKET_MISSILE', 'RESOURCE_OIL', 1);

INSERT INTO Unit_BuildingClassPurchaseRequireds (UnitType, BuildingClassType)
VALUES ('UNIT_ROCKET_MISSILE','BUILDINGCLASS_MILITARY_ACADEMY');

----------------------------------------------------
-- AI
----------------------------------------------------

INSERT INTO Technology_Flavors (TechType, FlavorType, Flavor)
VALUES
	('TECH_ADVANCED_BALLISTICS', 'FLAVOR_OFFENSE', 10),
	('TECH_ADVANCED_BALLISTICS', 'FLAVOR_RANGED', 8);

INSERT INTO Unit_AITypes (UnitType, UnitAIType)
VALUES ('UNIT_ROCKET_MISSILE', 'UNITAI_MISSILE_AIR');

INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
VALUES
	('UNIT_ROCKET_MISSILE', 'FLAVOR_OFFENSE', 20),
	('UNIT_ROCKET_MISSILE', 'FLAVOR_DEFENSE', 20),
	('UNIT_ROCKET_MISSILE', 'FLAVOR_RANGED', 5),
	('UNIT_ROCKET_MISSILE', 'FLAVOR_NAVAL', 10);

----------------------------------------------------
-- Text (en_US)
----------------------------------------------------

INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_ROCKET_MISSILE', 'Rocket Missile');

-- Pedia: Historical Info (bottom)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_ROCKET_MISSILE_PEDIA', 'A Rocket is a self-propelled, unguided weapon system powered by a rocket motor. Historically they have been used mostly as air-to-surface and air-to-air weapons.[NEWLINE]The first missiles to be used operationally were a series of missiles developed by Nazi Germany in World War II. Most famous of these are the V-1 flying bomb and V-2 rocket, both of which used a simple mechanical autopilot to keep the missile flying along a pre-chosen route.');

-- Pedia: Strategy (middle)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_ROCKET_MISSILE_STRATEGY', 'A Rocket Missile is a one-shot unit which is destroyed when it attacks an enemy target. It requires [ICON_RES_OIL] Oil to be built.');

-- Pedia: Game Info (top)
INSERT INTO Language_en_US (Tag, Text)
VALUES ('TXT_KEY_UNIT_ROCKET_MISSILE_HELP', 'A cheap Unit that maybe used once to damage enemy Units or Cities. It requires [ICON_RES_OIL] Oil to be built.[NEWLINE][COLOR_POSITIVE_TEXT]Does not use Military Supply.[ENDCOLOR]');
