-- Write a query (inner) to retrieve data from 3 or more tables
-- Query a customer of his home and personal info and divices he/she owns.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.access_level,
    d.device_id,
    d.device_name,
    d.device_type,
    h.address,
    h.city,
    h.province,
    h.owner_name
FROM Customer c
JOIN Home h ON c.home_id = h.home_id
JOIN Device d ON d.home_id = h.home_id

-- Write a query (outer join) to retrieve data from 3 or more tables
-- All devices with schedule and alerts
SELECT
	d.device_id,
    d.device_name,
    d.device_type,
    s.schedule_id,
    s.start_time,
    s.end_time,
    a.alert_id,
    a.alert_type,
    a.alert_message,
    a.alert_time
FROM 
    Device d
LEFT JOIN 
    Schedule s ON d.device_id = s.device_id
LEFT JOIN 
    Alert a ON d.home_id = a.home_id;

-- Write a non-correlated subquery
-- SELECT the latest installed camera id and name.
SELECT
	device_id,
	device_name
FROM
	Device
WHERE
	device_type = 'camera'
	AND installation_date = (
		SELECT MAX(installation_date)
		FROM Device
		WHERE device_type = 'camera'
	);

-- Write a correlated subquery
-- Select device that has alerts.
SELECT
    d.device_id,
    d.device_name
FROM
    Device d
WHERE
    d.device_id IN (
        SELECT DISTINCT a.device_id
        FROM Alert a
        WHERE a.device_id = d.device_id
    );

-- Aggregate the data in some way
-- Select decive and its total number, earliest and laatest installation.
SELECT
    device_type,
    COUNT(*) AS device_count,
    MIN(installation_date) AS earliest_installation,
    MAX(installation_date) AS latest_installation
FROM
    Device
GROUP BY
    device_type;

