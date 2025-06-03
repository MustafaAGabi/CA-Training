USE [VehicleMakesDB]
GO

-- Problem 26
-- Get all vehicles that their body is 'Sport Utility' and Year > 2020
SELECT B.BodyName, VD.Vehicle_Display_Name, VD.Engine 
FROM VehicleDetails VD
INNER JOIN Bodies B ON VD.BodyID = B.BodyID
WHERE B.BodyName = N'Sport Utility' AND VD.[Year] > 200


-- Problem 27
-- Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
SELECT b.BodyName, *
FROM VehicleDetails VD
INNER JOIN Bodies B ON VD.BodyID = B.BodyID
WHERE B.BodyName IN ('Coupe', 'Hatchback', 'Sedan')

-- Problem 28
-- Get all vehicales that thier Body is 'Coupe' or 'Hatchback' or 'Sedan' And manufactured in year 2008 or 2020 or 2021
SELECT VD.ID, VD.Vehicle_Display_Name, VD.[Year], B.BodyName
FROM VehicleDetails VD
INNER JOIN Bodies B ON VD.BodyID = B.BodyID
WHERE VD.[Year] IN  (2008, 2020, 2021) AND B.BodyName IN ('Coupe', 'Hatchback', 'Sedan') 
ORDER BY VD.Vehicle_Display_Name


-- Problem 29
-- Return Found = 1 if there is any vehicale made in year 1950
SELECT Found = 1
WHERE EXISTS ( SELECT TOP 1 VD.Year FROM VehicleDetails VD WHERE VD.Year = 1950)

IF EXISTS (SELECT TOP 1 VD.Year FROM VehicleDetails VD WHERE VD.YEAR = 1950)
BEGIN
	SELECT Founde = 1
END;


-- Problem 30
-- Get all Vehicle_Display_Name, NumDoors, and add extra column to descripe number of doors by words
-- and if door is NULL display 'Not Set'
-- To Known Number of Doors For All Vehicles
SELECT DISTINCT NumDoors FROM VehicleDetails

SELECT VD.Vehicle_Display_Name, VD.NumDoors,
CASE
	WHEN VD.NumDoors = 0 THEN 'Zero Door'
	WHEN VD.NumDoors = 1 THEN 'One Door'
	WHEN VD.NumDoors = 2 THEN 'Tow dOORS'
	WHEN VD.NumDoors = 3 THEN 'Three dOORS'
	WHEN VD.NumDoors = 4 THEN 'Four dOORS'
	WHEN VD.NumDoors = 5 THEN 'Five dOORS'
	WHEN VD.NumDoors = 6 THEN 'Six dOORS'
	WHEN VD.NumDoors = 8 THEN 'Eight dOORS'
	WHEN VD.NumDoors IS NULL THEN 'Not Set'
	ELSE 'Unknown'
END AS DoorDescription
FROM VehicleDetails VD

SELECT Vehicle_Display_Name, NumDoors,
CASE 
	WHEN NumDoors IS NULL OR NumDoors = 0 THEN 'No Set'
	ELSE CAST( (SELECT NumDoors FROM VehicleDetails vd2 WHERE vd2.BodyID = vd1.BodyID) AS nvarchar(5)) + ' Door(s)'
END AS DoorDescription
FROM VehicleDetails vd1