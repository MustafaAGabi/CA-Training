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


-- Problem 31
-- Get all vehicales_Display_Name, year, and add extra columnto calculate the age of the car
-- then sort the results by age disc
SELECT GETDATE()		-- Return tha Current Date
SELECT YEAR(GETDATE())  -- Return The Current Year
SELECT DAY(GETDATE())	-- Return The Current Day
-- Get Diff Between Tow Dates
SELECT DATEDIFF(YEAR, DATEFROMPARTS(YEAR(GETDATE()),1,1), GETDATE())
SELECT DATEDIFF(MONTH, DATEFROMPARTS(YEAR(GETDATE()),1,1), GETDATE())
SELECT DATEDIFF(DAY, DATEFROMPARTS(YEAR(GETDATE()),1,1), GETDATE())

SELECT VD.Vehicle_Display_Name, VD.Year,Age = (YEAR(GETDATE()) - VD.Year) 
FROM VehicleDetails VD
ORDER BY Age DESC


-- Problem 32
-- Get all Vehicle_Display_Name, year, Age
-- for vehicles that their age between 15 and 25 years old
-- Solution 1 slow
SELECT VD.Vehicle_Display_Name, VD.Year, Age = (YEAR(GETDATE()) - VD.Year)
FROM VehicleDetails VD
WHERE (YEAR(GETDATE()) - VD.Year) BETWEEN 15 AND 25
ORDER BY Age ASC

-- Solution 2 faster
SELECT * FROM (
	SELECT  VD.Vehicle_Display_Name, VD.Year, Age = (YEAR(GETDATE()) - VD.Year)
	FROM VehicleDetails VD
) AS R1
WHERE R1.Age BETWEEN 15 AND 25
ORDER BY R1.Age ASC


-- Problem 33
-- Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles
SELECT MIN(VD.Engine_CC), Max(VD.Engine_CC), AVG(VD.Engine_CC) FROM VehicleDetails VD

-- Problem 34
-- Get all vehicles that have the minimum Engine_CC
SELECT VD1.Vehicle_Display_Name, VD1.Engine_CC
FROM VehicleDetails VD1
WHERE VD1.Engine_CC = (SELECT MIN(VD2.Engine_CC) AS MinEngineCC FROM VehicleDetails VD2)

-- Problem 35
-- Get all vehicles that have the Maximum Engine_CC
SELECT VD1.Vehicle_Display_Name, VD1.Engine_CC
FROM VehicleDetails VD1
WHERE VD1.Engine_CC = (SELECT MAX(VD2.Engine_CC) AS MaxEngineCC FROM VehicleDetails VD2)


-- Problem 36
-- Get all vehicles that have Engin_CC below average
SELECT * FROM VehicleDetails VD
WHERE VD.Engine_CC < ( SELECT  Avg(VD1.Engine_CC) AS AverageEngineCC FROM VehicleDetails VD1 )


-- Problem 37
-- Get total vehicles that have Engin_CC above average
SELECT Count(*) AS NumberOfVehiclesAboveAverageEngineCC
FROM VehicleDetails VD
WHERE VD.Engine_CC > (SELECT Avg(VD1.Engine_CC) AS AvgEngineCC FROM VehicleDetails VD1)

SELECT Count(*) AS NumberOfVehiclesAboveAverageEngineCC FROM
(
	SELECT ID,VD.Vehicle_Display_Name FROM VehicleDetails VD
	WHERE VD.Engine_CC > ( SELECT  Avg(Engine_CC) AS MinEngineCC  FROM VehicleDetails)

) R1

-- Problem 38
-- Get all unique Engine_CC And sort them Desc
SELECT DISTINCT Engine_CC 
FROM VehicleDetails
ORDER BY Engine_CC DESC