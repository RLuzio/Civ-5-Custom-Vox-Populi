----------------------------------------------------
-- Shared objects
-- Author: Infixo
-- Feb 16, 2017: Created
-- Nov 30, 2017: added extra cargo +2
----------------------------------------------------

----------------------------------------------------
-- Icons
----------------------------------------------------

INSERT INTO IconTextureAtlases
	(Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
VALUES
	('ICON_ATLAS_ENW', 256, 'ENW_IconAtlas256.dds', '4', '3'),
	('ICON_ATLAS_ENW', 128, 'ENW_IconAtlas128.dds', '4', '3'),
	('ICON_ATLAS_ENW',  80, 'ENW_IconAtlas80.dds',  '4', '3'),
	('ICON_ATLAS_ENW',  64, 'ENW_IconAtlas64.dds',  '4', '3'),
	('ICON_ATLAS_ENW',  45, 'ENW_IconAtlas45.dds',  '4', '3'),
	('FLAG_ATLAS_ENW',  32, 'ENW_UnitFlagAtlas.dds', '8', '1');
	
	-- t.b.d.
	--('EMW_FLAG_ATLAS', 32, 'Art/UnitFlag_Supercarrier.dds', '1', '1');

INSERT INTO IconTextureAtlases	(Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) VALUES
('ENW_PI_ATLAS', 256, 'ENW_PI_256.dds', 2, 1),
('ENW_PI_ATLAS', 064, 'ENW_PI_064.dds', 2, 1),
('ENW_PI_ATLAS', 045, 'ENW_PI_045.dds', 2, 1),
('ENW_PI_ATLAS', 032, 'ENW_PI_032.dds', 2, 1),
('ENW_PI_ATLAS', 016, 'ENW_PI_016.dds', 2, 1);

UPDATE CustomModOptions
SET Value = 1
WHERE Name = 'EVENTS_UNIT_UPGRADES';