-- Insert data into Home table
INSERT INTO Home (home_id, address, city, province, owner_name)
VALUES
    (1, '123 Main St', 'Anytown', 'Anystate', 'John Doe'),
    (2, '456 Elm St', 'Otherville', 'Otherstate', 'Jane Smith'),
    (3, '789 Oak St', 'Sometown', 'Somestate', 'Alice Brown'),
    (4, '101 Pine St', 'Thistown', 'Thatstate', 'Bob White'),
    (5, '202 Cedar St', 'Yourtown', 'Yourstate', 'Eve Black');

-- Insert data into Customer table
INSERT INTO Customer (customer_id, home_id, first_name, last_name, password, access_level)
VALUES
    (1, 1, 'Alice', 'Johnson', 'password1', 'admin'),
    (2, 2, 'Bob', 'Williams', 'password2', 'user'),
    (3, 3, 'Charlie', 'Brown', 'password3', 'user'),
    (4, 4, 'Dave', 'White', 'password4', 'user'),
    (5, 5, 'Eve', 'Black', 'password5', 'admin');

-- Insert data into Device table
INSERT INTO Device (device_id, home_id, device_name, device_type, manufacturer, installation_date)
VALUES
    ('D001', 1, 'Living Room Light', 'light', 'LightCo', '2023-01-15'),
    ('D002', 1, 'Front Door Lock', 'lock', 'SecureTech', '2023-02-10'),
    ('D003', 2, 'Backyard Camera', 'camera', 'CamCorp', '2023-03-20'),
    ('D004', 2, 'Thermostat', 'sensor', 'ThermoInc', '2023-04-05'),
    ('D005', 3, 'Garage Door Opener', 'lock', 'GarageMaster', '2023-05-12'),
    ('D006', 4, 'Kitchen Light', 'light', 'BrightHome', '2023-06-18'),
    ('D007', 5, 'Living Room Camera', 'camera', 'SafeView', '2023-07-22'),
    ('D008', 5, 'Smart Doorbell', 'sensor', 'RingCo', '2023-08-30');

-- Insert data into Schedule table (example of generating multiple records)
DECLARE @i INT = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO Schedule (device_id, start_time, end_time, action)
    VALUES
        ('D001', DATEADD(day, @i, '2023-01-15 08:00:00'), DATEADD(day, @i, '2023-01-15 09:00:00'), 'Turn On'),
        ('D002', DATEADD(day, @i, '2023-02-10 18:00:00'), DATEADD(day, @i, '2023-02-10 18:30:00'), 'Lock Front Door'),
        ('D003', DATEADD(day, @i, '2023-03-20 10:00:00'), DATEADD(day, @i, '2023-03-20 11:00:00'), 'Start Recording');
    SET @i = @i + 1;
END;

-- Insert data into Alert table (example of generating multiple records)
DECLARE @j INT = 1;
WHILE @j <= 100
BEGIN
    INSERT INTO Alert (home_id, device_id, alert_type, alert_message, alert_time)
    VALUES
        (1, 'D001', 'Security Alert', 'Motion detected in living room', DATEADD(day, @j, '2023-01-15 21:45:00')),
        (2, 'D003', 'Camera Alert', 'Package delivered in backyard', DATEADD(day, @j, '2023-03-20 12:00:00'));
    SET @j = @j + 1;
END;
