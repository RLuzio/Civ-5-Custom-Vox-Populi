-- Created by ModBuddy on 3/22/2016 10:38:47 PM

INSERT INTO ArtDefine_LandmarkTypes
		(Type,								LandmarkType,	FriendlyName)
SELECT	'ART_DEF_IMPROVEMENT_DOLLHOUSE',	LandmarkType,	'Doll Lumbermill'
FROM	ArtDefine_LandmarkTypes WHERE (Type = 'ART_DEF_IMPROVEMENT_FORT');

INSERT INTO ArtDefine_Landmarks
		(Era,	State,	Scale,	ImprovementType,					LayoutHandler,	ResourceType,	Model,	TerrainContour,	Tech)
SELECT	Era,	State,	0.7,	'ART_DEF_IMPROVEMENT_DOLLHOUSE',	LayoutHandler,	ResourceType,	Model,	TerrainContour,	Tech
FROM	ArtDefine_Landmarks WHERE (ImprovementType = 'ART_DEF_IMPROVEMENT_FORT');

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType,					TileType,	Asset)
SELECT	'ART_DEF_IMPROVEMENT_DOLLHOUSE',	TileType,	'SV_Dollhouse.dds'
FROM	ArtDefine_StrategicView WHERE (StrategicViewType = 'ART_DEF_IMPROVEMENT_FORT');