--==========================================================================================================================
-- Civilizations_AegeanStartPosition (Aegean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AegeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AegeanStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_BYZANTIUM',				34,		43,		null,	null),
			('CIVILIZATION_GREECE',					13,		21,		null,	null),
			('CIVILIZATION_OTTOMAN',				49,		35,		34,		43);
--==========================================================================================================================
-- Civilizations_AfricaStartPosition (Africa)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_CARTHAGE',				26,		69,		null,	null),
			('CIVILIZATION_EGYPT',					42,		64,		null,	null),
			('CIVILIZATION_ETHIOPIA',				52,		44,		null,	null),
			('CIVILIZATION_MOROCCO',				13,		67,		null,	null),
			('CIVILIZATION_SONGHAI',				19,		53,		null,	null),
			('CIVILIZATION_ZULU',					45,		12,		null,	null);
--==========================================================================================================================
-- Civilizations_AmericasStartPosition (Americas)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_POLYNESIA',				8,		45,		null,	null),
			('CIVILIZATION_BRAZIL',					58,		22,		null,	null),
			('CIVILIZATION_INCA',					46,		29,		null,	null),
			('CIVILIZATION_AMERICA',				46,		54,		null,	null),
			('CIVILIZATION_SHOSHONE',				34,		59,		null,	null),
			('CIVILIZATION_IROQUOIS',				45,		60,		null,	null),
			('CIVILIZATION_MAYA',					40,		42,		null,	null),
			('CIVILIZATION_AZTEC',					35,		45,		 null,	null),
			('CIVILIZATION_ENGLAND',				48,		57,		 null,	null),
			('CIVILIZATION_FRANCE',					51,		61,		 null,	null),
			('CIVILIZATION_NETHERLANDS',			51,		37,		 null,	null),
			('CIVILIZATION_RUSSIA',					20,		66,		 null,	null),
			('CIVILIZATION_SWEDEN',					46,		56,		 null,	null),
			('CIVILIZATION_PORTUGAL',				59,		26,		 null,	null),
			('CIVILIZATION_SPAIN',					48,		43,		 null,	null),
			('CIVILIZATION_DENMARK',				50,		43,		 null,	null);
--==========================================================================================================================
-- Civilizations_ApennineStartPosition (Apennine)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_ApennineStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_ApennineStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_CARTHAGE',				19,		7,		null,	null),
			('CIVILIZATION_ROME',					29,		33,		null,	null),
			('CIVILIZATION_VENICE',					29,		54,		null,	null);
--==========================================================================================================================
-- Civilizations_AsiaStartPosition (Asia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_INDIA',					25,		35,		null,	null),
			('CIVILIZATION_CHINA',					67,		55,		null,	null),
			('CIVILIZATION_JAPAN',					91,		50,		null,	null),
			('CIVILIZATION_MONGOL',					53,		55,		null,	null),
			('CIVILIZATION_PERSIA',					8,		40,		null,	null),
			('CIVILIZATION_INDONESIA',				55,		0,		null,	null),
			('CIVILIZATION_KOREA',					79,		54,		null,	null),
			('CIVILIZATION_SIAM',					57,		19,		null,	null);
--==========================================================================================================================
-- Civilizations_BritishIslesStartPosition (British Isles)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_BritishIslesStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_BritishIslesStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_CELTS',					32,		51,		null,	null),
			('CIVILIZATION_DENMARK',				61,		46,		null,	null),
			('CIVILIZATION_ENGLAND',				44,		16,		null,	null);
--==========================================================================================================================
-- Civilizations_CaribbeanStartPosition (Caribbean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaribbeanStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MAYA',					24,		30,		null,	null),
			('CIVILIZATION_AZTEC',					6,		37,		null,	null),
			('CIVILIZATION_NETHERLANDS',			92,		3,		null,	null),
			('CIVILIZATION_SPAIN',					44,		55,		null,	null),
			('CIVILIZATION_ENGLAND',				54,		32,		null,	null),
			('CIVILIZATION_FRANCE',					66,		36,		null,	null),
			('CIVILIZATION_DENMARK',				80,		33,		null,	null),
			('CIVILIZATION_SWEDEN',					86,		30,		null,	null);
----==========================================================================================================================
-- Civilizations_MediterraneanStartPosition (Mediterranean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_ROME',					43,		42,		null,	null),
			('CIVILIZATION_SPAIN',					10,		40,		null,	null),
			('CIVILIZATION_PORTUGAL',				1,		40,		null,	null),
			('CIVILIZATION_GREECE',					64,		30,		null,	null),
			('CIVILIZATION_CARTHAGE',				38,		26,		null,	null),
			('CIVILIZATION_AUSTRIA',				47,		58,		null,	null),
			('CIVILIZATION_VENICE',					42,		51,		null,	null),
			('CIVILIZATION_ASSYRIA',				99,		29,		null,	null),
			('CIVILIZATION_FRANCE',					29,		63,		null,	null),
			('CIVILIZATION_MOROCCO',				2,		22,		null,	null),
			('CIVILIZATION_EGYPT',					83,		7,		null,	null),
			('CIVILIZATION_BYZANTIUM',				72,		41,		null,	null),
			('CIVILIZATION_OTTOMAN',				80,		37,		null,	null);
--==========================================================================================================================
-- Civilizations_MesopotamiaStartPosition (Mesopotamia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_BYZANTIUM',				12,		39,		null,	null),
			('CIVILIZATION_GREECE',					7,		22,		null,	null),
			('CIVILIZATION_OTTOMAN',				22,		38,		null,	null),
			('CIVILIZATION_ARABIA',					45,		0,		null,	null),
			('CIVILIZATION_EGYPT',					26,		6,		null,	null),
			('CIVILIZATION_PERSIA',					79,		25,		null,	null),
			('CIVILIZATION_ASSYRIA',				45,		38,		null,	null),
			('CIVILIZATION_BABYLON',				51,		26,		null,	null);
--==========================================================================================================================
-- Civilizations_NileValleyStartPosition (Nile Valley)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NileValleyStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_EGYPT',					26,		62,		null,	null),
			('CIVILIZATION_ARABIA',					78,		32,		null,	null);
--==========================================================================================================================
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_AMERICA',				11,		34,		null,	null),
			('CIVILIZATION_IROQUOIS',				13,		40,		null,	null),
			('CIVILIZATION_GERMANY',				92,		37,		null,	null),
			('CIVILIZATION_AUSTRIA',				95,		33,		null,	null),
			('CIVILIZATION_RUSSIA',					103,	46,		null,	null),
			('CIVILIZATION_POLAND',					97,		43,		null,	null),
			('CIVILIZATION_CELTS',					79,		35,		null,	null),
			('CIVILIZATION_ENGLAND',				83,		31,		null,	null),
			('CIVILIZATION_VENICE',					96,		26,		null,	null),
			('CIVILIZATION_MOROCCO',				85,		0,		null,	null),
			('CIVILIZATION_DENMARK',				89,		42,		null,	null),
			('CIVILIZATION_SWEDEN',					88,		51,		null,	null),
			('CIVILIZATION_FRANCE',					88,		26,		null,	null),
			('CIVILIZATION_CARTHAGE',				99,		11,		null,	null),
			('CIVILIZATION_ROME',					98,		21,		null,	null),
			('CIVILIZATION_NETHERLANDS',			86,		34,		null,	null),
			('CIVILIZATION_SPAIN',					85,		9,		null,	null),
			('CIVILIZATION_PORTUGAL',				80,		5,		null,	null);
--==========================================================================================================================
-- Civilizations_NorthEastAsiaStartPosition (North-East Asia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthEastAsiaStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_CHINA',					6,		40,		null,	null),
			('CIVILIZATION_JAPAN',					45,		27,		null,	null),
			('CIVILIZATION_KOREA',					23,		35,		null,	null);
--==========================================================================================================================
-- Civilizations_NorthWestEuropeStartPosition (North-West Europe)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_ENGLAND',				18,		18,		null,	null),
			('CIVILIZATION_CELTS',					16,		28,		null,	null),
			('CIVILIZATION_DENMARK',				36,		29,		null,	null),
			('CIVILIZATION_SWEDEN',					43,		43,		null,	null),
			('CIVILIZATION_FRANCE',					20,		8,		null,	null),
			('CIVILIZATION_GERMANY',				41,		19,		null,	null),
			('CIVILIZATION_POLAND',					46,		21,		null,	null),
			('CIVILIZATION_RUSSIA',					56,		27,		null,	null),
			('CIVILIZATION_AUSTRIA',				45,		6,		null,	null),
			('CIVILIZATION_NETHERLANDS',			25,		18,		null,	null);
--==========================================================================================================================
-- Civilizations_PacificStartPosition (Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_SHOSHONE',				111,	59,		null,	null),
			('CIVILIZATION_JAPAN',					43,		56,		null,	null),
			('CIVILIZATION_CHINA',					33,		59,		null,	null),
			('CIVILIZATION_POLYNESIA',				79,		44,		null,	null),
			('CIVILIZATION_KOREA',					39,		59,		null,	null),
			('CIVILIZATION_INDIA',					7,		49,		null,	null),
			('CIVILIZATION_INDONESIA',				27,		24,		null,	null),
			('CIVILIZATION_SIAM',					23,		44,		null,	null),
			('CIVILIZATION_MONGOL',					22,		64,		null,	null);
--==========================================================================================================================
-- Civilizations_EastAsiaStartPosition (South-East Asia Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT OR REPLACE INTO Civilizations_EastAsiaStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_CHINA',					40,		66,		null,	null),
			('CIVILIZATION_INDIA',					12,		46,		null,	null),
			('CIVILIZATION_INDONESIA',				30,		12,		null,	null),
			('CIVILIZATION_JAPAN',					59,		61,		null,	null),
			('CIVILIZATION_KOREA',					49,		63,		null,	null),
			('CIVILIZATION_MONGOL',					31,		70,		null,	null),
			('CIVILIZATION_SIAM',					22,		40,		null,	null);
--==========================================================================================================================
-- Civilizations_SouthPacificStartPosition (South Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificStartPosition
			(Type,									X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_POLYNESIA',				49,		88,		null,	null);
--==========================================================================================================================
--==========================================================================================================================