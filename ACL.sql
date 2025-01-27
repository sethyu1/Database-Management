-- Drop User if they exist
DROP USER IF EXISTS AdminUser1;
DROP USER IF EXISTS SupportUser1;
DROP USER IF EXISTS SalesUser1;

-- Drop Login if they exist
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'AdminUser')
 BEGIN
	DROP LOGIN AdminUser;
 END;
 
 IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'SupportUser')
 BEGIN
	DROP LOGIN SupportUser;
 END; 

 IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'SalesUser')
 BEGIN
	DROP LOGIN SalesUser;
 END;

 -- Drop if they exists
ALTER ROLE Admin DROP MEMBER AdminUser1;
ALTER ROLE Support DROP MEMBER SupportUser1;
ALTER ROLE Sales DROP MEMBER SalesUser1;

DROP ROLE IF EXISTS Admin;
DROP ROLE IF EXISTS Support;
DROP ROLE IF EXISTS Sales;

-- Create Admin role
CREATE ROLE Admin;

-- Create Support role
CREATE ROLE Support;

-- Create Sales role
CREATE ROLE Sales;

-- Grant permissions to Admin role
GRANT SELECT, INSERT, UPDATE, DELETE ON Home TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Customer TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Device TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Schedule TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Alert TO Admin;

-- Grant permissions to Support role
GRANT SELECT ON Home TO Support;
GRANT SELECT ON Customer TO Support;
GRANT SELECT ON Device TO Support;
GRANT SELECT ON Schedule TO Support;
GRANT SELECT ON Alert TO Support;

-- Grant permissions to Sales role
GRANT SELECT ON Home TO Sales;
GRANT SELECT ON Customer TO Sales;
GRANT SELECT ON Device TO Sales;
GRANT SELECT ON Schedule TO Sales;
GRANT SELECT ON Alert TO Sales;

-- Create Admin user
CREATE LOGIN AdminUser WITH PASSWORD = 'StrongPassword';
CREATE USER AdminUser1 FOR LOGIN AdminUser;
EXEC sp_addrolemember 'Admin', 'AdminUser1';

-- Create Support user
CREATE LOGIN SupportUser WITH PASSWORD = 'SecurePassword';
CREATE USER SupportUser1 FOR LOGIN SupportUser;
EXEC sp_addrolemember 'Support', 'SupportUser1';

-- Create Sales user
CREATE LOGIN SalesUser WITH PASSWORD = 'SalesPassword';
CREATE USER SalesUser1 FOR LOGIN SalesUser;
EXEC sp_addrolemember 'Sales', 'SalesUser1';

-- Impersonate support user
EXECUTE AS USER = 'SupportUser1'

-- Select- Success
SELECT * FROM Home

-- Insert - Fail
INSERT INTO Home (home_id, address, city, province, owner_name)
VALUES (1333, '123 Main St', 'Anytown', 'Anystate', 'John Doe');

-- Cleanup
REVERT;


-- Impersonate admin
EXECUTE AS USER = 'AdminUser1'

-- Select- Success
SELECT * FROM Home

-- Insert - Success
INSERT INTO Home (home_id, address, city, province, owner_name)
VALUES (1333, '123 Main St', 'Anytown', 'Anystate', 'John Doe');

-- Cleanup
REVERT;
