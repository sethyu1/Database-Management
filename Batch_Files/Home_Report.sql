-- home_report.sql
USE SmartHomeAutomation;

SET NOCOUNT ON

PRINT $(home_id)

SELECT
    h.home_id,
    h.address,
    h.city,
    h.province,
    h.owner_name,
    COUNT(c.customer_id) AS number_of_customers,
    COUNT(d.device_id) AS number_of_devices,
    AVG(a.alert_count) AS average_alerts
FROM
    Home h
LEFT JOIN
    Customer c ON h.home_id = c.home_id
LEFT JOIN
    Device d ON h.home_id = d.home_id
LEFT JOIN (
    SELECT
        device_id,
        COUNT(alert_id) AS alert_count
    FROM
        Alert
    GROUP BY
        device_id
) a ON d.device_id = a.device_id
WHERE h.home_id = $(home_id)
GROUP BY
    h.home_id, h.address, h.city, h.province, h.owner_name;
