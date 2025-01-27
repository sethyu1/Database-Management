-- This trigger will automatically create a new entry in the Alert table 
-- whenever a new device is inserted into the Device table or an existing device is updated. 
-- This can be useful for logging and tracking device-related events or changes.

CREATE OR ALTER TRIGGER LogDeviceAlerts
ON Device
AFTER INSERT, UPDATE
AS
BEGIN
    -- Insert log for new devices
    INSERT INTO Alert (home_id, device_id, alert_type, alert_message, alert_time)
    SELECT 
        i.home_id, 
        i.device_id, 
        'NEW_DEVICE', 
        'New device ' + i.device_name + ' added', 
        GETDATE()
    FROM inserted i
    LEFT JOIN deleted d ON i.device_id = d.device_id
    WHERE d.device_id IS NULL;

    -- Insert log for updated devices
    INSERT INTO Alert (home_id, device_id, alert_type, alert_message, alert_time)
    SELECT 
        i.home_id, 
        i.device_id, 
        'UPDATE_DEVICE', 
        'Device ' + COALESCE(NULLIF(i.device_name, d.device_name), i.device_name) + ' updated', 
        GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.device_id = d.device_id;
END;

-- Example
-- Insert a new home
INSERT INTO Home (home_id, address, city, province, owner_name)
VALUES (12, '123 Main St', 'Anytown', 'Anystate', 'John Doe');

-- Insert a new device
INSERT INTO Device (device_id, home_id, device_name, device_type, manufacturer, installation_date)
VALUES ('MT01', 12, 'Thermostat', 'sensor', 'Nest', '2024-06-17');

-- Check the Alert table to see the log entry for the new device
SELECT * FROM Alert;

-- Update the device
UPDATE Device
SET device_name = 'Smart Thermostat'
WHERE device_id = 'MT01';

-- Check the Alert table to see the log entry for the updated device
SELECT * FROM Alert;


