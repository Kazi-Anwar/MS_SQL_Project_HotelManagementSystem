-- Insert sample data
INSERT INTO SQ_HotelMS.Hotels (HotelID, Name, Location) VALUES (1, 'Sample Hotel', 'Sample Location');

INSERT INTO SQ_HotelMS.Rooms (RoomID, HotelID, RoomNumber, RoomType, Rate) VALUES (1, 1, 101, 'Single', 100.00),
																				  (2, 1, 102, 'Double', 150.00),
																				  (3, 1, 201, 'Suite', 200.00);
GO 

INSERT INTO SQ_HotelMS.Guests (GuestID, FirstName, LastName, Email, PhoneNumber) 
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890'),
       (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210');
GO 

INSERT INTO SQ_HotelMS.Reservations (ReservationID, GuestID, RoomID, CheckInDate, CheckOutDate, TotalAmount) 
VALUES (1, 1, 1, '2023-01-01', '2023-01-05', 400.00),
	   (2, 2, 2, '2023-02-01', '2023-02-07', 900.00);
GO  

-- Insert sample data
INSERT INTO SQ_HotelMS.RoomIncome (RoomIncomeID, RoomID, CheckInDate, CheckOutDate, TotalAmount) 
VALUES (1, 1, '2023-01-01', '2023-01-05', 400.00),
	   (2, 2, '2023-02-01', '2023-02-07', 900.00);
GO 

-- Insert sample data

INSERT INTO SQ_HotelMS.ProfitLoss (TransactionID, Description, Amount, TransactionDate) 
VALUES (1, 'Room Income', 1300.00, '2023-01-05'),
		(2, 'Room Income', 1800.00, '2023-02-07'),
		(3, 'Employee Salary', -500.00, '2023-02-15'),
		(4, 'Room Service Income', 50.00, '2023-02-10'),
		(5, 'Utilities Expense', -200.00, '2023-01-20');
GO 

-- Insert sample data
INSERT INTO SQ_HotelMS.RoomAvailability (AvailabilityID, RoomID, AvailabilityDate, IsAvailable) 
VALUES (1, 1, '2023-01-01', 'T'),
	   (2, 1, '2023-01-02', 'T'),
	   (3, 1, '2023-01-03', 'T');
GO 

-- Check room availability for a specific date
SELECT RoomID, AvailabilityDate, IsAvailable
FROM SQ_HotelMS.RoomAvailability
WHERE RoomID = 1 AND AvailabilityDate = '2023-01-02';
GO 