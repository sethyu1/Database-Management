-- Stored Procedure to schedule a device action
CREATE OR ALTER PROCEDURE ScheduleDeviceAction
    @deviceId VARCHAR(50),
    @startTime DATETIME,
    @endTime DATETIME,
    @action VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Start a transaction
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Check if the device exists
        IF EXISTS (SELECT 1 FROM Device WHERE device_id = @deviceId)
        BEGIN
            -- Insert a new schedule record
            INSERT INTO Schedule (device_id, start_time, end_time, action)
            VALUES (@deviceId, @startTime, @endTime, @action);

            -- If no errors occurred, commit the transaction
            COMMIT TRANSACTION;
            PRINT 'Device action scheduled successfully.';
        END
        ELSE
        BEGIN
            -- Rollback the transaction if the device doesn't exist
            ROLLBACK TRANSACTION;
            PRINT 'Device not found.';
        END
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of any errors
        ROLLBACK TRANSACTION;
        PRINT 'Error occurred while scheduling the device action.';
    END CATCH;
END;
GO

-- Insert sample data into Home table
INSERT INTO Home (home_id, address, city, province, owner_name)
VALUES 
(12, '123 Main St', 'Anytown', 'Anystate', 'John Doe');

-- Insert sample data into Device table
INSERT INTO Device (device_id, home_id, device_name, device_type, manufacturer, installation_date)
VALUES 
('MT01', 12, 'Thermostat', 'sensor', 'Nest', '2024-06-17'),
('MT02', 12, 'Camera', 'camera', 'Ring', '2024-06-17');

-- Schedule a device action
EXEC ScheduleDeviceAction
    @deviceId = 'MT01',
    @startTime = '2024-06-18 08:00:00',
    @endTime = '2024-06-18 10:00:00',
    @action = 'Turn on';

-- Check the Schedule table to see the scheduled action
SELECT * FROM Schedule;


