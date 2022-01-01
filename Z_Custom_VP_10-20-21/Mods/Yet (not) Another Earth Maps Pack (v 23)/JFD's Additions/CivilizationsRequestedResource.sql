--==========================================================================================================================
-- Civilizations_AegeanRequestedResource (Aegean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AegeanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AegeanRequestedResource
			(Type,							Req1,						Req2)
VALUES		('CIVILIZATION_GREECE',			'RESOURCE_SILVER',			'RESOURCE_MARBLE'),
			('CIVILIZATION_OTTOMAN',		'RESOURCE_COFFEE',			null);
--==========================================================================================================================
-- Civilizations_AmericasRequestedResource (Americas)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
			(Type,							Req1,						Req2,				Req3)
VALUES		('CIVILIZATION_AZTEC',			'RESOURCE_JFD_OBSIDIAN',	'RESOURCE_STONE',	null),
			('CIVILIZATION_ENGLAND',		'RESOURCE_FISH',			'RESOURCE_PEARLS',	'RESOURCE_SUGAR'),
			('CIVILIZATION_NETHERLANDS',	'RESOURCE_PEARLS',			'RESOURCE_CRAB',	'RESOURCE_COCOA'),
			('CIVILIZATION_FRANCE',			'RESOURCE_FISH',			'RESOURCE_CRAB',	'RESOURCE_COTTON'),
			('CIVILIZATION_POLYNESIA',		'RESOURCE_FISH',			'RESOURCE_WHALE',	null),
			('CIVILIZATION_DENMARK',		'RESOURCE_FISH',			'RESOURCE_CRAB',	'RESOURCE_SUGAR'),
			('CIVILIZATION_SWEDEN',			'RESOURCE_FISH',			'RESOURCE_CRAB',	'RESOURCE_TOBACCO');
--==========================================================================================================================
-- Civilizations_ApennineRequestedResource (Apennine)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_ApennineRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_ApennineRequestedResource
			(Type,							Req1,						Req2,				Req3)
VALUES		('CIVILIZATION_ROME',			'RESOURCE_WINE',			'RESOURCE_MARBLE',	'RESOURCE_OLIVE'),
			('CIVILIZATION_CARTHAGE',		'RESOURCE_OLIVE',			null,				null);
--==========================================================================================================================
-- Civilizations_BritishIslesRequestedResource (British Isles)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_BritishIslesRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR REPLACE INTO Civilizations_BritishIslesRequestedResource
			(Type,							Req1,				Req2,				Yield2,		Req3)
VALUES		('CIVILIZATION_ENGLAND',		'RESOURCE_SHEEP',	'RESOURCE_COW',		0,			'RESOURCE_STONE'),
			('CIVILIZATION_CELTS',			'RESOURCE_COPPER',	'RESOURCE_IRON',	2,			null),
			('CIVILIZATION_DENMARK',		'RESOURCE_FISH',	null,				0,			null);
--==========================================================================================================================
-- Civilizations_CaribbeanRequestedResource (Caribbean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CaribbeanRequestedResource
			(Type,							Req1,						Req2,				Yield2, Req3)
VALUES		('CIVILIZATION_AZTEC',			'RESOURCE_JFD_OBSIDIAN',	'RESOURCE_STONE',	0,		null),
			('CIVILIZATION_RUSSIA',			'RESOURCE_FUR',				'RESOURCE_IRON',	2,		null),
			('CIVILIZATION_SPAIN',			'RESOURCE_SUGAR',			'RESOURCE_FISH',	0,		'RESOURCE_CRAB'),
			('CIVILIZATION_DENMARK',		'RESOURCE_FISH',			'RESOURCE_CRAB',	0,		null),
			('CIVILIZATION_SWEDEN',			'RESOURCE_FUR',				null,				0,		null);
--==========================================================================================================================
-- Civilizations_EastAsiaRequestedResource (East-Asia Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR REPLACE INTO Civilizations_EastAsiaRequestedResource
			(Type,							Req1)
VALUES		('CIVILIZATION_CHINA',			'RESOURCE_JADE');
--==========================================================================================================================
-- Civilizations_SouthPacificRequestedResource (South Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthPacificRequestedResource
			(Type,							Req1,				Req2)
VALUES		('CIVILIZATION_POLYNESIA',		'RESOURCE_FISH',	'RESOURCE_WHALE');
--==========================================================================================================================
--==========================================================================================================================