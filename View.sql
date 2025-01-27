DROP VIEW IF EXISTS AdminCustomers;
DROP VIEW IF EXISTS ActiveSchedules;

-- This view will only show customers who have an access level of 'admin'
CREATE VIEW AdminCustomers AS
SELECT 
    customer_id,
    home_id,
    first_name,
    last_name,
    access_level
FROM 
    Customer
WHERE 
    access_level = 'admin';


-- This view will only show schedules that are currently active, 
-- meaning the current time is between the schedule's start and end times

CREATE VIEW ActiveSchedules AS
SELECT 
    schedule_id,
    device_id,
    start_time,
    end_time,
    action
FROM 
    Schedule
WHERE 
    GETDATE() BETWEEN start_time AND end_time;


-- Query the AdminCustomers view
SELECT * FROM AdminCustomers;

-- Query the ActiveSchedules view
SELECT * FROM ActiveSchedules;
