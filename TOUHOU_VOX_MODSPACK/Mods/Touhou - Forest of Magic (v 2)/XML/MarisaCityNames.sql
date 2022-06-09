-- Insert SQL Rules Here 
-- Create a temp city name table keeping all the primary clan name
CREATE TABLE Civilization_CityNames_ForestOfMagic AS
SELECT * FROM Civilization_CityNames
  WHERE CityName='TXT_KEY_CITY_NAME_TH_FOREST_OF_MAGIC_1'
  ORDER BY rowid DESC LIMIT 1;

-- Copy the remaining cities to the temp table in a random order  
INSERT INTO Civilization_CityNames_ForestOfMagic
SELECT * FROM Civilization_CityNames
  WHERE CivilizationType='CIVILIZATION_TH_FOREST_OF_MAGIC' AND CityName<>'TXT_KEY_CITY_NAME_TH_FOREST_OF_MAGIC_1'
  ORDER BY RANDOM();

-- Copy everything back from the temp table, keeping the same order, and then tidy up after ourselves
DELETE FROM Civilization_CityNames WHERE CivilizationType='CIVILIZATION_TH_FOREST_OF_MAGIC';
INSERT INTO Civilization_CityNames SELECT * FROM Civilization_CityNames_ForestOfMagic ORDER BY rowid ASC;
DROP TABLE Civilization_CityNames_ForestOfMagic;