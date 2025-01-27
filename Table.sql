-- Create the database
CREATE DATABASE SmartHomeAutomation;
Go

-- Use the database
USE SmartHomeAutomation;
GO

-- Drop tables if they exist
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Alert;
DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS Device;
DROP TABLE IF EXISTS Home;

-- Create Home table
CREATE TABLE Home (
	home_id INT NOT NULL,
	address VARCHAR(50) NOT NULL,
	city VARCHAR(50),
	province VARCHAR(50),
	owner_name VARCHAR(50),
	CONSTRAINT PK_Home
		PRIMARY KEY (home_id)
	);

-- Create Customer table
CREATE TABLE Customer (
	customer_id INT NOT NULL,
	home_id INT NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	password VARCHAR(50) NOT NULL,
	access_level VARCHAR(20) NOT NULL,
	CONSTRAINT PK_User
		PRIMARY KEY (customer_id),
	CONSTRAINT FK_User
		FOREIGN KEY (home_id)
		REFERENCES Home (home_id)
		ON DELETE CASCADE
	);

-- Create Device table
CREATE TABLE Device (
	device_id VARCHAR(50) NOT NULL,
	home_id INT NOT NULL,
	device_name VARCHAR(50) NOT NULL,
	device_type VARCHAR(10) NOT NULL,
	manufacturer VARCHAR(50),
	installation_date DATE
	CONSTRAINT PK_Device
		PRIMARY KEY (device_id),
	CONSTRAINT FK_Device
		FOREIGN KEY (home_id)
		REFERENCES Home (home_id)
		ON DELETE CASCADE,
	CONSTRAINT CHK_DeviceType
		CHECK (device_type IN ('light', 'camera', 'sensor', 'lock', 'other'))
	);

-- Create Schedule table
CREATE TABLE Schedule (
	schedule_id INT NOT NULL IDENTITY(1,1),
	device_id VARCHAR(50) NOT NULL,
	start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
	action VARCHAR(50)
	CONSTRAINT PK_Schedule
		PRIMARY KEY (schedule_id),
	CONSTRAINT FK_Schedule
		FOREIGN KEY (device_id)
		REFERENCES Device (device_id)
		ON DELETE CASCADE
	);

-- Create Alert table
CREATE TABLE Alert (
	alert_id INT NOT NULL IDENTITY(1,1),
	home_id INT NOT NULL,
	device_id VARCHAR(50) NOT NULL,
	alert_type VARCHAR(50),
	alert_message VARCHAR(50),
	alert_time DATETIME
	CONSTRAINT PK_Alert
		PRIMARY KEY (alert_id),
	CONSTRAINT FK_Alert
		FOREIGN KEY (home_id)
		REFERENCES Home (home_id)
		ON DELETE CASCADE
	);