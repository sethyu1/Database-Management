-- All associated schedules are also deleted from the Schedule table to maintain data integrity
-- when a device is deleted from the "Device" table.


CREATE OR ALTER TRIGGER DeviceDeleteTrigger
ON Device
AFTER DELETE
AS
BEGIN
    DECLARE @DeviceID VARCHAR(50);
    SELECT @DeviceID = deleted.device_id FROM deleted;

    -- Delete associated schedules
    DELETE FROM Schedule
    WHERE device_id = @DeviceID;
END;