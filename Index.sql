-- This index can improve the performance of queries 
-- that involve filtering or joining the Customer table based on the home_id column. 
-- Since the home_id column is a foreign key referencing the Home table, 
--  it is likely that queries will often need to retrieve customers associated 
-- with a specific home or perform joins between the Customer and Home tables. 
-- By creating an index on the home_id column, 
-- the database can quickly locate the relevant rows without having to perform a full table scan.
CREATE INDEX idx_Customer_home_id ON Customer (home_id);

-- This index can enhance the performance of queries that search for devices based on their names. 
-- For example, if you need to retrieve information about a specific device by its name, 
-- the index can help the database locate the relevant rows efficiently. 
-- Indexes are particularly useful when dealing with large tables 
-- and when the indexed column is frequently used in WHERE, JOIN, or ORDER BY clauses.
CREATE INDEX idx_Device_device_name ON Device (device_name);

