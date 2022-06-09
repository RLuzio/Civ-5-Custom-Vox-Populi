-- Insert SQL Rules Here 
INSERT INTO Improvement_ResourceTypes
			(ImprovementType,				ResourceType)
SELECT		('IMPROVEMENT_MATHALX_CELESTIAL_KEYSTONE'),	ResourceType
FROM Improvement_ResourceTypes 	WHERE ImprovementType = 'IMPROVEMENT_QUARRY';

INSERT INTO Improvement_ResourceTypes
			(ImprovementType,				ResourceType)
SELECT		('IMPROVEMENT_MATHALX_CELESTIAL_KEYSTONE'),	ResourceType
FROM Improvement_ResourceTypes 	WHERE ImprovementType = 'IMPROVEMENT_MINE';

INSERT INTO Improvement_ResourceType_Yields
			(ImprovementType,				ResourceType,			YieldType,			Yield)
SELECT		('IMPROVEMENT_MATHALX_CELESTIAL_KEYSTONE'), ResourceType,	YieldType,	Yield
FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_QUARRY' AND YieldType <> 'YIELD_PRODUCTION';

INSERT INTO Improvement_ResourceType_Yields
			(ImprovementType,				ResourceType,			YieldType,			Yield)
SELECT		('IMPROVEMENT_MATHALX_CELESTIAL_KEYSTONE'), ResourceType,	YieldType,	Yield
FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_MINE' AND YieldType <> 'YIELD_PRODUCTION';

INSERT INTO Improvement_ResourceType_Yields
			(ImprovementType,				ResourceType,			YieldType,			Yield)
SELECT		('IMPROVEMENT_MATHALX_CELESTIAL_KEYSTONE'), ResourceType,	'YIELD_PRODUCTION',	1
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_QUARRY';

INSERT INTO Improvement_ResourceType_Yields
			(ImprovementType,				ResourceType,			YieldType,			Yield)
SELECT		('IMPROVEMENT_MATHALX_CELESTIAL_KEYSTONE'), ResourceType,	'YIELD_PRODUCTION',	1
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_MINE';