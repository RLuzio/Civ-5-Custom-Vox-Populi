-- Insert SQL Rules Here 
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);

INSERT INTO Leader_SharedTraits
            (LeaderType,						TraitOne,                   TraitTwo)
VALUES      ('LEADER_MATHALX_TENKO',			'POLICY_EXPANSIVE_X',		'POLICY_PROTECTIVE_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'TXT_KEY_LEADER_MATHALX_TENKO_CIV_IV'
	ELSE 'TXT_KEY_LEADER_MATHALX_TENKO' END) 
WHERE Type = 'LEADER_MATHALX_TENKO';