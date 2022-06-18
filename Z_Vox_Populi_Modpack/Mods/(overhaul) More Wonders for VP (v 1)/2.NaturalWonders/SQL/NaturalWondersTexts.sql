----------------------------------------------------
-- Modifier of Historical data for NWs
-- Jul 15, 2021: Created, adan_eslavo
--============================================--
-- Promotion Icons Atlas
--============================================--
-- Barringer Crater
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_RESEARCH] Science from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_RESEARCH], +1[ICON_GOLDEN_AGE]/Era[NEWLINE][ICON_BULLET](owned) +20%[ICON_PRODUCTION][ICON_PRODUCTION] during construction of Spaceship Parts[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT';
-- Cerro de Potosi
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_PRODUCTION] Production from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_POTOSI_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_POTOSI_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_PRODUCTION], +1[ICON_GOLD]/Era[NEWLINE][ICON_BULLET](owned) +1 flat [ICON_RES_SILVER][NEWLINE][ICON_BULLET](owned) +1 [ICON_INTERNATIONAL_TRADE][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_POTOSI_TEXT';
-- El Dorado
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_CULTURE] Culture from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_EL_DORADO_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_EL_DORADO_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+2[ICON_GOLD]/Era[NEWLINE][ICON_BULLET]grants 100[ICON_GOLD] to the first player who will discover it[NEWLINE][ICON_BULLET](owned) +1 flat [ICON_RES_GOLD][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_EL_DORADO_TEXT';
-- Fountain of Youth
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_RESEARCH] Science from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FOUNTAIN_YOUTH_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FOUNTAIN_YOUTH_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+2[ICON_PEACE]/Era[NEWLINE][ICON_BULLET](owned) adds [COLOR_POSITIVE_TEXT]Fresh Water[ENDCOLOR][NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Everlasting Youth[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Military Melee[ENDCOLOR] units[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FOUNTAIN_YOUTH_TEXT';
-- Grand Mesa
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_FOOD] Food from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+2[ICON_PRODUCTION]/Era[NEWLINE][ICON_BULLET](owned) +1[ICON_WAR][ICON_WAR] Military Supply Cap[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT';
-- Great Barrier Reef
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_RESEARCH] Science from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]3-tile (line)[NEWLINE][ICON_BULLET]+1[ICON_TOURISM]/Tile/Era[NEWLINE][ICON_BULLET](owned) +1[ICON_FOOD]/all Fishing Boats (only 1 tile required)[NEWLINE][ICON_BULLET](owned) +1[ICON_RESEARCH]/all Sea luxury resources (only 1 tile required)[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT';
-- Kilimanjaro
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_CULTURE] Culture from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KILIMANJARO_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KILIMANJARO_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_GOLD], +1[ICON_TOURISM]/Era[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Altitude Training[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Military Land[ENDCOLOR] units[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KILIMANJARO_TEXT';
-- King Solomon Mines
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_PRODUCTION] Production from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SOLOMONS_MINES_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SOLOMONS_MINES_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_PEACE], +1[ICON_GOLDEN_AGE]/Era[NEWLINE][NEWLINE][ICON_BULLET](owned) +1[ICON_GOLDEN_AGE]/all Mines[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]For the King[ENDCOLOR] promotion for [COLOR:255:230:85:255]Workers[ENDCOLOR] adjacent to this Wonder[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SOLOMONS_MINES_TEXT';
-- Krakatoa
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_RESEARCH] Science from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+2[ICON_RESEARCH]/Era[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-2[ENDCOLOR][ICON_FOOD], +2[ICON_RESEARCH]/Adjacent Tiles[NEWLINE][NEWLINE][ICON_BULLET](owned) -10% [ICON_HAPPINESS_3][ICON_HAPPINESS_3] Needs Modifier[NEWLINE][ICON_BULLET](owned) +5%[ICON_RESEARCH][ICON_RESEARCH][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT';
-- Lake Victoria
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_FOOD] Food from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_LAKE_VICTORIA_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_LAKE_VICTORIA_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_FOOD], +1[ICON_PRODUCTION]/Era[NEWLINE][ICON_BULLET]+1[ENDCOLOR][ICON_GOLDEN_AGE]/Adjacent Tiles[NEWLINE][ICON_BULLET]passable at [COLOR_XP_BLUE]Fishing[ENDCOLOR][NEWLINE][ICON_BULLET](owned) adds [COLOR_POSITIVE_TEXT]Fresh Water[ENDCOLOR][NEWLINE][ICON_BULLET](owned) allows establishing [ICON_FOOD][ICON_INTERNATIONAL_TRADE] across the Empire[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_LAKE_VICTORIA_TEXT';
-- Mt. Fuji
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_CULTURE] Culture from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FUJI_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FUJI_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_CULTURE], +1[ICON_PEACE]/Era[NEWLINE][ICON_BULLET](owned) +3[ICON_GREAT_ARTIST] in Capital[NEWLINE][ICON_BULLET](owned) +2[ICON_GREAT_WRITER] in Capital[NEWLINE][ICON_BULLET](owned) +1[ICON_GREAT_MUSICIAN] in Capital[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FUJI_TEXT';
-- Mt. Kailash
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_PEACE] Faith from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_KAILASH_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_KAILASH_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_PEACE], +1[ICON_TOURISM]/Era[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Holy Mountain[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Missionaries[ENDCOLOR][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_KAILASH_TEXT';
-- Mt. Sinai
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_PEACE] Faith from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_SINAI_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_SINAI_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_PEACE], +1[ICON_GOLDEN_AGE]/Era[NEWLINE][ICON_BULLET](owned) +1[ICON_PEACE], +1[ICON_GOLDEN_AGE]/[ICON_GREAT_WORK][ICON_GREAT_WORK][NEWLINE][ICON_BULLET](owned) +1[ICON_PEACE], +1[ICON_GOLDEN_AGE]/all Holy Sites[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_SINAI_TEXT';
-- Old Faithful
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_CULTURE] Culture from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_FOOD], +1[ICON_TOURISM]/Era[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-10[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET](owned) adds [COLOR_POSITIVE_TEXT]Fresh Water[ENDCOLOR][NEWLINE][ICON_BULLET](owned) +2[ICON_GREAT_SCIENTIST] in Capital' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT';
-- Rock of Gibraltar
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_GOLD] Gold from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GIBRALTER_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GIBRALTER_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+2[ICON_GOLD]/Era[NEWLINE][ICON_BULLET]+1[ENDCOLOR][ICON_GOLD]/Adjacent Tiles[NEWLINE][ICON_BULLET](owned) +1[ICON_DIPLOMAT] League Vote[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GIBRALTER_TEXT';
-- Sri Pada
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_FOOD] Food from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SRI_PADA_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SRI_PADA_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_FOOD], +1[ICON_CULTURE]/Era[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Sacred Steps[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Civilian[ENDCOLOR] units[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SRI_PADA_TEXT';
-- Uluru
UPDATE Language_en_US SET Text = REPLACE(Text, '[ICON_PRODUCTION] Production from this Natural Wonder increases every Era after the Classical Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_ULURU_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_ULURU_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_CULTURE], +1[ICON_TOURISM]/Era[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Old Tribes[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Diplomatic[ENDCOLOR] units[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_ULURU_TEXT';
-- Salar de Uyuni
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SALAR_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]2-tile (2 shapes with different values)[NEWLINE][ICON_BULLET]+1[ICON_RESEARCH]/Tile/Era[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-20[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET](owned) +5%[ICON_FOOD][ICON_FOOD] (small) and +10%[ICON_FOOD][ICON_FOOD] (big) (stacking)[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SALAR_TEXT';
-- Giant's Causeway
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_CAUSEWAY_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]2-tile (2 shapes with different values)[NEWLINE][ICON_BULLET]+1[ICON_RESEARCH] (land), +1[ICON_PEACE] (sea)/Era[NEWLINE][ICON_BULLET](owned) +25%[ICON_TOURISM]/all Landmarks[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_CAUSEWAY_TEXT';
-- Mt. Everest
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_EVEREST_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+2[ICON_TOURISM]/Era[NEWLINE][ICON_BULLET](owned) +10%[ICON_TOURISM][ICON_TOURISM][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_EVEREST_TEXT';
-- Lake Retba
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_RETBA_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_RESEARCH], +1[ICON_TOURISM]/Era[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-1[ENDCOLOR][ICON_FOOD]/Adjacent Tiles[NEWLINE][ICON_BULLET](owned) +5%[ICON_FOOD][ICON_FOOD][NEWLINE][ICON_BULLET](owned) +1 additional [ICON_HAPPINESS_1][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_RETBA_TEXT';
-- Bermuda Triangle
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_BERMUDA_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]3-tile (triangle)[NEWLINE][ICON_BULLET]+1[ICON_PEACE], +1[ICON_GREAT_ADMIRAL_POINTS]/Tile/Era[NEWLINE][ICON_BULLET]passable at [COLOR_XP_BLUE]Compass[ENDCOLOR][NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-25[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]stops unit on its tile[ENDCOLOR][NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]Lost in Time and Space[ENDCOLOR] promotion for unit on its tiles[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_BERMUDA_TEXT';
-- Bioluminescent Bay
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_LUMI_BAY_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_GOLD], +1[ICON_TOURISM]/Era[NEWLINE][ICON_BULLET]+1[ICON_TOURISM]/Adjacent Tiles[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-5[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET](owned) +1[ICON_RESEARCH]/[ICON_RES_FISH][ICON_RES_FISH][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_LUMI_BAY_TEXT';
-- Dallol
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_DALLOL_TEXT';
UPDATE Language_en_US SET Text = Text||'[ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]+1[ICON_PRODUCTION], +1[ICON_RESEARCH]/Era[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-2[ENDCOLOR][ICON_FOOD], +1[ICON_PRODUCTION]/Adjacent Tiles[NEWLINE][ICON_BULLET](owned) +1 flat [ICON_RES_SYLVITE][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_DALLOL_TEXT';
