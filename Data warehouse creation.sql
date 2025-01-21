-- Complete listing of SQL Code used in my portfolio project
-- Part 1: create OLTP tables
-- Drop tables if they exist
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS CustomerInquiry;
DROP TABLE IF EXISTS FlightRoute;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Passenger;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Agent;
-- Create a table for Flight Route dimension
CREATE TABLE FlightRoute (
    RouteID SERIAL PRIMARY KEY,
    OriginAirport VARCHAR(50) NOT NULL,
    DestinationAirport VARCHAR(50) NOT NULL,
    Distance INT,
    FlightTime INTERVAL);
-- Create a table for Aircraft dimension
CREATE TABLE Aircraft (
    AircraftID SERIAL PRIMARY KEY,  Manufacturer VARCHAR(50),
    Model VARCHAR(50),
    Capacity INT);
-- Create a table for Passenger dimension
CREATE TABLE Passenger (
    PassengerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Email VARCHAR(100));
-- Create a table for Service dimension
CREATE TABLE Service (
    ServiceID SERIAL PRIMARY KEY,
    ServiceType VARCHAR(50),
    ServiceDescription TEXT);
-- Create a table for Agent dimension
CREATE TABLE Agent (
    AgentID SERIAL PRIMARY KEY,
    AgentName VARCHAR(100),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100));
-- Create a table for Customer Inquiry dimension
CREATE TABLE CustomerInquiry (
    InquiryID SERIAL PRIMARY KEY,
    PassengerID INT REFERENCES Passenger(PassengerID),
    InquiryDate DATE,
    InquiryDescription TEXT);
-- Create a table for Flight fact
CREATE TABLE Flight (
    FlightID SERIAL PRIMARY KEY,
    RouteID INT REFERENCES FlightRoute(RouteID),
    AircraftID INT REFERENCES Aircraft(AircraftID),
    FlightDate DATE NOT NULL,
    DepartureTime TIMESTAMP,
    ArrivalTime TIMESTAMP,
    FlightStatus VARCHAR(50));
-- Create a table for Transaction fact
CREATE TABLE Transactions (
    TransactionID SERIAL PRIMARY KEY,
    FlightID INT REFERENCES Flight(FlightID),
    PassengerID INT REFERENCES Passenger(PassengerID),
    AgentID INT REFERENCES Agent(AgentID),
    TransactionDate TIMESTAMP NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50));

-- Part 2: populate OLTP tables with sample airline data
-- Populate FlightRoute table
INSERT INTO FlightRoute (RouteID, OriginAirport, DestinationAirport, Distance, FlightTime) VALUES
(1, 'New York', 'Los Angeles', 2475, '5:30:00'),
(2, 'Chicago', 'Miami', 1370, '3:20:00'),
(3, 'Dallas', 'San Francisco', 1464, '4:10:00'),
(4, 'Seattle', 'Denver', 1021, '2:50:00'),
(5, 'Boston', 'Houston', 1627, '4:00:00'),
(6, 'Phoenix', 'Atlanta', 1588, '3:45:00'),
(7, 'Orlando', 'Las Vegas', 2034, '4:55:00'),
(8, 'San Diego', 'Portland', 1092, '2:45:00'),
(9, 'Philadelphia', 'Austin', 1548, '3:50:00'),
(10, 'Nashville', 'Detroit', 533, '1:30:00');
-- Populate Aircraft table
INSERT INTO Aircraft (AircraftID, Manufacturer, Model, Capacity) VALUES
(1, 'Boeing', '737-800', 189),
(2, 'Airbus', 'A320', 180),
(3, 'Boeing', '777-300', 396),
(4, 'Embraer', 'E195', 132),
(5, 'Airbus', 'A350', 350),
(6, 'Boeing', '787-9', 296),
(7, 'Bombardier', 'CRJ900', 90),
(8, 'Airbus', 'A220', 135),
(9, 'Cessna', 'Citation X', 12),
(10, 'Dassault', 'Falcon 8X', 14);
-- Populate Passenger table
INSERT INTO Passenger (PassengerID, FirstName, LastName, DateOfBirth, Email) VALUES
(1, 'John', 'Doe', '1985-07-14', 'john.doe@example.com'),
(2, 'Jane', 'Smith', '1990-02-28', 'jane.smith@example.com'),
(3, 'Alice', 'Johnson', '1975-05-23', 'alice.johnson@example.com'),
(4, 'Bob', 'Williams', '2000-08-15', 'bob.williams@example.com'),
(5, 'Emily', 'Brown', '1995-11-02', 'emily.brown@example.com'),
(6, 'Michael', 'Jones', '1988-03-19', 'michael.jones@example.com'),
(7, 'Sarah', 'Davis', '1993-06-25', 'sarah.davis@example.com'),
(8, 'Chris', 'Miller', '1978-12-08', 'chris.miller@example.com'),
(9, 'Jessica', 'Wilson', '1999-01-17', 'jessica.wilson@example.com'),
(10, 'David', 'Moore', '1980-04-11', 'david.moore@example.com'),
(11, 'Olivia', 'Taylor', '1992-09-22', 'olivia.taylor@example.com'),
(12, 'Daniel', 'Anderson', '1987-05-06', 'daniel.anderson@example.com'),
(13, 'Sophia', 'Thomas', '1991-03-15', 'sophia.thomas@example.com'),
(14, 'James', 'Jackson', '1983-10-30', 'james.jackson@example.com'),
(15, 'Isabella', 'White', '1996-07-09', 'isabella.white@example.com'),
(16, 'Matthew', 'Harris', '1998-02-14', 'matthew.harris@example.com'),
(17, 'Ava', 'Martin', '1989-12-04', 'ava.martin@example.com'),
(18, 'Andrew', 'Thompson', '1981-06-18', 'andrew.thompson@example.com'),
(19, 'Mia', 'Garcia', '1994-11-20', 'mia.garcia@example.com'),
(20, 'Ethan', 'Martinez', '1986-08-07', 'ethan.martinez@example.com'),
(21, 'Abigail', 'Robinson', '1997-01-01', 'abigail.robinson@example.com'),
(22, 'Logan', 'Clark', '1976-09-12', 'logan.clark@example.com'),
(23, 'Charlotte', 'Rodriguez', '1984-03-28', 'charlotte.rodriguez@example.com'),
(24, 'Mason', 'Lewis', '1979-07-18', 'mason.lewis@example.com'),
(25, 'Harper', 'Lee', '1993-10-25', 'harper.lee@example.com'),
(26, 'Lucas', 'Walker', '1990-05-01', 'lucas.walker@example.com'),
(27, 'Ella', 'Hall', '1982-12-22', 'ella.hall@example.com'),
(28, 'Jackson', 'Allen', '1985-04-09', 'jackson.allen@example.com'),
(29, 'Amelia', 'Young', '1998-11-15', 'amelia.young@example.com'),
(30, 'Alexander', 'King', '1977-02-06', 'alexander.king@example.com');
-- Populate Service table
INSERT INTO Service (ServiceID, ServiceType, ServiceDescription) VALUES
(1, 'In-flight Meal', 'Hot meals and beverages served during the flight'),
(2, 'Priority Boarding', 'Exclusive boarding for passengers with priority tickets'),
(3, 'Extra Baggage', 'Allowance for additional checked luggage'),
(4, 'Wi-Fi', 'High-speed internet access during flight'),
(5, 'Lounge Access', 'Access to exclusive airport lounges'),
(6, 'Seat Selection', 'Choose your preferred seat in advance'),
(7, 'Entertainment', 'Access to in-flight movies and music'),
(8, 'Medical Assistance', 'Special assistance for passengers with medical needs'),
(9, 'Pet Travel', 'Travel accommodations for pets'),
(10, 'Wheelchair Assistance', 'Support for passengers requiring wheelchairs');
-- Populate Agent table
INSERT INTO Agent (AgentID, AgentName, ContactNumber, Email) VALUES
(1, 'Agent A', '123-456-7890', 'agent.a@example.com'),
(2, 'Agent B', '234-567-8901', 'agent.b@example.com'),
(3, 'Agent C', '345-678-9012', 'agent.c@example.com'),
(4, 'Agent D', '456-789-0123', 'agent.d@example.com'),
(5, 'Agent E', '567-890-1234', 'agent.e@example.com'),
(6, 'Agent F', '678-901-2345', 'agent.f@example.com'),
(7, 'Agent G', '789-012-3456', 'agent.g@example.com'),
(8, 'Agent H', '890-123-4567', 'agent.h@example.com'),
(9, 'Agent I', '901-234-5678', 'agent.i@example.com'),
(10, 'Agent J', '012-345-6789', 'agent.j@example.com');
-- Populate CustomerInquiry table
INSERT INTO CustomerInquiry (InquiryID, PassengerID, InquiryDate, InquiryDescription) VALUES
(1, 1, '2025-01-01', 'Query about flight status'),
(2, 2, '2025-01-02', 'Request for seat upgrade'),
(3, 3, '2025-01-03', 'Inquiry about baggage allowance'),
(4, 4, '2025-01-04', 'Question about cancellation policy'),
(5, 5, '2025-01-05', 'Request for refund'),
(6, 6, '2025-01-06', 'Inquiry about special meal options'),
(7, 7, '2025-01-07', 'Request for wheelchair assistance'),
(8, 8, '2025-01-08', 'Inquiry about pet travel policy'),
(9, 9, '2025-01-09', 'Request for lounge access details'),
(10, 10, '2025-01-10', 'Question about flight delay compensation');
-- Populate Flight table
INSERT INTO Flight (FlightID, RouteID, AircraftID, FlightDate, DepartureTime, ArrivalTime, FlightStatus) VALUES
(1, 1, 1, '2025-01-10', '2025-01-10 08:00:00', '2025-01-10 13:30:00', 'On Time'),
(2, 2, 2, '2025-01-11', '2025-01-11 09:00:00', '2025-01-11 12:20:00', 'Delayed'),
(3, 3, 3, '2025-01-12', '2025-01-12 10:00:00', '2025-01-12 14:10:00', 'On Time'),
(4, 4, 4, '2025-01-13', '2025-01-13 11:00:00', '2025-01-13 13:50:00', 'Cancelled'),
(5, 5, 5, '2025-01-14', '2025-01-14 12:00:00', '2025-01-14 16:00:00', 'On Time');
-- Populate Transactions table
INSERT INTO Transactions (TransactionID, FlightID, PassengerID, AgentID, TransactionDate, Amount, PaymentMethod) VALUES
(1, 1, 1, 1, '2025-01-05 10:00:00', 350.00, 'Credit Card'),
(2, 2, 2, 2, '2025-01-06 11:00:00', 450.00, 'Debit Card'),
(3, 3, 3, 3, '2025-01-07 12:00:00', 500.00, 'PayPal'),
(4, 4, 4, 4, '2025-01-08 13:00:00', 400.00, 'Cash'),
(5, 5, 5, 5, '2025-01-09 14:00:00', 550.00, 'Credit Card');

-- Part 3: create staging tables
-- Drop staging tables if they exist
DROP TABLE IF EXISTS Staging_FlightRoute;
DROP TABLE IF EXISTS Staging_Aircraft;
DROP TABLE IF EXISTS Staging_Passenger;
DROP TABLE IF EXISTS Staging_Service;
DROP TABLE IF EXISTS Staging_Agent;
DROP TABLE IF EXISTS Staging_CustomerInquiry;
DROP TABLE IF EXISTS Staging_Flight;
DROP TABLE IF EXISTS Staging_Transactions;
-- Create staging table for Flight Route
CREATE TABLE Staging_FlightRoute (
    RouteID INT,
    OriginAirport VARCHAR(50),
    DestinationAirport VARCHAR(50),
    Distance INT,
    FlightTime INTERVAL);
-- Create staging table for Aircraft
CREATE TABLE Staging_Aircraft (
    AircraftID INT,
    Manufacturer VARCHAR(50),
    Model VARCHAR(50),
    Capacity INT);
-- Create staging table for Passenger
CREATE TABLE Staging_Passenger (
    PassengerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Email VARCHAR(100));
-- Create staging table for Service
CREATE TABLE Staging_Service (
    ServiceID INT,
    ServiceType VARCHAR(50),
    ServiceDescription TEXT);
-- Create staging table for Agent
CREATE TABLE Staging_Agent (
    AgentID INT,
    AgentName VARCHAR(100),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100));
-- Create staging table for Customer Inquiry
CREATE TABLE Staging_CustomerInquiry (
    InquiryID INT,
    PassengerID INT,
    InquiryDate DATE,
    InquiryDescription TEXT);
-- Create staging table for Flight
CREATE TABLE Staging_Flight (
    FlightID INT,
    RouteID INT,
    AircraftID INT,
    FlightDate DATE,
    DepartureTime TIMESTAMP,
    ArrivalTime TIMESTAMP,
    FlightStatus VARCHAR(50));
-- Create staging table for Transactions
CREATE TABLE Staging_Transactions (
    TransactionID INT,
    FlightID INT,
    PassengerID INT,
    AgentID INT,
    TransactionDate TIMESTAMP,
    Amount DECIMAL(10,2),
    PaymentMethod VARCHAR(50));

-- Part 4: Extracting data from OLTP and loading to staging tables
INSERT INTO staging_agent
SELECT * FROM public.agent;

INSERT INTO staging_aircraft
SELECT * FROM public.aircraft;

INSERT INTO staging_customerinquiry
SELECT * FROM public.customerinquiry;
INSERT INTO staging_flight
SELECT * FROM public.flight;

INSERT INTO staging_flightroute
SELECT * FROM public.flightroute;

INSERT INTO staging_passenger
SELECT * FROM public.passenger;

INSERT INTO staging_service
SELECT * FROM public.service;

INSERT INTO staging_transactions
SELECT * FROM public.transactions;

-- This query will display the row counts for all tables in the airline database
SELECT 'agent' AS table_name, COUNT(*) AS row_count FROM agent
UNION ALL
SELECT 'aircraft' AS table_name, COUNT(*) AS row_count FROM aircraft
UNION ALL
SELECT 'customerinquiry' AS table_name, COUNT(*) AS row_count FROM customerinquiry
UNION ALL
SELECT 'flight' AS table_name, COUNT(*) AS row_count FROM flight
UNION ALL
SELECT 'flightroute' AS table_name, COUNT(*) AS row_count FROM flightroute
UNION ALL
SELECT 'passenger' AS table_name, COUNT(*) AS row_count FROM passenger
UNION ALL
SELECT 'transactions' AS table_name, COUNT(*) AS row_count FROM transactions
UNION ALL
SELECT 'staging_agent' AS table_name, COUNT(*) AS row_count FROM staging_agent
UNION ALL
SELECT 'staging_aircraft' AS table_name, COUNT(*) AS row_count FROM staging_aircraft
UNION ALL
SELECT 'staging_customerinquiry' AS table_name, COUNT(*) AS row_count FROM staging_customerinquiry
UNION ALL
SELECT 'staging_flight' AS table_name, COUNT(*) AS row_count FROM staging_flight
UNION ALL
SELECT 'staging_flightroute' AS table_name, COUNT(*) AS row_count FROM staging_flightroute
UNION ALL
SELECT 'staging_passenger' AS table_name, COUNT(*) AS row_count FROM staging_passenger
UNION ALL
SELECT 'staging_service' AS table_name, COUNT(*) AS row_count FROM staging_service
UNION ALL
SELECT 'staging_transactions' AS table_name, COUNT(*) AS row_count FROM staging_transactions;
