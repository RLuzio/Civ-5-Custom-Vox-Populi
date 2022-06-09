
----------
-- Kirov Icon to Missile Cruiser Unit (Kirov Modele)
----------

UPDATE Units
SET IconAtlas = 'ICON_ATLAS_ENW', PortraitIndex = 6
WHERE Type = 'UNIT_MISSILE_CRUISER';

----------
-- Z Class Icon to Modern Destroyer Unit (Z Class Modele)
----------

UPDATE Units
SET IconAtlas = 'ICON_ATLAS_ENW', PortraitIndex = 7
WHERE Type = 'UNIT_DESTROYER';

----------
-- MBDA Icon to Guided Missile (Generic Modele)
----------

UPDATE Units
SET IconAtlas = 'ICON_ATLAS_ENW', PortraitIndex = 8
WHERE Type = 'UNIT_GUIDED_MISSILE';

----------
-- Better Icon to Cruiser (Generic Modele)
----------

UPDATE Units
SET IconAtlas = 'ICON_ATLAS_ENW', PortraitIndex = 11
WHERE Type = 'UNIT_CRUISER';
