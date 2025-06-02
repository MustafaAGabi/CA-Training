USE [VehicleMakesDB]
GO

-- Problem 26
-- Get all vehicles that their body is 'Sport Utility' and Year > 2020
SELECT B.BodyName, VD.Vehicle_Display_Name, VD.Engine 
FROM VehicleDetails VD
INNER JOIN Bodies B ON VD.BodyID = B.BodyID
WHERE B.BodyName = N'Sport Utility' AND VD.[Year] > 200

