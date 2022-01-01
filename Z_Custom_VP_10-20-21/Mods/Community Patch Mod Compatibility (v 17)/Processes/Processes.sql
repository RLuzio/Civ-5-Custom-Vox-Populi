INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
VALUES ('TECHPRIEST_ATLAS', '256', 'FaithTourismAtlas256.dds', '8', '8');

INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
VALUES ('TECHPRIEST_ATLAS', '128', 'FaithTourismAtlas128.dds', '8', '8');

INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
VALUES ('TECHPRIEST_ATLAS', '80', 'FaithTourismAtlas80.dds', '8', '8');

INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
VALUES ('TECHPRIEST_ATLAS', '64', 'FaithTourismAtlas64.dds', '8', '8');

INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
VALUES ('TECHPRIEST_ATLAS', '45', 'FaithTourismAtlas45.dds', '8', '8');

INSERT INTO IconTextureAtlases (Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
VALUES ('TECHPRIEST_ATLAS', '32', 'FaithTourismAtlas32.dds', '8', '8');

INSERT INTO LocalizedText
	(Language, Tag, Text)
VALUES
	('en_US', 'TXT_KEY_PROCESS_TOURISM', 'Propaganda'),
	('en_US', 'TXT_KEY_PROCESS_TOURISM_HELP', '[COLOR_POSITIVE_TEXT]Propaganda[ENDCOLOR] converts 10% of [ICON_PRODUCTION] Production of this City into [ICON_TOURISM] Tourism.'),
	('en_US', 'TXT_KEY_PROCESS_TOURISM_STRATEGY', 'Investing production in propaganda is a good way to boost your City''s influence in the world, which can be useful if you are currently in a revolutionary wave, or if you want to force other civilizations to be in a revolutionary wave.'),
	('en_US', 'TXT_KEY_PROCESS_GOLDEN_AGE', 'Prosperity'),
	('en_US', 'TXT_KEY_PROCESS_GOLDEN_AGE_HELP', '[COLOR_POSITIVE_TEXT]Prosperity[ENDCOLOR] converts 20% of [ICON_PRODUCTION] Production of this City into [ICON_GOLDEN_AGE] Golden Age Points.'),
	('en_US', 'TXT_KEY_PROCESS_GOLDEN_AGE_STRATEGY', 'Investing production in prosperity is a good way to boost your nation''s production, science, culture, and wealth. Which is useful for forming an utopian society for the people to live in.'),
	('en_US', 'TXT_KEY_PROCESS_FAITH', 'Prayer'),
	('en_US', 'TXT_KEY_PROCESS_FAITH_HELP', '[COLOR_POSITIVE_TEXT]Prayer[ENDCOLOR] converts 35% of [ICON_PRODUCTION] Production of this City into [ICON_PEACE] Faith.'),
	('en_US', 'TXT_KEY_PROCESS_FAITH_STRATEGY', 'Investing production in prayer is a good way to boost your City''s faith output, which can be useful if you are currently in need of missionaires and inquisitors or if your cities need to birth Great People!');


INSERT INTO Processes (Type, Description, Help, Strategy, TechPrereq, IconAtlas, PortraitIndex)
SELECT 	'PROCESS_FAITH', 'TXT_KEY_PROCESS_FAITH', 'TXT_KEY_PROCESS_FAITH_HELP', 'TXT_KEY_PROCESS_FAITH_STRATEGY', 'TECH_PHILOSOPHY', 'TECHPRIEST_ATLAS', 0 UNION ALL
SELECT	'PROCESS_GOLDEN_AGE', 'TXT_KEY_PROCESS_GOLDEN_AGE', 'TXT_KEY_PROCESS_GOLDEN_AGE_HELP', 'TXT_KEY_PROCESS_GOLDEN_AGE_STRATEGY', 'TECH_GLOBALIZATION', 'TECHPRIEST_ATLAS', 2 UNION ALL
SELECT	'PROCESS_TOURISM', 'TXT_KEY_PROCESS_TOURISM', 'TXT_KEY_PROCESS_TOURISM_HELP', 'TXT_KEY_PROCESS_TOURISM_STRATEGY', 'TECH_RADIO', 'TECHPRIEST_ATLAS', 1
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_FGAPT' AND Value= 1);

INSERT INTO Process_ProductionYields (ProcessType, YieldType, Yield)
SELECT 'PROCESS_FAITH', 'YIELD_FAITH', 35 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_FGAPT' AND Value= 1) UNION ALL
SELECT 'PROCESS_GOLDEN_AGE', 'YIELD_GOLDEN_AGE_POINTS', 20 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_FGAPT' AND Value= 1) UNION ALL
SELECT 'PROCESS_TOURISM', 'YIELD_TOURISM', 10 WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='CBPMC_FGAPT' AND Value= 1);