-- Automate this report to be generated on a schedule

-- NEW JOB
-- Name: Automatically Generate Home Report

-- Step:
-- Name: Run home_report.sql

sqlcmd -S SethCanada\GINSENG -d SmartHomeAutomation -U sa -P 147741 -i "E:\RRC polytech\Intersession\Database Management 2\Final_Project\Auto_Report\Auto-Report.sql" -v home_id=1

-- Schedule:
-- Occurs every week on Firday at 1:00 AM
