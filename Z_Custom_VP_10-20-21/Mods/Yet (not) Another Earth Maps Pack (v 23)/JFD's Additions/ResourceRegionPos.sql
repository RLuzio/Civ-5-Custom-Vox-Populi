--==========================================================================================================================
-- Resource_AegeanRegionPosition (Aegean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_AegeanRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_AegeanRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('GREECE',						0,		0,		26,		51),
			('TURKEY',						26,		0,		35,		51);
--==========================================================================================================================
-- Resource_AfricaLargeRegionPosition (Africa)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_AfricaLargeRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_AfricaLargeRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('AFRICA',						0,		0,		65,		74),
			('WEST_AFRICA',					0,		40,		44,		13),
			('SOUTHEN_AFRICA',				0,		0,		64,		22),
			('CENTRAL_AFRICA',				0,		22,		43,		18),
			('EAST_AFRICA',					44,		22,		20,		31),
			('NORTH_AFRICA',				0,		53,		64,		20);
--==========================================================================================================================
-- Resource_AmericasRegionPosition (Americas)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_AmericasRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_AmericasRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('NORTH_AMERICA',				0,		48,		66,		31),
			('SOUTH_AMERICA',				0,		0,		66,		48);
--==========================================================================================================================
-- Resource_ApennineRegionPosition (Apennine)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_ApennineRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_ApennineRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('APENNINE',					0,		0,		60,		58),
			('AFRICA',						0,		0,		11,		25),
			('BALKANS',						45,		20,		15,		38),
			('ITALY',						0,		0,		44,		43);
--==========================================================================================================================
-- Resource_AsiaRegionPosition (Asia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_AsiaRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_AsiaRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('ASIA',						0,		0,		103,	63);
--==========================================================================================================================
-- Resource_BritishIslesRegionPosition (British Isles)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_BritishIslesRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_BritishIslesRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('BRITISH_ISLES',				0,		0,		61,		79);
--==========================================================================================================================
-- Resource_CaribbeanRegionPosition (Caribbean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_CaribbeanRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_CaribbeanRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('CARIBBEAN',					0,		0,		99,		69);
--==========================================================================================================================
-- Resource_EastAsiaRegionPosition (East Asia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_EastAsiaRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_EastAsiaRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('INDIA',						0,		24,		13,		53),
			('NORTH_ASIA',					0,		0,		11,		25),
			('SOUTHEAST_ASIA',				16,		0,		64,		79);
--==========================================================================================================================
-- Resource_MediterraneanRegionPosition (Mediterranean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_MediterraneanRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_MediterraneanRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('EUROPE',						0,		25,		102,	38),
			('AFRICA',						0,		0,		102,	25);
--==========================================================================================================================
-- Resource_MesopotamiaRegionPosition (Mesopotamia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_MesopotamiaRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_MesopotamiaRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('MESOPOTAMIA',					0,		0,		79,		49);
--==========================================================================================================================
-- Resource_NileVallyRegionPosition (Nile Valley)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_NileValleyRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_NileValleyRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('NILE_VALLEY',					0,		0,		80,		79);
--==========================================================================================================================
-- Resource_NorthAtlanticRegionPosition (North Atlantic)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_NorthAtlanticRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_NorthAtlanticRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('EUROPE',						50,		0,		55,		57),
			('AMERICA',						0,		0,		55,		57);
--==========================================================================================================================
-- Resource_NorthEastAsiaRegionPosition (North-East Asia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_NorthEastAsiaRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_NorthEastAsiaRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('ASIA',						0,		0,		63,		55);
--==========================================================================================================================
-- Resource_NorthWestEuropeRegionPosition (North-West Europe)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_NorthWestEuropeRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_NorthWestEuropeRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('EUROPE',						0,		0,		56,		67);
--==========================================================================================================================
-- Resource_PacificRegionPosition (Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_PacificRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_PacificRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('ASIA',						0,		0,		74,		79),
			('AMERICA',						74,		0,		40,		79);
--==========================================================================================================================
-- Resource_SouthPacificRegionPosition (South Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Resource_SouthPacificRegionPosition(Type, X, Y, Width, Height);
INSERT INTO Resource_SouthPacificRegionPosition
			(Type,							X,		Y,		Width,	Height)
VALUES		('SOUTH_PACIFIC',				0,		0,		99,		95);
--==========================================================================================================================
--==========================================================================================================================

