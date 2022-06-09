--==========================================================================================================================
-- Improvement_ResourceTypes
--==========================================================================================================================
INSERT INTO Improvement_ResourceTypes
			(ImprovementType,							ResourceType)
SELECT		('IMPROVEMENT_BRANCH_SHRINE'), 	ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_PLANTATION';

INSERT INTO Improvement_ResourceTypes
			(ImprovementType,							ResourceType)
SELECT		('IMPROVEMENT_BRANCH_SHRINE'), 	ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_CAMP';

INSERT INTO Improvement_ResourceTypes
			(ImprovementType,							ResourceType)
SELECT		('IMPROVEMENT_BRANCH_SHRINE'), 	ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_PASTURE';

INSERT INTO Improvement_ResourceTypes
			(ImprovementType,							ResourceType)
SELECT		('IMPROVEMENT_BRANCH_SHRINE'), 	ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_MINE';

INSERT INTO Improvement_ResourceTypes
			(ImprovementType,							ResourceType)
SELECT		('IMPROVEMENT_BRANCH_SHRINE'), 	ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_QUARRY';