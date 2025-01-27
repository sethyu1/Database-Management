-- This function will take a home_id and a date range (start_date and end_date) as input 
-- and return the total number of alerts generated for that home within the specified date range.

CREATE OR ALTER FUNCTION GetAlertCountForHome (
	@home_id INT,
	@start_date DATETIME,
	@end_date DATETIME
)
RETURNS INT
AS
BEGIN
	DECLARE @alert_count INT;

	SELECT @alert_count = COUNT(*)
	FROM Alert
	WHERE home_id = @home_id
	 AND alert_time BETWEEN @start_date AND @end_date;

	RETURN @alert_count;
END;


-- Insert sample data into Home table
INSERT INTO Home (home_id, address, city, province, owner_name)
VALUES 
(12, '123 Main St', 'Anytown', 'Anystate', 'John Doe'),
(13, '456 Elm St', 'Othertown', 'Otherstate', 'Jane Doe');

-- Insert sample data into Alert table
INSERT INTO Alert (home_id, device_id, alert_type, alert_message, alert_time)
VALUES 
(12, 'MT01', 'NEW_DEVICE', 'New device Thermostat added', '2024-06-17 09:00:00'),
(12, 'MT01', 'UPDATE_DEVICE', 'Device Thermostat updated', '2024-06-17 10:00:00'),
(12, 'MT01', 'ALERT', 'Motion detected', '2024-06-18 11:00:00'),
(13, 'MT02', 'ALERT', 'Smoke detected', '2024-06-17 12:00:00');


-- Get the count of alerts for home_id 12 between '2024-06-17' and '2024-06-18'
SELECT 
	12 AS home_id, 
	dbo.GetAlertCountForHome(12, '2024-06-17 00:00:00', '2024-06-18 23:59:59') AS AlertCount;

-- Get the count of alerts for all homes between '2024-06-17' and '2024-06-18'
SELECT 
    h.home_id,
    dbo.GetAlertCountForHome(h.home_id, '2024-06-17 00:00:00', '2024-06-18 23:59:59') AS AlertCount
FROM 
    Home h;