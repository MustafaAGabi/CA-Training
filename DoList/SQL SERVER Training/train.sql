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


