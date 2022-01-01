--==========================================================================================================================
-- MinorCiv_AegeanStartPosition (Aegean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_AegeanStartPosition(Type, X, Y, AltX, AltY);
--==========================================================================================================================
-- MinorCiv_ApennineStartPosition (Apennine)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_ApennineStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_ApennineStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_FLORENCE',			25,		45,		null,	null),
			('MINOR_CIV_GENOA',				17,		50,		null,	null),
			('MINOR_CIV_MILAN',				16,		63,		null,	null),
			('MINOR_CIV_RAGUSA',			16,		63,		null,	null),
			('MINOR_CIV_VALETTA',			35,		2,		null,	null),
			('MINOR_CIV_VATICAN_CITY',		29,		33,		null,	null);
--==========================================================================================================================
-- MinorCiv_AfricaLargeStartPosition (Africa)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_AfricaLargeStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_IFE',				22,		46,		null,	null),
			('MINOR_CIV_MBANZA_KONGO',		30,		28,		null,	null),
			('MINOR_CIV_ZANZIBAR',			53,		30,		null,	null),
			('MINOR_CIV_MARRAKECH',			13,		67,		null,	null),
			('MINOR_CIV_ANTANANARIVO',		56,		17,		null,	null),
			('MINOR_CIV_MOMBASA',			52,		33,		null,	null),
			('MINOR_CIV_MOGADISHU',			57,		40,		null,	null),
			('MINOR_CIV_CAPE_TOWN',			32,		3,		null,	null);
--==========================================================================================================================
-- MinorCiv_AmericasStartPosition (Americas)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_AmericasStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_BUENOS_AIRES',		53,		15,		null,	null),
			('MINOR_CIV_QUEBEC',			50,		60,		null,	null),
			('MINOR_CIV_VANCOUVER',			29,		61,		null,	null),
			('MINOR_CIV_CAHOKIA',			40,		54,		null,	null),
			('MINOR_CIV_LA_VENTA',			41,		41,		null,	null),
			('MINOR_CIV_PANAMA_CITY',		42,		39,		null,	null);
--==========================================================================================================================
-- MinorCiv_AsiaStartPosition (Asia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_AsiaStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_HONG_KONG',			68,		31,		null,	null),
			('MINOR_CIV_HANOI',				59,		30,		null,	null),
			('MINOR_CIV_MANILA',			79,		20,		null,	null),
			('MINOR_CIV_KABUL',				20,		43,		null,	null),
			('MINOR_CIV_SAMARKAND',			17,		49,		null,	null),
			('MINOR_CIV_ALMATY',			24,		43,		null,	null),
			('MINOR_CIV_LHASA',				38,		42,		null,	null),
			('MINOR_CIV_KATHMANDU',			34,		38,		null,	null),
			('MINOR_CIV_SINGAPORE',			58,		1,		null,	null),
			('MINOR_CIV_MALACCA',			56,		3,		null,	null),
			('MINOR_CIV_KUALA_LUMPUR',		55,		5,		null,	null),
			('MINOR_CIV_KYZYL',				33,		60,		null,	null),
			('MINOR_CIV_ORMUS',				3,		33,		null,	null),
			('MINOR_CIV_COLOMBO',			31,		10,		null,	null);
--==========================================================================================================================
-- MinorCiv_BritishIslesStartPosition (British Isles)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_BritishIslesStartPosition(Type, X, Y, AltX, AltY);
--==========================================================================================================================
-- MinorCiv_CaribbeanStartPosition (Caribbean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_CaribbeanStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_LA_VENTA',			32,		23,		null,	null),
			('MINOR_CIV_PANAMA_CITY',		48,		5,		null,	null);
--==========================================================================================================================
-- MinorCiv_EastAsiaStartPosition (East Asia Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_EastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_EastAsiaStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_COLOMBO',			3,		26,		null,	null),
			('MINOR_CIV_KUALA_LUMPUR',		24,		24,		null,	null),
			('MINOR_CIV_HANOI',				28,		42,		null,	null),
			('MINOR_CIV_HONG_KONG',			36,		43,		null,	null),
			('MINOR_CIV_KATHMANDU',			9,		53,		null,	null),
			('MINOR_CIV_LHASA',				15,		50,		null,	null),
			('MINOR_CIV_MALACCA',			25,		22,		null,	null),
			('MINOR_CIV_MANILA',			44,		36,		null,	null),
			('MINOR_CIV_SINGAPORE',			26,		20,		null,	null);
--==========================================================================================================================
-- MinorCiv_MediterraneanStartPosition (Mediterranean)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_MediterraneanStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_VATICAN_CITY',		43,		42,		null,	null),
			('MINOR_CIV_ZURICH',			36,		56,		null,	null),
			('MINOR_CIV_GENEVA',			32,		52,		null,	null),
			('MINOR_CIV_FLORENCE',			40,		51,		null,	null),
			('MINOR_CIV_GENOA',				36,		50,		null,	null),
			('MINOR_CIV_MONACO',			31,		47,		null,	null),
			('MINOR_CIV_RAGUSA',			47,		49,		null,	null),
			('MINOR_CIV_VALETTA',			49,		24,		null,	null),
			('MINOR_CIV_BUCHAREST',			72,		52,		null,	null),
			('MINOR_CIV_BELGRADE',			61,		46,		null,	null),
			('MINOR_CIV_MILAN',				35,		52,		null,	null),
			('MINOR_CIV_BUDAPEST',			54,		56,		null,	null),
			('MINOR_CIV_BRATISLAVA',		55,		60,		null,	null),
			('MINOR_CIV_PRAGUE',			47,		62,		null,	null),
			('MINOR_CIV_SOFIA',				66,		44,		null,	null),
			('MINOR_CIV_BYBLOS',			91,		28,		null,	null),
			('MINOR_CIV_SIDON',				90,		25,		null,	null),
			('MINOR_CIV_JERUSALEM',			91,		17,		null,	null),
			('MINOR_CIV_TYRE',				90,		19,		null,	null),
			('MINOR_CIV_YEREVAN',			100,	44,		null,	null);
--==========================================================================================================================
-- MinorCiv_MesopotamiaStartPosition (Mesopotamia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_MesopotamiaStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_SOFIA',				0,		45,		null,	null),
			('MINOR_CIV_BYBLOS',			31,		33,		null,	null),
			('MINOR_CIV_SIDON',				32,		28,		null,	null),
			('MINOR_CIV_JERUSALEM',			35,		16,		null,	null),
			('MINOR_CIV_TYRE',				32,		22,		null,	null),
			('MINOR_CIV_YEREVAN',			35,		46,		null,	null),
			('MINOR_CIV_UR',				56,		23,		null,	null);
--==========================================================================================================================
-- MinorCiv_NileValleyStartPosition (Nile Valley)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_NileValleyStartPosition(Type, X, Y, AltX, AltY);
--==========================================================================================================================
-- MinorCiv_NorthAtlanticStartPosition (North Atlantic)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_NorthAtlanticStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_RIGA',				53,		36,		null,	null),
			('MINOR_CIV_VALETTA',			103,	13,		null,	null),
			('MINOR_CIV_ANTWERP',			87,		33,		null,	null),
			('MINOR_CIV_RAGUSA',			99,		27,		null,	null),
			('MINOR_CIV_SOFIA',				105,	31,		null,	null),
			('MINOR_CIV_BRUSSELS',			89,		32,		null,	null),
			('MINOR_CIV_ZURICH',			92,		29,		null,	null),
			('MINOR_CIV_BRATISLAVA',		98,		35,		null,	null),
			('MINOR_CIV_QUEBEC',			22,		45,		null,	null),
			('MINOR_CIV_CAHOKIA',			4,		38,		null,	null),
			('MINOR_CIV_BUDAPEST',			99,		33,		null,	null),
			('MINOR_CIV_WITTENBERG',		94,		37,		null,	null),
			('MINOR_CIV_GENEVA',			92,		25,		null,	null),
			('MINOR_CIV_FLORENCE',			95,		25,		null,	null),
			('MINOR_CIV_MILAN',				93,		24,		null,	null),
			('MINOR_CIV_MONACO',			92,		21,		null,	null),
			('MINOR_CIV_GENOA',				93,		23,		null,	null),
			('MINOR_CIV_VATICAN_CITY',		98,		21,		null,	null),
			('MINOR_CIV_PRAGUE',			98,		36,		null,	null);
--==========================================================================================================================
-- MinorCiv_NorthEastAsiaStartPosition (North-East Asia)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_NorthEastAsiaStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_HONG_KONG',			0,		6,		null,	null);
--==========================================================================================================================
-- MinorCiv_NorthWestEuropeStartPosition (North-West Europe)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_NorthWestEuropeStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_RIGA',				95,		50,		null,	null),
			('MINOR_CIV_ZURICH',			37,		2,		null,	null),
			('MINOR_CIV_BUDAPEST',			50,		7,		null,	null),
			('MINOR_CIV_BRATISLAVA',		48,		11,		null,	null),
			('MINOR_CIV_ANTWERP',			27,		18,		null,	null),
			('MINOR_CIV_BRUSSELS',			29,		15,		null,	null),
			('MINOR_CIV_WITTENBERG',		39,		15,		null,	null),
			('MINOR_CIV_PRAGUE',			46,		13,		null,	null);
--==========================================================================================================================
-- MinorCiv_PacificStartPosition (Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_PacificStartPosition
			(Type,							X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_SYDNEY',			50,		7,		null,	null),
			('MINOR_CIV_WELLINGTON',		61,		5,		null,	null),
			('MINOR_CIV_HANOI',				26,		45,		null,	null),
			('MINOR_CIV_HONG_KONG',			33,		47,		null,	null),
			('MINOR_CIV_KATHMANDU',			15,		51,		null,	null),
			('MINOR_CIV_MANILA',			37,		39,		null,	null),
			('MINOR_CIV_VANCOUVER',			102,	62,		null,	null),
			('MINOR_CIV_LHASA',				17,		55,		null,	null),
			('MINOR_CIV_MELBOURNE',			48,		4,		null,	null),
			('MINOR_CIV_KUALA_LUMPUR',		31,		36,		null,	null),
			('MINOR_CIV_COLOMBO',			10,		33,		null,	null),
			('MINOR_CIV_MALACCA',			22,		34,		null,	null),
			('MINOR_CIV_SINGAPORE',			24,		32,		null,	null);
--==========================================================================================================================
-- MinorCiv_SouthPacificStartPosition (South Pacific)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_SouthPacificStartPosition(Type, X, Y, AltX, AltY);
--==========================================================================================================================
--==========================================================================================================================