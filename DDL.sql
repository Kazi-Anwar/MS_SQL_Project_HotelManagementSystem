
-- Create a database
USE Master 
CREATE DATABASE HotelManagementSystem
GO 

USE HotelManagementSystem
go
Create Schema SQ_HotelMS 
GO 


-- Create a table for hotels
USE HotelManagementSystem
GO
CREATE TABLE SQ_HotelMS.Hotels 
(
    HotelID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);
GO 
-- Create a table for rooms
USE HotelManagementSystem
GO 
CREATE TABLE SQ_HotelMS.Rooms 
(
    RoomID INT PRIMARY KEY,
    RoomNumber INT,
    RoomType VARCHAR(50),
    Rate DECIMAL(10, 2),
    HotelID Int FOREIGN KEY REFERENCES SQ_HotelMS.Hotels(HotelID)
)
GO 

-- Create a table for guests
USE HotelManagementSystem
GO 
CREATE TABLE SQ_HotelMS.Guests 
(
    GuestID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15)
);
GO 

-- Create a table for reservations
USE HotelManagementSystem
GO 
CREATE TABLE SQ_HotelMS.Reservations 
(
    ReservationID INT PRIMARY KEY,
    GuestID INT FOREIGN KEY REFERENCES SQ_HotelMS.Guests(GuestID),
    RoomID INT FOREIGN KEY REFERENCES SQ_HotelMS.Rooms(RoomID),
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalAmount DECIMAL(10, 2)
);
GO 

--Employees Table:

USE HotelManagementSystem
GO 
CREATE TABLE SQ_HotelMS.Employees 
(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2),
    HotelID INT FOREIGN KEY REFERENCES SQ_HotelMS.Hotels(HotelID)
);
GO 

--Services Table:
USE HotelManagementSystem
GO 
CREATE TABLE SQ_HotelMS.Services 
(
    ServiceID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    Rate DECIMAL(10, 2)
);
GO 

--RoomServices Table:
USE HotelManagementSystem
GO
CREATE TABLE SQ_HotelMS.RoomServices 
(
    RoomServiceID INT PRIMARY KEY,
    ReservationID INT FOREIGN KEY REFERENCES SQ_HotelMS.Reservations(ReservationID),
    ServiceID INT FOREIGN KEY REFERENCES SQ_HotelMS.Services(ServiceID),
    Quantity INT, 
    TotalAmount DECIMAL(10, 2)   
);
GO 

---Payments Table:
USE HotelManagementSystem
GO 
CREATE TABLE SQ_HotelMS.Payments 
(
    PaymentID INT PRIMARY KEY,
    ReservationID INT FOREIGN KEY REFERENCES SQ_HotelMS.Reservations(ReservationID),
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    PaymentMethod VARCHAR(50)    
);
GO 

-- Create a table for individual room income
USE HotelManagementSystem
GO
CREATE TABLE SQ_HotelMS.RoomIncome 
(
    RoomIncomeID INT PRIMARY KEY,
    RoomID INT FOREIGN KEY REFERENCES SQ_HotelMS.Rooms(RoomID),
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalAmount DECIMAL(10, 2)    
);
GO 



-- Create a table for Total Profit and Loss
USE HotelManagementSystem
GO 
CREATE TABLE SQ_HotelMS.ProfitLoss 
(
    TransactionID INT PRIMARY KEY,
    Description VARCHAR(255),
    Amount DECIMAL(10, 2),
    TransactionDate DATE
);
GO 



-- Calculate total profit or loss
SELECT SUM(Amount) AS TotalProfitLoss
FROM SQ_HotelMS.ProfitLoss
GO 


-- Create a table for Room Availability
USE HotelManagementSystem
GO 
CREATE TABLE SQ_HotelMS.RoomAvailability 
(
    AvailabilityID INT PRIMARY KEY,
    RoomID INT FOREIGN KEY REFERENCES SQ_HotelMS.Rooms(RoomID),
    AvailabilityDate DATE,
    IsAvailable Varchar
);
GO 


---Create Store Procedure----
USE HotelManagementSystem
GO
CREATE PROCEDURE SQ_HotelMS.GetRoom
(
    @HotelID INT,
    @CheckInDate DATE,
    @CheckOutDate DATE
)
AS BEGIN
    SELECT
        R.RoomNumber,
        R.RoomType,
        R.Rate
    FROM
        SQ_HotelMS.Rooms R
    WHERE
        R.HotelID = @HotelID
        AND R.RoomID NOT IN (
            SELECT
                Res.RoomID
            FROM
                SQ_HotelMS.Reservations Res
            WHERE
                Res.CheckInDate < @CheckOutDate
                AND Res.CheckOutDate > @CheckInDate
        );
END 
GO

-- Create Function for Total Revenue
USE HotelManagementSystem
GO
CREATE FUNCTION SQ_HotelMS.CalculateTotalRevenue
(
    @HotelID INT,
    @CheckInDate DATE,
    @CheckOutDate DATE
)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE @totalRevenue DECIMAL (10,2) 
    FROM
        SQ_HotelMS.Reservations
    JOIN SQ_HotelMS.Rooms ON SQ_HotelMS.Reservations.RoomID = SQ_HotelMS.Rooms.RoomID
    WHERE
        SQ_HotelMS.Rooms.HotelID = @HotelID
        AND SQ_HotelMS.Reservations.CheckInDate >= @CheckInDate
        AND SQ_HotelMS.Reservations.CheckOutDate <= @CheckOutDate
	    RETURN @totalRevenue
END 
GO

